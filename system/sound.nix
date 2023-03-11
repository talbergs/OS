_:

{

  # Note: PipeWire with the native pw-cli, pw-mon and pw-top
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Many apps uses jack API
    # TODO: create an eww widget that will live transcribe (maybe also audio recording) speech. For reference, notes, grep.
    jack.enable = true;
  };

}
