import '../models/form-models/form-data.dart';

const List<String> genders = [
  'Select Gender',
  'Male',
  'Female',
];

const List<String> castes = [
  'Select Cast',
  'General',
  'Kshatriya',
  'Vaishya',
  'Shudra',
  'None'
];

const List<String> time = [
  'AM',
  'PM',
];

List<String> generateHourList() {
  List<String> hours = [];

  for (int i = 0; i <= 12; i++) {
    hours.add(i
        .toString()
        .padLeft(2, '0')); // Ensures 2-digit format with leading zero
  }

  return hours;
}

List<String> generateMinutesList() {
  return List<String>.generate(
      60, (int index) => index.toString().padLeft(2, '0'));
}

//List<String> minutes = List.generate(60, (index) => (index + 1).toString());

List<String> days = List.generate(31, (index) => (index + 1).toString());

const List<String> months = [
  'Select Month',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

List<String> years =
    List.generate(2005 - 1940 + 1, (index) => (1940 + index).toString());

const List<String> ages = [
  'Select Age',
  '18 yrs',
  '19 yrs',
  '20 yrs',
  '21 yrs',
  '22 yrs',
  '23 yrs',
  '24 yrs',
  '25 yrs',
  '26 yrs',
  '27 yrs',
  '28 yrs',
  '29 yrs',
  '30 yrs',
  '31 yrs',
  '32 yrs',
  '33 yrs',
  '34 yrs',
  '35 yrs',
  '36 yrs',
  '37 yrs',
  '38 yrs',
  '39 yrs',
  '40 yrs',
  '41 yrs',
  '42 yrs',
  '43 yrs',
  '44 yrs',
  '45 yrs',
  '46 yrs',
  '47 yrs',
  '48 yrs',
  '49 yrs',
  '50 yrs',
  '51 yrs',
  '52 yrs',
  '53 yrs',
  '54 yrs',
  '55 yrs',
  '56 yrs',
  '57 yrs',
  '58 yrs',
  '59 yrs',
  '60 yrs',
  '61 yrs',
  '62 yrs',
  '63 yrs',
  '64 yrs',
  '65 yrs',
  '66 yrs',
];

const List<String> heights = [
  'Select Height',
  '4.5 ft',
  '4.6 ft',
  '4.7 ft',
  '4.8 ft',
  '4.9 ft',
  '4.10 ft',
  '4.11 ft',
  '5 ft',
  '5.1 ft',
  '5.2 ft',
  '5.3 ft',
  '5.4 ft',
  '5.5 ft',
  '5.6 ft',
  '5.7 ft',
  '5.8 ft',
  '5.9 ft',
  '5.10 ft',
  '5.11 ft',
  '6 ft',
  '6.1 ft',
  '6.2 ft',
  '6.3 ft',
  '6.4 ft',
  '6.5 ft',
  '6.6 ft',
  '6.7 ft',
  '6.8 ft',
  '6.9 ft',
  '6.10 ft',
  '6.11 ft',
];

const List<String> profileCreatedByOptions = [
  'Select relation ',
  'Self',
  'Parents',
  'Siblings',
  'Relatives',
  'Friends'
];

const List<String> maritalStatuses = [
  'Select marital status',
  'Never Married',
  'Divorcee',
  'Widow',
  'Widower',
  'Others'
];
const List<String> bodyTypes = [
  'Select body type',
  'Slim',
  'Athletic',
  'Average',
  'Heavy'
];
const List<String> eatingHabits = [
  'Select eating habit',
  'Vegetarian',
  'Non-Vegetarian',
  'Eggeterain',
  "Doesn't Matter"
];

const List<String> drinkingHabits = [
  'Select drinking habit',
  'Yes',
  'No',
  'Occasionally',
];

const List<String> smokingHabits = [
  'Select smoking habit',
  'Non-Smoker',
  'Occasional Smoker',
  'Regular Smoker'
];
const List<String> complexions = [
  'Select complexion',
  'Fair',
  'Wheatish',
  'Dark'
];

const List<String> annualIncomes = [
  'Select annual income',
  'Rs.2,00,001 - 3,00,000',
  'Rs.3,00,001-4,00,000',
  'Rs.4,00,001-5,00,000',
  'Rs.5,00,001-8,00,000',
  'Rs.8,00,001-12,00,000',
  'Rs.18 Lakhs - 35 Lakhs',
  'Rs.35 Lakhs - 50 Lakhs',
  'Rs.50 Lakhs - 75 Lakhs',
  'Rs.75 Lakhs - 1 Crore',
  'Rs.1.5 Crore and above',
  'Not Working'
];

const List<String> familyTypes = ['Select', 'Nuclear', 'Joint'];

const List<String> familyStatuses = [
  ' Select family status',
  'Middle Class',
  'Upper Middle Class',
  'Rich'
];

const List<String> fathersOccupations = [
  ' Select father\'s occupation',
  'Employed',
  'Retired',
  'Business',
  'Self Employed',
  'Not Working',
  'Expired',
];

const List<String> mothersOccupations = [
  ' Select mother\'s occupation',
  'Employed',
  'Retired',
  'HomeMaker',
  'Business',
  'Self Employed',
  'Expired',
];

const List<String> educations = [
  'Select Education ',
  'Bachelors',
  'Masters',
  '10th Class',
  '12th Class',
  'BACHELORS IN ARTS/SCIENCE/COMMERCE',
  'B.A',
  'B.Com',
  'B.ED',
  'BSC',
  'BFA',
  'BFT',
  'BLIS',
  'BMM',
  'BSW',
  'B.PHIL',
  'Other Bachelor Degree in Arts Science And Commerce',
  'MASTERS IN ARTS/SCIENCE AND COMMERCE',
  'M.A',
  'M.COM',
  'M.ED',
  'MFA',
  'MLIS',
  'M.SC',
  'MSW',
  'M.PHIL',
  'Other Master Degree in Arts Science And Commerce',
  'BACHELORS IN MANAGEMENT',
  'BBA',
  'BFM (Financial Management)',
  'BHM (Hotel Management)',
  'BHA/BHM (Hospital Administration)',
  'Other Bachelor Degree in Management ',
  'MASTERS IN MANAGEMENT ',
  'MBA',
  'MFM (Financial Management)',
  'MHM (Hotel Management)',
  'MHRM (Human Resource Management)',
  'PGDM',
  'Other Master Degree in Management ',
  'MHA/MHM (Hospital Administration)',
  'Other Master Degree in Management',
  'BACHELORS IN ENGINEERING/COMPUTERS',
  'B.Tech',
  'B.Arch',
  'BE',
  'B.Plan',
  'Other Bachelor Degree in Engineering/Computers',
  'MASTERS IN ENGINEERING/COMPUTERS',
  'M.Tech',
  'M.Arch',
  'MCA',
  'ME',
  'MSc',
  'M.S',
  'PGDCA',
  'Other Masters Degree in Engineering/Computers',
  'BACHELORS IN MEDICINE ',
  'MBBS',
  'B.A.M.S',
  'B.Pharm',
  'BPT',
  'B.Sc Nursing',
  'BDS',
  'BHMS',
  'BSMS',
  'BUMS',
  'BVSc',
  'MASTERS IN MEDICINE',
  'M.Pharm',
  'MPT',
  'Other Master Degree in Medicine',
  'FINANCE',
  'CA',
  'CFA (Chartered Financial Analyst)',
  'CS',
  'ICWA',
  'Other Degree in Finance',
  'BACHELORS IN LEGAL',
  'LL.B',
  'BGL',
  'B.L',
  'Other Bachelor Degree in Legal',
  'MASTERS IN LEGAL',
  'LL.M',
  'M.L',
  'Other Master Degree in Legal',
  'DOCTORATES',
  'Ph.D',
  'DM',
  'Postdoctoral Fellow',
  'Fellow of National Board (FNB)',
  'SERVICE',
  'IAS',
  'IES',
  'IFS',
  'IPS',
  'IRS',
  'Other Degree in Service ',
  'Diploma',
  'Others'
];

const List<String> occupations = [
  'Select occupation ',
  'Accountant',
  'Administrative And Support Services',
  'Advertising',
  'Aerospace',
  'Agriculture',
  'Air Hostess',
  'Architect',
  'Artist',
  'Aviation',
  'Banking And Finance',
  'Business',
  'CEO',
  'Chef',
  'Chemist',
  'Civil Engineer',
  'Company Secretary',
  'Consulting Services',
  'Customer Service Professional',
  'Defence',
  'Dentist',
  'Designer',
  'Doctor',
  'Engineering',
  'Education',
  'Entertainment Industry',
  'Executive',
  'Finance. Accounting/Auditing',
  'Govt Employee',
  'Healthcare And Allied Services',
  'IT Hardware',
  'IT Software/Telecommunication',
  'Journalist',
  'Lawyer',
  'Lecturer',
  'Manager',
  'Marketing',
  'Mechanical Engineer',
  'Merchant Navy',
  'Medical Business',
  'Nurse',
  'Pilot',
  'Private Job',
  'Professor',
  'Real Estate',
  'Research And Development Scholars',
  'Sales',
  'Self Employed',
  'Software Engineer',
  'Sports Person',
  'Student',
  'Travel/Hospitality',
  'Teacher',
  'Technician',
  'Not Working',
  'Other',
];

const List<String> brothersOccupations = [
  'Select  brother',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6'
];
const List<String> sistersOccupations = [
  ' Select sister',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6'
];
const List<String> physicalStatuses = [
  ' Select physical status',
  'Normal',
  'Physically Challenged'
];
const List<String> manglikOptions = ['Yes', 'No', "Don't Know"];
final DataModel selectHintValue = DataModel(dataName: 'Select', dataId: '0');
