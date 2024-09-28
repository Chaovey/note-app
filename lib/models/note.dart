class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}


List<Note> sampleNotes = [
Note(
  id: 1,
  title: 'Daily Affirmations',
  content:
      '1. I am strong and capable.\n2. I can achieve anything I set my mind to.\n3. I am worthy of love and respect.\n4. I choose happiness today.',
  modifiedTime: DateTime(2023,6,1,8,15),
),
Note(
  id: 2,
  title: 'Travel Checklist',
  content:
      '1. Passport\n2. Plane tickets\n3. Hotel reservation\n4. Travel insurance\n5. Toiletries\n6. Phone charger',
  modifiedTime: DateTime(2023,4,2,9,20),
),
Note(
  id: 3,
  title: 'Shopping List',
  content:
      '1. Milk\n2. Eggs\n3. Bread\n4. Bananas\n5. Chicken breast\n6. Pasta\n7. Olive oil\n8. Tomatoes',
  modifiedTime: DateTime(2023,7,1,10,25),
),
Note(
  id: 4,
  title: 'Weekend Chores',
  content:
      '1. Clean the house\n2. Mow the lawn\n3. Do the laundry\n4. Grocery shopping\n5. Wash the car',
  modifiedTime: DateTime(2023,8,1,14,45),
),
Note(
  id: 5,
  title: 'Coding Goals',
  content:
      '1. Learn Dart and Flutter\n2. Build a portfolio app\n3. Contribute to an open-source project\n4. Master state management\n5. Create a personal website',
  modifiedTime: DateTime(2023,9,1,11,30),
),
Note(
  id: 6,
  title: 'Party Planning',
  content:
      '1. Send invitations\n2. Order catering\n3. Decorate the venue\n4. Create a playlist\n5. Plan games and activities',
  modifiedTime: DateTime(2023,8,15,13,50),
),
Note(
  id: 7,
  title: 'Favorite Movies',
  content:
      '1. The Shawshank Redemption\n2. Inception\n3. The Dark Knight\n4. Forrest Gump\n5. The Matrix',
  modifiedTime: DateTime(2023,3,3,17,22),
),
Note(
  id: 8,
  title: 'Gift Ideas for Dad',
  content:
      '1. Toolset\n2. Leather wallet\n3. BBQ grill set\n4. Personalized mug\n5. Smartwatch',
  modifiedTime: DateTime(2023,4,7,18,30),
),
Note(
  id: 9,
  title: 'Books to Recommend',
  content:
      '1. The Alchemist\n2. Sapiens\n3. The Power of Habit\n4. Atomic Habits\n5. The Subtle Art of Not Giving a F*ck',
  modifiedTime: DateTime(2023,5,11,19,55),
),
Note(
  id: 10,
  title: 'Places to Visit',
  content:
      '1. Santorini, Greece\n2. Paris, France\n3. Kyoto, Japan\n4. New York City, USA\n5. Cape Town, South Africa',
  modifiedTime: DateTime(2023,6,21,16,40),
),
];
