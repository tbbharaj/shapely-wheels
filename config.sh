# Custom utilities for Rasterio wheels.
#
# Test for OSX with [ -n "$IS_OSX" ].


function build_geos {
    build_simple geos $GEOS_VERSION https://download.osgeo.org/geos tar.bz2
}


function pre_build {
    start_spinner
    suppress build_geos
    stop_spinner
}


function run_tests {
    if [ -n "$IS_OSX" ]; then
        export PATH=$PATH:${BUILD_PREFIX}/bin
        export LC_ALL=en_US.UTF-8
        export LANG=en_US.UTF-8
    else
        export LC_ALL=C.UTF-8
        export LANG=C.UTF-8
    fi
    mkdir -p /tmp/shapely && cp -R ../Shapely/tests /tmp/shapely
    cd /tmp/shapely && python -m pytest -vv -k "not test_fallbacks" tests
}
