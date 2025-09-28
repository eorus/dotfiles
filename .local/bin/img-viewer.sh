#!/usr/bin/env bash
# Enhanced SXIV/FEH wrapper
# Opens folders in thumbnail mode
# Opens single image and all other images in folder starting at that image

if command -v sxiv >/dev/null 2>&1; then
    target="${@: -1}"  # last argument

    if [ -d "$target" ] || [ -h "$target" ]; then
        # Folder or symlink → open all images in thumbnail mode
        sxiv -t "$target"/*
    elif [ -f "$target" ]; then
        # Single image → open all images in its folder, start at this image
        folder=$(dirname "$target")
        images=("$folder"/*.{jpg,jpeg,JPG,JPEG,png,webp,raf,RAF})
        sxiv -t -n "$target" "${images[@]}"
    else
        echo "Target not found: $target"
        exit 1
    fi

elif command -v feh >/dev/null 2>&1; then
    # fallback to feh
    feh "$@"
else
    echo "Please install SXIV or FEH!"
    exit 1
fi
