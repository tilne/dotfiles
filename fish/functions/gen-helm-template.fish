function gen-helm-template
    # intended to be run from top-level of repo containing a .helm directory
    set template_name (basename (pwd))
    pushd .helm
    helm dependency update && helm template $template_name . -f values.yaml
    popd
end
