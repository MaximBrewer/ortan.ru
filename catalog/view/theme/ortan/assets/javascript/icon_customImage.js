ymaps.ready(function () {
    var myMap = new ymaps.Map('map', {
            center: [55.80207736206094, 37.37222915166692],
            zoom: 12
        }, {
            searchControlProvider: 'yandex#search'
        }),

        myPlacemark = new ymaps.Placemark(myMap.getCenter(), {
            hintContent: '',
            balloonContent: ''
        }, {
            // Опции.
            // Необходимо указать данный тип макета.
            iconLayout: 'default#image',
            // Своё изображение иконки метки.
            iconImageHref: 'assets/images/icon-pin.svg',
            // Размеры метки.
            iconImageSize: [25, 30],
            // Смещение левого верхнего угла иконки относительно
            // её "ножки" (точки привязки).
            iconImageOffset: [-4, -30]
        });

    myMap.geoObjects
        .add(myPlacemark);
});
ymaps.ready(function () {
    var myMap = new ymaps.Map('map2', {
            center: [55.80207736206094, 37.37222915166692],
            zoom: 12
        }, {
            searchControlProvider: 'yandex#search'
        }),

        myPlacemark = new ymaps.Placemark(myMap.getCenter(), {
            hintContent: '',
            balloonContent: ''
        }, {
            // Опции.
            // Необходимо указать данный тип макета.
            iconLayout: 'default#image',
            // Своё изображение иконки метки.
            iconImageHref: 'assets/images/icon-pin.svg',
            // Размеры метки.
            iconImageSize: [25, 30],
            // Смещение левого верхнего угла иконки относительно
            // её "ножки" (точки привязки).
            iconImageOffset: [-4, -30]
        });

    myMap.geoObjects
        .add(myPlacemark);
});
ymaps.ready(function () {
    var myMap = new ymaps.Map('map3', {
            center: [55.80207736206094, 37.37222915166692],
            zoom: 12
        }, {
            searchControlProvider: 'yandex#search'
        }),

        myPlacemark = new ymaps.Placemark(myMap.getCenter(), {
            hintContent: '',
            balloonContent: ''
        }, {
            // Опции.
            // Необходимо указать данный тип макета.
            iconLayout: 'default#image',
            // Своё изображение иконки метки.
            iconImageHref: 'assets/images/icon-pin.svg',
            // Размеры метки.
            iconImageSize: [25, 30],
            // Смещение левого верхнего угла иконки относительно
            // её "ножки" (точки привязки).
            iconImageOffset: [-4, -30]
        });

    myMap.geoObjects
        .add(myPlacemark);
});