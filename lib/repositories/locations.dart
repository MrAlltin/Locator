class GetLocations {
  List get_locations() {
    final List<Map<String, dynamic>> locations = [
      {
        'name': 'Экотропа "У Лукоморья"',
        'coordinates': '60.004455, 30.036561',
        'image': 'assets/images/luk.jpg'
      },
      {
        'name': 'Экотропа "У Васи"',
        'coordinates': '10.004455, 20.036561',
        'image': 'assets/images/luk.jpg'
      },
      {
        'name': 'Экотропа "У Славы"',
        'coordinates': '30.004455, 40.036561',
        'image': 'assets/images/luk.jpg'
      },
      {
        'name': 'Экотропа "У Деда"',
        'coordinates': '50.004455, 60.036561',
        'image': 'assets/images/luk.jpg'
      },
    ];
    return locations;
  }
}
