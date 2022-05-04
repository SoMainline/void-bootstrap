. config.base.sh

base_pkgs+=(
	firefox mobile-config-firefox # 192M
	dejavu-fonts-ttf # for proper font rendering in ff :)
)
extra_build_pkgs+=(
	mesa
	portfolio pmos-tweaks
	megapixels callaudiod sofia-sip gnome-calls purism-chatty
)
extra_install_pkgs+=(
	mesa-vulkan-freedreno mesa-vulkan-overlay-layer mesa-tools
	portfolio pmos-tweaks
	megapixels gnome-calls purism-chatty
)
unset overlays[-1] # drop somainline overlay to apply it after others
overlays+=(ui-gnome pipewire-audio somainline)
unset enable_sv[-1] # drop buffyboard sv to avoid input issues in GNOME
img_name_format="${img_name_format/-base/-gnome}"
