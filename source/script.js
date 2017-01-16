$(function() {
    $(window).on('resize', function () {
        var height = window.innerHeight

        $('#map').height(height / 3)
        $('#content').css('margin-top', height / 3 + 'px')

        if ($('#image').length) {
            $('#image').height(height)
            $('#content').css('min-height', (height / 3) * 1.9 + 'px')
            $('#content').css('margin-bottom', height + 100 + 'px')
        } else {
            $('#content').css('border-bottom', 'none')
        }
    }).resize()

    $(window).on('scroll', function () {
        var docViewTop = $(window).scrollTop()

        if (docViewTop >= 0) {
            $('#map-container').css('top', docViewTop * -0.6 + 'px')
            $('#content').css('border-top-width', '1px')
        } else {
            $('#map').css('top', '0px')
            $('#map-container').css('top', '0px')
            $('#content').css('border-top-width', '0px')
        }

        if ($('#footer').length) {
            var docViewBottom = docViewTop + window.innerHeight
            var footerTop = $('#footer').offset().top

            if (footerTop < docViewBottom) {
                $('#image').css('bottom', docViewBottom - footerTop + 'px')
            } else {
                $('#image').css('bottom', '0px')
            }
        }
    }).scroll()

    var multiplePointers = $('.list-item').length > 1
    var bounds = new google.maps.LatLngBounds()
    var infowindow = new google.maps.InfoWindow()
    var map = new google.maps.Map(document.getElementById('map'), {
        center: {
            lat: parseFloat($('.list-item').data('geo').split(',')[0]),
            lng: parseFloat($('.list-item').data('geo').split(',')[1])
        },
        zoom: 11,
        scrollwheel: false,
        mapTypeControl: false,
        streetViewControl: false,
        rotateControl: false,
        styles: [
            {
                'featureType': 'poi.business',
                'stylers': [
                    {
                        'visibility': 'off'
                    }
                ]
            },
            {
                'featureType': 'road',
                'elementType': 'labels.icon',
                'stylers': [
                    {
                        'visibility': 'off'
                    }
                ]
            },
            {
                'featureType': 'transit',
                'stylers': [
                    {
                        'visibility': 'off'
                    }
                ]
            }
        ]
    })

    $('.list-item').each(function () {
        var position = $(this).data('geo')
        if (position) {
            var info = '<p><a href="' + $(this).attr('href') + '"><strong>' + $(this).text() + '</strong></a></p><p>' + $(this).data('info') + '</p>'

            var marker = new google.maps.Marker({
                position: {
                    lat: parseFloat(position.split(',')[0]),
                    lng: parseFloat(position.split(',')[1]),
                },
                title: $(this).text(),
                clickable: multiplePointers,
                map: map
            })

            if (multiplePointers) {
                marker.addListener('click', function() {
                    infowindow.setContent(info)
                    infowindow.open(map, this)
                })
                bounds.extend(marker.getPosition())
                map.fitBounds(bounds)
            }
        }
    })
})
