. config.base.sh

base_pkgs+=(
	firefox # 192M
)
extra_build_pkgs+=(
	mesa
	portfolio pmos-tweaks mobile-config-firefox
	megapixels callaudiod sofia-sip gnome-calls libphonenumber purism-chatty
)
extra_install_pkgs+=(
	mesa-vulkan-freedreno mesa-vulkan-overlay-layer mesa-tools
	portfolio pmos-tweaks mobile-config-firefox
	megapixels gnome-calls purism-chatty
)
unset overlays[-1] # drop somainline overlay to apply it after others
overlays+=(ui-gnome pipewire-audio somainline)
img_name_format="${img_name_format/-base/-gnome}"
