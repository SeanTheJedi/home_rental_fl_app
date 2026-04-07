class Property {
  final String id;
  final String title;
  final String location;
  final double price;
  final double averageRating;
  final String imageUrl;
  final int bedrooms;
  final int bathrooms;
  final String description;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.averageRating,
    required this.imageUrl,
    this.bedrooms = 1,
    this.bathrooms = 1,
    this.description = '',
  });

  // Dummy data to test the UI before Firebase integration
  static List<Property> dummyProperties = [
    Property(
      id: '1',
      title: 'Modern Blue Apartment',
      location: 'San Francisco, CA',
      price: 1200,
      averageRating: 4.8,
      bedrooms: 2,
      bathrooms: 2,
      imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      description: 'A beautiful modern apartment located in the heart of the city.',
    ),
    Property(
      id: '2',
      title: 'Cozy Wood Cabin',
      location: 'Lake Tahoe, NV',
      price: 850,
      averageRating: 4.5,
      bedrooms: 3,
      bathrooms: 1,
      imageUrl: 'https://images.unsplash.com/photo-1501183638710-841dd1904471?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      description: 'Perfect weekend getaway cabin with a stunning view of the lake.',
    ),
    Property(
      id: '3',
      title: 'Luxury Villa',
      location: 'Beverly Hills, CA',
      price: 4500,
      averageRating: 5.0,
      bedrooms: 5,
      bathrooms: 4,
      imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      description: 'Experience true luxury in this expansive villa with a private pool.',
    ),
    Property(
      id: '4',
      title: 'Minimalist Studio',
      location: 'Seattle, WA',
      price: 950,
      averageRating: 4.2,
      bedrooms: 1,
      bathrooms: 1,
      imageUrl: 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      description: 'Clean and quiet minimalist studio perfect for young professionals.',
    ),
  ];
}