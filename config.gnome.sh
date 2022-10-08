. config.base.sh

base_pkgs+=(
	firefox mobile-config-firefox # 192M
	dejavu-fonts-ttf # for proper font rendering in ff :)
)
extra_build_pkgs+=(
	mesa
	portfolio pmos-tweaks
	megapixels callaudiod feedbackd sofia-sip gnome-calls purism-chatty
)
extra_install_pkgs+=(
	mesa-vulkan-freedreno mesa-vulkan-overlay-layer mesa-tools
	portfolio pmos-tweaks
	megapixels gnome-calls purism-chatty
)
unset overlays[-1] # drop somainline overlay to apply it after others
overlays+=(
	ui-gnome
	firefox-wayland
	pipewire-audio
	qcom_spmi_haptics-feedbackd
	somainline
)
enable_sv=("${enable_sv[@]/buffyboard}") # drop buffyboard sv to avoid input issues in GNOME
img_name_format="${img_name_format/-base/-gnome}"
