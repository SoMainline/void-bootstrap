. config.base.sh

base_pkgs+=(
	firefox mobile-config-firefox # 192M
	dejavu-fonts-ttf # for proper font rendering in ff :)
	noto-fonts-emoji # for emoji keyboard on gnome shell mobile
	Vulkan-Tools glxinfo mesa-demos # for vkcube and other GPU tools
	waydroid # for running Android apps
)
extra_build_pkgs+=(
	mesa
	mutter gnome-shell # gnome shell mobile
	portfolio pmos-tweaks
	megapixels callaudiod feedbackd sofia-sip gnome-calls purism-chatty
)
extra_install_pkgs+=(
	mesa-vulkan-freedreno mesa-vulkan-overlay-layer mesa-tools
	portfolio pmos-tweaks
	megapixels gnome-calls purism-chatty
)
overlays=(
	# drop somainline overlay temporarily to apply it after EVERYTHING else
	${overlays[@]/somainline}

	ui-gnome
	firefox-wayland
	pulseaudio
	qcom_spmi_haptics-feedbackd

	somainline
)
enable_sv=(
	# drop buffyboard sv to avoid potential input issues in GNOME (https://gitlab.com/cherrypicker/buffyboard/-/issues/21)
	"${enable_sv[@]/buffyboard}"

	waydroid-container
)
img_name_format="${img_name_format/-base/-gnome}"
