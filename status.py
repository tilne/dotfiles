#!/usr/bin/env python
"""Edit and manipulate daily status reports."""

import argparse
import logging
import os
import re
import subprocess as sp
import sys
from enum import Enum
from datetime import datetime, timedelta

import clipboard

STATUS_REPORT_DIR = os.path.expanduser("~/repos/markdown-scratch/status-reports")


class Actions(Enum):
    """enumeration of valid actions."""
    COPY = "copy"
    CREATE = "create"
    EDIT = "edit"
    PRINT = "print"


def parse_args():
    """Return argparse.Namespace representing args passed on command line."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "action",
        type=Actions,
        nargs="?",
        default=Actions.EDIT,
        help=f"valid choices: {[action.value for action in list(Actions)]}",
    )
    # TODO: use subcommands instead so the following optino can only be used
    #       when the 'copy' action is specified.
    parser.add_argument(
        "--copy-todays-status",
        action="store_true",
        help="Copy today's status report instead of the previous working day's",
    )
    return parser.parse_args()


def get_status_report_for_date(date):
    """Return path to status report for given date."""
    return f"{STATUS_REPORT_DIR}/status-reports-{date.strftime('%Y%m%d')}.md"


def get_status_report_for_today():
    """Return path to today's status report."""
    today = datetime.now().date()
    iso_weekday = today.isoweekday()
    if iso_weekday in [6, 0]:
        # today is saturday or sunday. use friday's report.
        report_date = today - timedelta(days=(iso_weekday - 5) % 7)
    else:
        report_date = today
    return get_status_report_for_date(report_date)


def get_status_report_for_previous_workday():
    """Return path to previous workday's status report."""
    today = datetime.now().date()
    iso_weekday = today.isoweekday()
    if iso_weekday in [0, 1]:
        # today is a sunday or monday, last workday was three days ago
        # TODO: account for holidays? oh god...
        last_workday = today - timedelta(days=iso_weekday + 2)
    else:
        last_workday = today - timedelta(days=1)
    return get_status_report_for_date(last_workday)


def edit_todays_status_report():
    """Edit today's status report."""
    todays_status_report = get_status_report_for_today()
    if not os.path.isfile(todays_status_report):
        sys.exit(f"status report for today doesn't yet exist at {todays_status_report}")
    logging.info(f"Editing {todays_status_report}")
    sp.run(f"{os.environ.get('EDITOR', 'vim')} {todays_status_report}".split(), check=False)


def parse_status_report(path):
    """Parse the status report at the given path."""
    date_of_status_report = get_date_of_status_report(path)
    month_of_status, day_of_status = date_of_status_report.month, date_of_status_report.day

    status_report = {}
    current_section = None
    current_section_lines = []
    with open(path) as status_file:
        for line in status_file:
            if new_section := line_is_start_of_new_section(line):
                if current_section:
                    status_report[current_section] = "\n".join(current_section_lines)
                if re.search(rf"{month_of_status}/{day_of_status}", new_section):
                    new_section = "status"
                current_section = new_section
                current_section_lines = []
            current_section_lines.append(line.rstrip())
    status_report[current_section] = "\n".join(current_section_lines) + "\n"
    return status_report


def create_todays_status_report():
    """Create today's status report by copying previous workday's into place."""
    today = datetime.now().date()
    todays_status_report = get_status_report_for_date(today)
    if os.path.isfile(todays_status_report):
        sys.exit(f"status report for today already exists at {todays_status_report}")
    previous_workday_status_report = get_status_report_for_previous_workday()
    if not os.path.isfile(previous_workday_status_report):
        sys.exit(f"status report for previous workday doesn't exist at {previous_workday_status_report}")
    previous_workday_status_report_dict = parse_status_report(previous_workday_status_report)
    sections_to_write = []
    for section_name, section_text in previous_workday_status_report_dict.items():
        if section_name != "status":  # Don't include previous workday's status
            sections_to_write.append(section_text)
    sections_to_write.append(f"# {today.month}/{today.day}\n")
    with open(todays_status_report, "w") as outfile:
        outfile.write("\n".join(sections_to_write))


def get_date_of_status_report(path):
    """Return the date for the status report in path as implied by the filename."""
    logging.debug(f"Extracting date from status report path {path}")
    date_string = re.search(r"status-reports-(\d{8}).md", path).group(1)
    logging.debug(f"Extracted this date from status report: {date_string}")
    return datetime.strptime(date_string, "%Y%m%d").date()


def line_is_start_of_new_section(line):
    """Return the section name that line represents the start of, otherwise None."""
    match = re.search(r"^#\s+(.*)", line)
    return match.group(1) if match else match


def copy_status_to_clipboard(today_instead_of_yesterday):
    """Copy the contents of previous workday's status report to the clipboard."""
    status_report_path = (
        get_status_report_for_today() if today_instead_of_yesterday else get_status_report_for_previous_workday()
    )
    if not os.path.isfile(status_report_path):
        sys.exit(f"status report for previous workday doesn't exist at {status_report_path}")
    status_report = parse_status_report(status_report_path)
    clipboard.copy(status_report.get("status"))


def print_path_to_todays_status_report():
    """Print the path to today's status report to stdout."""
    print(get_status_report_for_today())


def main():
    """Run the script."""
    if not os.path.isdir(STATUS_REPORT_DIR):
        sys.exit(f"Didn't find status report directory at {STATUS_REPORT_DIR}")
    args = parse_args()
    action_to_function = {
        Actions.COPY: (copy_status_to_clipboard, [args.copy_todays_status]),
        Actions.CREATE: (create_todays_status_report, []),
        Actions.EDIT: (edit_todays_status_report, []),
        Actions.PRINT: (print_path_to_todays_status_report, []),
    }
    action_function, args = action_to_function.get(args.action)
    action_function(*args)


if __name__ == "__main__":
    main()
