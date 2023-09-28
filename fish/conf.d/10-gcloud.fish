set -gx GCLOUD_SDK_ROOT "/usr/lib/google-cloud-sdk"
fish_add_path -g $GCLOUD_SDK_ROOT/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$GCLOUD_SDK_ROOT/path.fish.inc" ]
  . "$GCLOUD_SDK_ROOT/path.fish.inc"
end
