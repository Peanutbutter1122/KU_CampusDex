import 'package:flutter/material.dart';
import '../screens/navigation_screen.dart';

class KuCampusData {
  static final List<Map<String, dynamic>> routes = [
    // =========================================================
    // กลุ่มที่ 1: คณะและภาควิชา (Faculties & Departments)
    // =========================================================

    // 1. คณะสิ่งแวดล้อม
    {
      'title': 'คณะสิ่งแวดล้อม',
      'desc': 'สถานที่จัดการเรียนการสอน คณะสิ่งแวดล้อม',
      'icon': Icons.eco,
      'color': const Color(0xFF4CAF50),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'ENV01',
          name: 'อาคารเรียนและปฏิบัติการ คณะสิ่งแวดล้อม',
          latitude: 13.855748,
          longitude: 100.569940,
        ),
        AppWayPoint(
          id: 'ENV02',
          name: 'อาคารคณะสิิ่งแวดล้อม',
          latitude: 13.850915,
          longitude: 100.564071,
        ),
      ],
    },

    // 2. คณะประมง (รวมบ่อทดลองและเรือนเพาะชำ)
    {
      'title': 'คณะประมง',
      'desc': 'สถานที่จัดการเรียนการสอนและศูนย์ทดลอง คณะประมง',
      'icon': Icons.water,
      'color': const Color(0xFF2196F3),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'FISH01',
          name: 'อาคารปฏิบัติการ Wet Lab (อาคารจินดาเทียมเมธ)',
          latitude: 13.855541,
          longitude: 100.569128,
        ),
        AppWayPoint(
          id: 'FISH02',
          name: 'อาคารโรงงานต้นแบบอาหารสัตว์น้ำ',
          latitude: 13.855478,
          longitude: 100.569717,
        ),
        AppWayPoint(
          id: 'FISH03',
          name: 'อาคารปฎิบัติการ คณะประมง (อาคารบุญอินทรัมพรรย์)',
          latitude: 13.855216,
          longitude: 100.569106,
        ),
        AppWayPoint(
          id: 'FISH04',
          name: 'อาคารปฏิบัติการแปรรูปสัตว์น้ำ (อาคารทัศนีสรสุชาติ)',
          latitude: 13.855119,
          longitude: 100.569653,
        ),
        AppWayPoint(
          id: 'FISH05',
          name: 'โรงเรือนทดลอง 1',
          latitude: 13.855579,
          longitude: 100.567928,
        ),
        AppWayPoint(
          id: 'FISH06',
          name: 'โรงเรือนทดลอง 2',
          latitude: 13.855601,
          longitude: 100.568181,
        ),
        AppWayPoint(
          id: 'FISH07',
          name: 'โรงเรือนทดลอง 6 (เปลี่ยนชื่อจาก บ่อคอนกรีต 4)',
          latitude: 13.855521,
          longitude: 100.568164,
        ),
        AppWayPoint(
          id: 'FISH08',
          name: 'โรงเรือนทดลอง 4 (เปลี่ยนชื่อจาก บ่อคอนกรีต 1)',
          latitude: 13.855488,
          longitude: 100.567821,
        ),
        AppWayPoint(
          id: 'FISH09',
          name: 'โรงเรือนทดลอง 5 (เปลี่ยนชื่อจากบ่อคอนกรีต 2)',
          latitude: 13.855489,
          longitude: 100.567919,
        ),
        AppWayPoint(
          id: 'FISH10',
          name: 'บ่อคอนกรีต 3',
          latitude: 13.855459,
          longitude: 100.567974,
        ),
        AppWayPoint(
          id: 'FISH11',
          name: 'โรงเรือนทดลอง 3',
          latitude: 13.855451,
          longitude: 100.568008,
        ),
        AppWayPoint(
          id: 'FISH12',
          name: 'โรงปฏิบัติการอาหารสัตวน้ำ',
          latitude: 13.855444,
          longitude: 100.567560,
        ),
        AppWayPoint(
          id: 'FISH13',
          name: 'เรือนปฏิบัติการสุขภาพสัตวน้ำ',
          latitude: 13.855388,
          longitude: 100.567855,
        ),
        AppWayPoint(
          id: 'FISH14',
          name: 'โรงเรือนปฏิบัติการเพาะฟักและอนุบาลสัตว์น้ำกร่อย',
          latitude: 13.855351,
          longitude: 100.568075,
        ),
        AppWayPoint(
          id: 'FISH15',
          name: 'อาคารวลัยลักษณ์',
          latitude: 13.855298,
          longitude: 100.568339,
        ),
        AppWayPoint(
          id: 'FISH16',
          name: 'บ่อคอนกรีตกลม (12 บ่อ)',
          latitude: 13.855345,
          longitude: 100.567343,
        ),
        AppWayPoint(
          id: 'FISH17',
          name: 'อาคารปฎิบัติการเพาะฟักและอนุบาลสัตว์น้ำจืด',
          latitude: 13.855089,
          longitude: 100.566867,
        ),
        AppWayPoint(
          id: 'FISH18',
          name: 'อาคารปฏิบัติการคุณภาพน้ำ',
          latitude: 13.854791,
          longitude: 100.566842,
        ),
        AppWayPoint(
          id: 'FISH19',
          name:
              'อาคารภาควิชาเพาะเลี้ยงสัตวน้ำและภาควิชาการจัดการประมง (อาคารเมฆบุญพรามหมณ์)',
          latitude: 13.854900,
          longitude: 100.567184,
        ),
        AppWayPoint(
          id: 'FISH20',
          name: 'อาคารภาควิชาวิทยาศาสตร์ทางทะเล',
          latitude: 13.854502,
          longitude: 100.567216,
        ),
        AppWayPoint(
          id: 'FISH21',
          name: 'อาคารพิพิธภัณฑ์ธรรมชาติวิทยาประมง (อาคารโชติสุวัตถิ)',
          latitude: 13.855042,
          longitude: 100.567651,
        ),
        AppWayPoint(
          id: 'FISH22',
          name: 'บ่อดินเก็บน้ำ 8',
          latitude: 13.854739,
          longitude: 100.568752,
        ),
        AppWayPoint(
          id: 'FISH23',
          name: 'บ่อดินทดลอง 1',
          latitude: 13.854548,
          longitude: 100.567681,
        ),
        AppWayPoint(
          id: 'FISH24',
          name: 'บ่อดินทดลอง 2',
          latitude: 13.854488,
          longitude: 100.567926,
        ),
        AppWayPoint(
          id: 'FISH25',
          name: 'บ่อดินทดลอง 3',
          latitude: 13.854438,
          longitude: 100.568165,
        ),
        AppWayPoint(
          id: 'FISH26',
          name: 'บ่อดินทดลอง 4',
          latitude: 13.854379,
          longitude: 100.568400,
        ),
        AppWayPoint(
          id: 'FISH27',
          name: 'บ่อดินทดลอง 5',
          latitude: 13.854328,
          longitude: 100.568633,
        ),
        AppWayPoint(
          id: 'FISH28',
          name: 'บ่อดินทดลอง 6',
          latitude: 13.854279,
          longitude: 100.568865,
        ),
        AppWayPoint(
          id: 'FISH29',
          name: 'บ่อดินบำบัดน้ำ 7',
          latitude: 13.854229,
          longitude: 100.569106,
        ),
        AppWayPoint(
          id: 'FISH30',
          name: 'ศูนย์ถ่ายทอดเทคโนโลยีปลาสวยงามและพรรณไม้ประดับ',
          latitude: 13.854228,
          longitude: 100.569589,
        ),
        AppWayPoint(
          id: 'FISH31',
          name: 'เรือนเพาะชำไม้น้ำประดับ',
          latitude: 13.854181,
          longitude: 100.569893,
        ),
        AppWayPoint(
          id: 'FISH32',
          name: 'อาคารปฎิบัติการพื้นฐานคณะประมง (อาคารสุภาพมงคลประสิทธิ์)',
          latitude: 13.853967,
          longitude: 100.567793,
        ),
        AppWayPoint(
          id: 'FISH33',
          name: 'ศูนย์พัฒนาเทคโนโลยีอาหารสัตว์น้ำ (อาคารวิทย์ธารชลานุกิจ)',
          latitude: 13.853953,
          longitude: 100.568367,
        ),
      ],
    },

    // 3. คณะสถาปัตยกรรมศาสตร์
    {
      'title': 'คณะสถาปัตยกรรมศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะสถาปัตยกรรมศาสตร์',
      'icon': Icons.architecture,
      'color': const Color(0xFF9C27B0),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'ARCH01',
          name:
              'โครงการก่อสร้างอาคารปฏิบัติการรวมด้านนวัตกรรมการออกแบบอุตสาหกรรมและเทคโลยี (คณะสถาปัตยกรรมศาสตร์)',
          latitude: 13.853578,
          longitude: 100.568048,
        ),
        AppWayPoint(
          id: 'ARCH02',
          name: 'อาคารปฏิบัติการเทคโนโลยีทางอาคารสถาปัตยกรรมศาสตร์',
          latitude: 13.853667,
          longitude: 100.568538,
        ),
        AppWayPoint(
          id: 'ARCH03',
          name: 'อาคารสถาปัตยกรรมศาสตร์',
          latitude: 13.853132,
          longitude: 100.568358,
        ),
      ],
    },

    // 4. คณะศึกษาศาสตร์
    {
      'title': 'คณะศึกษาศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะศึกษาศาสตร์',
      'icon': Icons.menu_book,
      'color': const Color(0xFFFF9800),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'EDU01',
          name: 'อาคารศูนย์ปฏิบัติการเทคโนโลยี เพื่อการศึกษา (อาคาร 3)',
          latitude: 13.851762,
          longitude: 100.570060,
        ),
        AppWayPoint(
          id: 'EDU02',
          name:
              'อาคารปฏิบัติการรวมด้านนวัตกรรมการออกแบบอุตสาหกรรมและเทคโนโลยี (โครงการก่อสร้าง)',
          latitude: 13.851428,
          longitude: 100.570251,
        ),
        AppWayPoint(
          id: 'EDU03',
          name: 'อาคารคณะศึกษาศาสตร์ (อาคาร 2)',
          latitude: 13.851338,
          longitude: 100.570045,
        ),
        AppWayPoint(
          id: 'EDU04',
          name: 'อาคารคณะศึกษาศาสตร์ (อาคาร 1)',
          latitude: 13.850986,
          longitude: 100.570062,
        ),
      ],
    },

    // 5. คณะอุตสาหกรรมเกษตร
    {
      'title': 'คณะอุตสาหกรรมเกษตร',
      'desc': 'สถานที่จัดการเรียนการสอน คณะอุตสาหกรรมเกษตร',
      'icon': Icons.precision_manufacturing,
      'color': const Color(0xFF795548),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'AGI01',
          name: 'อาคารอุตสาหกรรมสิ่งทอ อาคาร 3',
          latitude: 13.852977,
          longitude: 100.571981,
        ),
        AppWayPoint(
          id: 'AGI02',
          name: 'อาคารเรียนและปฏิบัติการ (อาคาร 2)',
          latitude: 13.851592,
          longitude: 100.570907,
        ),
        AppWayPoint(
          id: 'AGI03',
          name: 'อาคารปฏิบัติการ วิจัยทางด้านอุตสาหกรรมเกษตร (อาคาร5)',
          latitude: 13.851691,
          longitude: 100.571801,
        ),
        AppWayPoint(
          id: 'AGI04',
          name: 'อาคารแปรรูป 1 (อาคาร 6)',
          latitude: 13.851342,
          longitude: 100.571465,
        ),
        AppWayPoint(
          id: 'AGI05',
          name: 'อาคารกิจกรรมนิสิต (อาคาร 4)',
          latitude: 13.851406,
          longitude: 100.571986,
        ),
        AppWayPoint(
          id: 'AGI06',
          name: 'อาคารคณะอุตสาหกรรมเกษตร (อาคาร 1)',
          latitude: 13.850987,
          longitude: 100.570891,
        ),
      ],
    },

    // 6. คณะสังคมศาสตร์
    {
      'title': 'คณะสังคมศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะสังคมศาสตร์',
      'icon': Icons.people,
      'color': const Color(0xFF607D8B),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'SOC01',
          name: 'อาคารคณะ สังคมศาสตร์ (อาคาร 2)',
          latitude: 13.850099,
          longitude: 100.570085,
        ),
        AppWayPoint(
          id: 'SOC02',
          name: 'อาคารคณะ สังคมศาสตร์ (อาคาร 3)',
          latitude: 13.849887,
          longitude: 100.569929,
        ),
        AppWayPoint(
          id: 'SOC03',
          name: 'อาคารคณะ สังคมศาสตร์ (อาคาร 1)',
          latitude: 13.849712,
          longitude: 100.570156,
        ),
        AppWayPoint(
          id: 'SOC04',
          name: 'อาคารคณะ สังคมศาสตร์ (อาคาร 4)',
          latitude: 13.849412,
          longitude: 100.570131,
        ),
      ],
    },

    // 7. คณะเกษตร (รวมโรงเรือนและศูนย์วิจัยทั้งหมด)
    {
      'title': 'คณะเกษตร',
      'desc': 'สถานที่จัดการเรียนการสอนและโรงเรือนวิจัย คณะเกษตร',
      'icon': Icons.agriculture,
      'color': const Color(0xFF4CAF50),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'AGR01',
          name: 'อาคารโรงเรือนวิจัยและพัฒนา 3 (ฟาร์มไก่หลวงสุวรรณวาจกกสิกิจ)',
          latitude: 13.854876,
          longitude: 100.570678,
        ),
        AppWayPoint(
          id: 'AGR02',
          name: 'โรงเก็บปุ๋ยคอก (เปลี่ยนชื่อจาก โรงสำรองไฟฟ้า)',
          latitude: 13.854917,
          longitude: 100.570926,
        ),
        AppWayPoint(
          id: 'AGR03',
          name: 'อาคารโรงเรือนวิจัยและพัฒนา 2',
          latitude: 13.854873,
          longitude: 100.571346,
        ),
        AppWayPoint(
          id: 'AGR04',
          name: 'อาคารโรงเรือนวิจัยและพัฒนา 1',
          latitude: 13.854749,
          longitude: 100.571347,
        ),
        AppWayPoint(
          id: 'AGR05',
          name: 'อาคารโรงแปรรูปผลิตภัณฑ์/ปฏิบัติการตัวอย่างงานวิจัย',
          latitude: 13.854829,
          longitude: 100.571916,
        ),
        AppWayPoint(
          id: 'AGR06',
          name: 'โรงเก็บอาหารและผสมอาหารสัตว์',
          latitude: 13.854871,
          longitude: 100.572189,
        ),
        AppWayPoint(
          id: 'AGR07',
          name: 'อาคารโรงเรือนวิจัยและพัฒนา 4',
          latitude: 13.854596,
          longitude: 100.570639,
        ),
        AppWayPoint(
          id: 'AGR08',
          name: 'อาคารโรงเรือนวิจัยและพัฒนา 5',
          latitude: 13.854452,
          longitude: 100.570611,
        ),
        AppWayPoint(
          id: 'AGR09',
          name: 'อาคารปฏิบัติการฟักไข่และวิจัย',
          latitude: 13.854448,
          longitude: 100.571213,
        ),
        AppWayPoint(
          id: 'AGR10',
          name: 'โรงเรือนวิจัยและพัฒนา 7',
          latitude: 13.854618,
          longitude: 100.571673,
        ),
        AppWayPoint(
          id: 'AGR11',
          name: 'อาคารโรงเรือนวิจัยและพัฒนา 6',
          latitude: 13.854449,
          longitude: 100.571669,
        ),
        AppWayPoint(
          id: 'AGR12',
          name: 'ห้องน้ำ (ฟาร์มไก่หลวงสุวรรณวาจกกสิกิจ)',
          latitude: 13.854670,
          longitude: 100.571885,
        ),
        AppWayPoint(
          id: 'AGR13',
          name: 'อาคารที่ทำการ',
          latitude: 13.854564,
          longitude: 100.572157,
        ),
        AppWayPoint(
          id: 'AGR14',
          name: 'ร้านจำหน่ายผลิตภัณฑ์',
          latitude: 13.854399,
          longitude: 100.572375,
        ),
        AppWayPoint(
          id: 'AGR15',
          name:
              'อาคารวิจัยและพัฒนา(สถาบันค้นคว้าและพัฒนาระบบนิเวศเกษตร ชั้น3ห้อง313,316)',
          latitude: 13.854052,
          longitude: 100.572274,
        ),
        AppWayPoint(
          id: 'AGR16',
          name: 'เรือนเก็บวัสดุ',
          latitude: 13.853713,
          longitude: 100.567574,
        ),
        AppWayPoint(
          id: 'AGR17',
          name: 'เรือนเก็บพัสดุ (เปลี่ยนชื่อจากเรือนเพาะชำ 9)',
          latitude: 13.853602,
          longitude: 100.567764,
        ),
        AppWayPoint(
          id: 'AGR18',
          name: 'อาคารโครงการ วิจัยพืชสวน 2',
          latitude: 13.853429,
          longitude: 100.567730,
        ),
        AppWayPoint(
          id: 'AGR19',
          name: 'อาคารวิจัยพืชสวน 1',
          latitude: 13.853496,
          longitude: 100.567623,
        ),
        AppWayPoint(
          id: 'AGR20',
          name: 'อาคารเรือนองุ่นปวิณปุณศรี',
          latitude: 13.853156,
          longitude: 100.567673,
        ),
        AppWayPoint(
          id: 'AGR21',
          name: 'เรือนเพาะชำ (หลังอาคารสารนิเทศ 50 ปี)',
          latitude: 13.853711,
          longitude: 100.569164,
        ),
        AppWayPoint(
          id: 'AGR22',
          name: 'อาคารวิจัยแมลง',
          latitude: 13.853319,
          longitude: 100.565425,
        ),
        AppWayPoint(
          id: 'AGR23',
          name: 'โรงเรือนปฏิบัติการ หลังที่ 2',
          latitude: 13.853140,
          longitude: 100.565468,
        ),
        AppWayPoint(
          id: 'AGR24',
          name: 'โรงเรือนปฏิบัติการ หลังที่ 1',
          latitude: 13.852957,
          longitude: 100.565379,
        ),
        AppWayPoint(
          id: 'AGR25',
          name: 'อาคารวิจัยกีฏวิทยา',
          latitude: 13.852949,
          longitude: 100.565616,
        ),
        AppWayPoint(
          id: 'AGR26',
          name: 'อาคารวิจัยหม่อนไหม',
          latitude: 13.852772,
          longitude: 100.565570,
        ),
        AppWayPoint(
          id: 'AGR27',
          name: 'อาคารกล้วยไม้ ระพี สาคริก',
          latitude: 13.852858,
          longitude: 100.565945,
        ),
        AppWayPoint(
          id: 'AGR28',
          name: 'เรือนเพาะชำ 4',
          latitude: 13.850446,
          longitude: 100.564138,
        ),
        AppWayPoint(
          id: 'AGR29',
          name: 'เรือนเพาะชำ 3',
          latitude: 13.850449,
          longitude: 100.564325,
        ),
        AppWayPoint(
          id: 'AGR30',
          name: 'เรือนเพาะชำ (เปลี่ยนชื่อจากเรือนตาก)',
          latitude: 13.850385,
          longitude: 100.563983,
        ),
        AppWayPoint(
          id: 'AGR31',
          name: 'เรือนเพาะชำ 8',
          latitude: 13.850349,
          longitude: 100.564323,
        ),
        AppWayPoint(
          id: 'AGR32',
          name: 'เรือนเพาะชำ 5',
          latitude: 13.850145,
          longitude: 100.564262,
        ),
        AppWayPoint(
          id: 'AGR33',
          name: 'เรือนเพาะชำ 2',
          latitude: 13.849908,
          longitude: 100.563638,
        ),
        AppWayPoint(
          id: 'AGR34',
          name: 'เรือนเพาะชำ 1',
          latitude: 13.849836,
          longitude: 100.563742,
        ),
        AppWayPoint(
          id: 'AGR35',
          name: 'อาคารปฏิบัติการ',
          latitude: 13.849723,
          longitude: 100.563580,
        ),
        AppWayPoint(
          id: 'AGR36',
          name: 'เรือนเพาะชำ 6',
          latitude: 13.849841,
          longitude: 100.563985,
        ),
        AppWayPoint(
          id: 'AGR37',
          name: 'เรือนเพาะชำ 7',
          latitude: 13.849797,
          longitude: 100.564069,
        ),
        AppWayPoint(
          id: 'AGR38',
          name: 'อาคารเรียน',
          latitude: 13.849607,
          longitude: 100.563901,
        ),
        AppWayPoint(
          id: 'AGR39',
          name: 'อาคารวชิรานุสรณ์',
          latitude: 13.849867,
          longitude: 100.571045,
        ),
        AppWayPoint(
          id: 'AGR40',
          name: 'อาคารปฏิบัติการ ภาควิชาพืชไร่นา 2',
          latitude: 13.850312,
          longitude: 100.571471,
        ),
        AppWayPoint(
          id: 'AGR41',
          name: 'โรงรถอาคารภาควิชาพืชไร่นา',
          latitude: 13.850310,
          longitude: 100.571654,
        ),
        AppWayPoint(
          id: 'AGR42',
          name: 'อาคารปฏิบัติการ ภาควิชาพืชไร่นา 1',
          latitude: 13.850204,
          longitude: 100.571497,
        ),
        AppWayPoint(
          id: 'AGR43',
          name: 'อาคารภาควิชาพืชไร่นา (อาคาร 2)',
          latitude: 13.850309,
          longitude: 100.571883,
        ),
        AppWayPoint(
          id: 'AGR44',
          name: 'อาคารภาควิชาพืชไร่นา (อาคาร 1)',
          latitude: 13.850203,
          longitude: 100.572070,
        ),
        AppWayPoint(
          id: 'AGR45',
          name: 'เรือนเพาะชำ (ข้างอาคารวชิรานุสรณ์)',
          latitude: 13.849966,
          longitude: 100.571522,
        ),
        AppWayPoint(
          id: 'AGR46',
          name: 'เรือนปลูกพืชทดลอง ระยะที่ 1 (จำนวน 7 หลัง)',
          latitude: 13.849611,
          longitude: 100.571990,
        ),
        AppWayPoint(
          id: 'AGR47',
          name: 'เรือนปลูกพืชทดลอง ระยะที่ 2 ( จำนวน 4 หลัง)',
          latitude: 13.849448,
          longitude: 100.571814,
        ),
        AppWayPoint(
          id: 'AGR48',
          name: 'อาคารจรัดสุนทรสิงห์',
          latitude: 13.849294,
          longitude: 100.570992,
        ),
        AppWayPoint(
          id: 'AGR49',
          name: 'อาคารคณะเกษตร',
          latitude: 13.848920,
          longitude: 100.571010,
        ),
        AppWayPoint(
          id: 'AGR50',
          name: 'อาคารภาควิชาปฐพีวิทยา (สรสิทธิ์ วัชโรทยาน)',
          latitude: 13.848972,
          longitude: 100.571867,
        ),
        AppWayPoint(
          id: 'AGR51',
          name: 'ตึกภาควิชาคหกรรมศาสตร์ (ศ.ชวนชม จันทระเปารยะ)',
          latitude: 13.843574,
          longitude: 100.570610,
        ),
        AppWayPoint(
          id: 'AGR52',
          name: 'ตึกลดา รตกสิกร',
          latitude: 13.843905,
          longitude: 100.570675,
        ),
        AppWayPoint(
          id: 'AGR53',
          name: 'อาคารภาควิชาคหกรรมศาสตร์',
          latitude: 13.843847,
          longitude: 100.570944,
        ),
        AppWayPoint(
          id: 'AGR54',
          name: 'โรงอาหารภาควิชา คหกรรมศาสตร์',
          latitude: 13.844225,
          longitude: 100.570733,
        ),
        AppWayPoint(
          id: 'AGR55',
          name: 'โรงเรียนอนุบาล คหกรรมศาสตร์',
          latitude: 13.844196,
          longitude: 100.571101,
        ),
        AppWayPoint(
          id: 'AGR56',
          name: 'ศาลากิจกรรม',
          latitude: 13.844053,
          longitude: 100.571011,
        ),
        AppWayPoint(
          id: 'AGR57',
          name: 'อาคารสโมสรนิสิต ภาควิชาคหกรรม',
          latitude: 13.844054,
          longitude: 100.571108,
        ),
        AppWayPoint(
          id: 'AGR58',
          name: 'บ้านฝึกนิสิตคหกรรมศาสตร์',
          latitude: 13.846390,
          longitude: 100.564356,
        ),
      ],
    },
    // 8. คณะมนุษยศาสตร์
    {
      'title': 'คณะมนุษยศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะมนุษยศาสตร์',
      'icon': Icons.language,
      'color': const Color(0xFFE91E63),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'HUM01',
          name: 'อาคารคณะมนุษยศาสตร์ อาคาร 1',
          latitude: 13.848747,
          longitude: 100.569426,
        ),
        AppWayPoint(
          id: 'HUM02',
          name: 'คณะมนุษย์ศาสตร์ อาคาร 3',
          latitude: 13.848972,
          longitude: 100.570022,
        ),
        AppWayPoint(
          id: 'HUM03',
          name: 'คณะมนุษย์ศาสตร์ อาคาร 2',
          latitude: 13.848780,
          longitude: 100.570170,
        ),
        AppWayPoint(
          id: 'HUM04',
          name: 'อาคารจุฬาภรณ์พิศาลศิลป์ (อาคาร 4)',
          latitude: 13.848255,
          longitude: 100.569310,
        ),
        AppWayPoint(
          id: 'HUM05',
          name: 'อาคารนิทรรศการ',
          latitude: 13.847313,
          longitude: 100.563290,
        ),
      ],
    },

    // 9. บัณฑิตวิทยาลัย
    {
      'title': 'บัณฑิตวิทยาลัย',
      'desc': 'สถานที่ของบัณฑิตวิทยาลัย',
      'icon': Icons.school,
      'color': const Color(0xFF3F51B5),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'GRA01',
          name: 'อาคารสารสนเทศบัณฑิตศึกษา',
          latitude: 13.848199,
          longitude: 100.570139,
        ),
        AppWayPoint(
          id: 'GRA02',
          name: 'อาคารบรรเจิด คติการ',
          latitude: 13.847856,
          longitude: 100.570056,
        ),
      ],
    },

    // 10. คณะวิศวกรรมศาสตร์
    {
      'title': 'คณะวิศวกรรมศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะวิศวกรรมศาสตร์',
      'icon': Icons.engineering,
      'color': const Color(0xFFB71C1C),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'ENG01',
          name: 'อาคารเรียนและบริหาร (อาคาร 1)',
          latitude: 13.846583,
          longitude: 100.569206,
        ),
        AppWayPoint(
          id: 'ENG02',
          name: 'อาคารเรียนนานาชาติ (อาคาร 17)',
          latitude: 13.846393,
          longitude: 100.569774,
        ),
        AppWayPoint(
          id: 'ENG03',
          name: 'อาคารสโมสรนิสิต (อาคาร 16)',
          latitude: 13.846461,
          longitude: 100.570156,
        ),
        AppWayPoint(
          id: 'ENG04',
          name: 'อาคารปฏิบัติการคณะวิศวกรรมศาสตร์ (อาคาร 15)',
          latitude: 13.846234,
          longitude: 100.568678,
        ),
        AppWayPoint(
          id: 'ENG05',
          name: 'อาคารปฏิบัติการวิศวกรรมไฟฟ้า (อาคาร 2)',
          latitude: 13.846152,
          longitude: 100.568973,
        ),
        AppWayPoint(
          id: 'ENG06',
          name: 'อาคารเรียนคณะ (อาคาร 3)',
          latitude: 13.846167,
          longitude: 100.569610,
        ),
        AppWayPoint(
          id: 'ENG07',
          name: 'อาคารศูนย์คอมพิวเตอร์วิศวกรรม (อาคาร 4)',
          latitude: 13.846273,
          longitude: 100.570108,
        ),
        AppWayPoint(
          id: 'ENG08',
          name: 'อาคารปฏิบัติการวิศวกรรมเครื่องกล (อาคาร 5)',
          latitude: 13.845596,
          longitude: 100.568838,
        ),
        AppWayPoint(
          id: 'ENG09',
          name: 'อาคารวัสดุธานี (อาคาร 10)',
          latitude: 13.845609,
          longitude: 100.569266,
        ),
        AppWayPoint(
          id: 'ENG10',
          name: 'อาคารปฏิบัติการวิศวกรรมโยธา (อาคาร 9 อาคารบุญสมสุวชิรัตน์)',
          latitude: 13.845627,
          longitude: 100.569661,
        ),
        AppWayPoint(
          id: 'ENG11',
          name: 'อาคารวิศวกรรมศาสตร์ 60 ปี (อาคารชูชาติกำภู อาคาร 14)',
          latitude: 13.845481,
          longitude: 100.570155,
        ),
        AppWayPoint(
          id: 'ENG12',
          name: 'อาคารชำนาญเพ็ญชาติ (อาคาร 11 วิศวกรรมสิ่งแวดล้อม)',
          latitude: 13.845249,
          longitude: 100.569602,
        ),
        AppWayPoint(
          id: 'ENG13',
          name: 'อาคารวิศวกรรมสำรวจและบริหารการก่อสร้าง (อาคาร 12)',
          latitude: 13.845075,
          longitude: 100.569613,
        ),
        AppWayPoint(
          id: 'ENG14',
          name: 'อาคารปฏิบัติการและวิจัย (อาคาร 8)',
          latitude: 13.844950,
          longitude: 100.569156,
        ),
        AppWayPoint(
          id: 'ENG15',
          name: 'อาคารปฏิบัติการวิศวกรรมทรัพยากรน้ำ (อาคาร 13)',
          latitude: 13.844741,
          longitude: 100.569545,
        ),
        AppWayPoint(
          id: 'ENG16',
          name: 'อาคารปฏิบัติการยานยนต์ (อาคาร 6)',
          latitude: 13.845144,
          longitude: 100.568729,
        ),
        AppWayPoint(
          id: 'ENG17',
          name: 'โรงรถ',
          latitude: 13.845025,
          longitude: 100.568009,
        ),
        AppWayPoint(
          id: 'ENG18',
          name: 'อาคารสำนักบริการคอมพิวเตอร์หลังเดิม ส่งมอบให้คณะวิศวกรรมศาตร์',
          latitude: 13.844899,
          longitude: 100.568142,
        ),
        AppWayPoint(
          id: 'ENG19',
          name: 'อาคารปฏิบัติการวิศวกรรมอุตสาหการ (อาคาร 7)',
          latitude: 13.844777,
          longitude: 100.568479,
        ),
        AppWayPoint(
          id: 'ENG20',
          name: 'อาคารวิจัยเทคโนโลยี ทางอุตสาหกรรม (CNC) (อาคาร 18)',
          latitude: 13.853008,
          longitude: 100.571071,
        ),
      ],
    },

    // 11. คณะเศรษฐศาสตร์
    {
      'title': 'คณะเศรษฐศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะเศรษฐศาสตร์',
      'icon': Icons.trending_up,
      'color': const Color(0xFF009688),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'ECO01',
          name: 'อาคารปฏิบัติการคณะเศรษฐศาสตร์',
          latitude: 13.844729,
          longitude: 100.570159,
        ),
        AppWayPoint(
          id: 'ECO02',
          name: 'อาคารศูนย์วิจัยเศรษฐศาสตร์ประยุกต์ (อาคาร 3)',
          latitude: 13.844145,
          longitude: 100.570152,
        ),
        AppWayPoint(
          id: 'ECO03',
          name: 'ร้านค้า (ข้างห้องสมุดพิทยาลงกรณ์)',
          latitude: 13.843974,
          longitude: 100.570151,
        ),
        AppWayPoint(
          id: 'ECO04',
          name: 'อาคารห้องสมุดพิทยาลงกรณ์',
          latitude: 13.843896,
          longitude: 100.569992,
        ),
        AppWayPoint(
          id: 'ECO05',
          name: 'โรงรถ 1 (ข้างอาคารห้องสมุดพิทยาลงกรณ์)',
          latitude: 13.843818,
          longitude: 100.570092,
        ),
        AppWayPoint(
          id: 'ECO06',
          name: 'ศาลาประชาสัมพันธ์',
          latitude: 13.843705,
          longitude: 100.569963,
        ),
        AppWayPoint(
          id: 'ECO07',
          name: 'อาคารการเงิน',
          latitude: 13.844229,
          longitude: 100.569965,
        ),
        AppWayPoint(
          id: 'ECO08',
          name: 'ห้องน้ำ (ข้างอาคารวิจารณ์พาณิชย์)',
          latitude: 13.844118,
          longitude: 100.569903,
        ),
        AppWayPoint(
          id: 'ECO09',
          name: 'อาคารพิจารณ์พาณิชย์ (อาคาร 2)',
          latitude: 13.844329,
          longitude: 100.569616,
        ),
        AppWayPoint(
          id: 'ECO10',
          name: 'อาคารพิทยาลงกรณ์ ( อาคาร 1)',
          latitude: 13.844125,
          longitude: 100.569534,
        ),
        AppWayPoint(
          id: 'ECO11',
          name: 'อาคารเก็บของคณะเศรษฐศาสตร์',
          latitude: 13.844466,
          longitude: 100.569759,
        ),
        AppWayPoint(
          id: 'ECO12',
          name: 'โรงรถ 2 (ข้างอาคารพิจารณ์พาณิชย์)',
          latitude: 13.844390,
          longitude: 100.569807,
        ),
      ],
    },

    // 12. คณะบริหารธุรกิจ
    {
      'title': 'คณะบริหารธุรกิจ',
      'desc': 'สถานที่จัดการเรียนการสอน คณะบริหารธุรกิจ',
      'icon': Icons.business_center,
      'color': const Color(0xFF3F51B5),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'BUS01',
          name: 'อาคารการเรียนการสอนคณะบริหารธุรกิจ (อาคาร 1)',
          latitude: 13.844640,
          longitude: 100.569056,
        ),
        AppWayPoint(
          id: 'BUS02',
          name: 'อาคารการเรียนการสอนคณะบริหารธุรกิจ (อาคาร 2)',
          latitude: 13.844475,
          longitude: 100.568828,
        ),
        AppWayPoint(
          id: 'BUS03',
          name: 'อาคารการเรียนการสอนคณะบริหารธุรกิจ(อาคาร 3)',
          latitude: 13.844327,
          longitude: 100.569085,
        ),
        AppWayPoint(
          id: 'BUS04',
          name: 'อาคารการเรียนการสอน คณะบริหารธุรกิจ (อาคาร 4)',
          latitude: 13.844058,
          longitude: 100.568811,
        ),
      ],
    },

    // 13. คณะวิทยาศาสตร์
    {
      'title': 'คณะวิทยาศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะวิทยาศาสตร์',
      'icon': Icons.science,
      'color': const Color(0xFF00BCD4),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'SCI01',
          name: 'อาคารกฤษณา ชุติมา (ภาควิชาเคมี)',
          latitude: 13.848033,
          longitude: 100.562736,
        ),
        AppWayPoint(
          id: 'SCI02',
          name: 'เรือนเพาะชำ 1-2',
          latitude: 13.844672,
          longitude: 100.570684,
        ),
        AppWayPoint(
          id: 'SCI03',
          name: 'อาคารเก็บสารเคมี',
          latitude: 13.844677,
          longitude: 100.570940,
        ),
        AppWayPoint(
          id: 'SCI04',
          name: 'อาคารปฏิบัติการวิจัย (ภาควิชาพันธุ์ศาสตร์)',
          latitude: 13.844596,
          longitude: 100.570942,
        ),
        AppWayPoint(
          id: 'SCI05',
          name: 'อาคารสุขประชา วาจานนท์',
          latitude: 13.844697,
          longitude: 100.571529,
        ),
        AppWayPoint(
          id: 'SCI06',
          name: 'อาคารภาควิชาสถิติ-คณิตศาสตร์-วิทยาการคอมพิวเตอร์',
          latitude: 13.845120,
          longitude: 100.571655,
        ),
        AppWayPoint(
          id: 'SCI07',
          name: 'อาคารยงยุทธ เจียมไชยศรี',
          latitude: 13.845106,
          longitude: 100.570770,
        ),
        AppWayPoint(
          id: 'SCI08',
          name: 'อาคารทวี ญาณสุคนธ์',
          latitude: 13.844994,
          longitude: 100.572290,
        ),
        AppWayPoint(
          id: 'SCI09',
          name: 'อาคารวิฑูรย์ หงส์สุมาลย์',
          latitude: 13.845976,
          longitude: 100.570883,
        ),
        AppWayPoint(
          id: 'SCI10',
          name: 'อาคารภาควิชาสัตววิทยา',
          latitude: 13.846199,
          longitude: 100.571362,
        ),
        AppWayPoint(
          id: 'SCI11',
          name: 'อาคารปฏิบัติการวิทยาศาสตร์กายภาพ',
          latitude: 13.845892,
          longitude: 100.571400,
        ),
        AppWayPoint(
          id: 'SCI12',
          name: 'อาคารศาลาลอย',
          latitude: 13.845937,
          longitude: 100.571738,
        ),
        AppWayPoint(
          id: 'SCI13',
          name: 'อาคารศูนย์เครื่องมือวิทยาศาสตร์',
          latitude: 13.845759,
          longitude: 100.571744,
        ),
        AppWayPoint(
          id: 'SCI14',
          name:
              'อาคารโรงงานต้นแบบ ผลิตเครื่องดื่มนมเปรี้ยวคุณภาพสูง จากถั่วเหลือง',
          latitude: 13.845737,
          longitude: 100.571682,
        ),
        AppWayPoint(
          id: 'SCI15',
          name: 'อาคารปฏิบัติการรวมทางวิทยาศาตร์',
          latitude: 13.845966,
          longitude: 100.572039,
        ),
        AppWayPoint(
          id: 'SCI16',
          name: 'อาคารจุลชีววิทยา-พันธุศาสตร์',
          latitude: 13.845543,
          longitude: 100.571692,
        ),
      ],
    },

    // 14. คณะวนศาสตร์
    {
      'title': 'คณะวนศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะวนศาสตร์',
      'icon': Icons.forest,
      'color': const Color(0xFF388E3C),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'FOR01',
          name: 'อาคารศูนย์ฝึกอบรมวนศาสตร์ชุมชนแห่งภูมิภาคเอเซียแปซิฟิก 2',
          latitude: 13.846002,
          longitude: 100.572871,
        ),
        AppWayPoint(
          id: 'FOR02',
          name: 'อาคารศูนย์ฝึกอบรมวนศาสตร์ชุมชนแห่งภูมิภาคเอเซียแปซิฟิก 1',
          latitude: 13.845730,
          longitude: 100.572865,
        ),
        AppWayPoint(
          id: 'FOR03',
          name: 'โรงอาหาร คณะวนศาสตร์',
          latitude: 13.845916,
          longitude: 100.573163,
        ),
        AppWayPoint(
          id: 'FOR04',
          name: 'อาคารปฏิบัติการ 1 เพาะเลี้ยงเนื้อเยื่อไม้ป่า',
          latitude: 13.845751,
          longitude: 100.573163,
        ),
        AppWayPoint(
          id: 'FOR05',
          name: 'อาคารสโมสรนิสิตวนศาสตร์ ( สมาคมศิษย์เก่า )',
          latitude: 13.845989,
          longitude: 100.573403,
        ),
        AppWayPoint(
          id: 'FOR06',
          name: 'โรงรถคณะวนศาสตร์',
          latitude: 13.845954,
          longitude: 100.573492,
        ),
        AppWayPoint(
          id: 'FOR07',
          name: 'อาคารภาควิชาการจัดการป่าไม้',
          latitude: 13.845765,
          longitude: 100.573689,
        ),
        AppWayPoint(
          id: 'FOR08',
          name: 'อาคารปฏิบัติการวนศาสตร์ 72 ปี',
          latitude: 13.845925,
          longitude: 100.574165,
        ),
        AppWayPoint(
          id: 'FOR09',
          name: 'อาคารปฎิบัติการวนผลิตภัณฑ์ 3 (ตึกโชติรักติประกร)',
          latitude: 13.845893,
          longitude: 100.574607,
        ),
        AppWayPoint(
          id: 'FOR10',
          name: 'อาคารปฏิบัติการวนผลิตภัณฑ์ 1',
          latitude: 13.845741,
          longitude: 100.574602,
        ),
        AppWayPoint(
          id: 'FOR11',
          name: 'อาคารเทคโนโลยีไม้เชิงกล',
          latitude: 13.845841,
          longitude: 100.574988,
        ),
        AppWayPoint(
          id: 'FOR12',
          name: 'ตึกวินิจวนันดร',
          latitude: 13.845505,
          longitude: 100.573084,
        ),
        AppWayPoint(
          id: 'FOR13',
          name: 'อาคารพักนิสิตปริญญาโท',
          latitude: 13.845305,
          longitude: 100.573083,
        ),
        AppWayPoint(
          id: 'FOR14',
          name: 'อาคารปฏิบัติการวนศาสตร์ 60 ปี',
          latitude: 13.845269,
          longitude: 100.574005,
        ),
        AppWayPoint(
          id: 'FOR15',
          name: 'อาคารเทียมคมกฤส',
          latitude: 13.845273,
          longitude: 100.574671,
        ),
        AppWayPoint(
          id: 'FOR16',
          name: 'อาคารชมรมนิสิต (กระท่อมวนกร )',
          latitude: 13.845149,
          longitude: 100.574412,
        ),
        AppWayPoint(
          id: 'FOR17',
          name: 'ชมรม the forester',
          latitude: 13.845072,
          longitude: 100.574411,
        ),
      ],
    },

    // 15. คณะสัตวแพทยศาสตร์
    {
      'title': 'คณะสัตวแพทยศาสตร์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะสัตวแพทยศาสตร์',
      'icon': Icons.pets,
      'color': const Color(0xFF009688),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'VET01',
          name: 'โรงอาหารคณะ สัตวแพทยศาสตร์ (บาร์หมา)',
          latitude: 13.843778,
          longitude: 100.577427,
        ),
        AppWayPoint(
          id: 'VET03',
          name: 'อาคารเฉลิมพระเกียรติ 6 รอบ พระชนมพรรษา',
          latitude: 13.844377,
          longitude: 100.577447,
        ),
        AppWayPoint(
          id: 'VET04',
          name: 'อาคารการเรียน-วิจัยและปฎิบัติการเชี่ยวชาญพิเศษ',
          latitude: 13.844437,
          longitude: 100.577869,
        ),
        AppWayPoint(
          id: 'VET05',
          name: 'อาคารสนับสนุนและอำนวยการ',
          latitude: 13.844812,
          longitude: 100.577884,
        ),
        AppWayPoint(
          id: 'VET06',
          name: 'อาคารจักรพิชัยรณรงค์สงคราม',
          latitude: 13.844635,
          longitude: 100.576863,
        ),
        AppWayPoint(
          id: 'VET07',
          name: 'อาคารเรียนและปฏิบัติการ คณะสัตวแพทย์ศาสตร์',
          latitude: 13.845164,
          longitude: 100.577110,
        ),
        AppWayPoint(
          id: 'VET08',
          name: 'อาคารเรียนและปฏิบัติการกายวิภาคศาสตร์',
          latitude: 13.845069,
          longitude: 100.576500,
        ),
      ],
    },

    // 16. คณะเทคนิคการสัตวแพทย์
    {
      'title': 'คณะเทคนิคการสัตวแพทย์',
      'desc': 'สถานที่จัดการเรียนการสอน คณะเทคนิคการสัตวแพทย์',
      'icon': Icons.healing,
      'color': const Color(0xFF009688),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'VTE01',
          name: 'อาคารเรียนและปฎิบัติการ (อาคาร 1)',
          latitude: 13.845547,
          longitude: 100.576516,
        ),
        AppWayPoint(
          id: 'VTE02',
          name: 'ศาลาอ่านหนังสือ 2',
          latitude: 13.845747,
          longitude: 100.576725,
        ),
        AppWayPoint(
          id: 'VTE03',
          name: 'ห้องประชุมคณะเทคนิคการสัตวแพทย์',
          latitude: 13.845843,
          longitude: 100.576688,
        ),
        AppWayPoint(
          id: 'VTE04',
          name: 'อาคารเรียนและปฏิบัติการรวมทางด้านเทคนิคการสัตวแพทย์',
          latitude: 13.846017,
          longitude: 100.576319,
        ),
        AppWayPoint(
          id: 'VTE05',
          name: 'โรงอาหารคณะเทคนิคการสัตวแพทย์',
          latitude: 13.845954,
          longitude: 100.576659,
        ),
        AppWayPoint(
          id: 'VTE06',
          name: 'อาคารสัตว์ทดลองเพื่อการวิจัย (อาคาร 2)',
          latitude: 13.846330,
          longitude: 100.576678,
        ),
      ],
    },
    // =========================================================
    // กลุ่มสถาบันค้นคว้าและศูนย์วิจัย (Research Institutes)
    // =========================================================

    // 17. สถาบันค้นคว้าและพัฒนาผลิตภัณฑ์อาหาร (IFRPD)
    {
      'title': 'สถาบันค้นคว้าและพัฒนาผลิตภัณฑ์อาหาร',
      'desc': 'สถาบันค้นคว้าและพัฒนาผลิตภัณฑ์อาหาร (IFRPD)',
      'icon': Icons.set_meal,
      'color': const Color(0xFF8D6E63),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'RES_FD01',
          name: 'อาคารอมรภูมิรัตน์',
          latitude: 13.853595,
          longitude: 100.571096,
        ),
        AppWayPoint(
          id: 'RES_FD02',
          name: 'โรงจอดรถ (3โรง)',
          latitude: 13.853727,
          longitude: 100.571715,
        ),
        AppWayPoint(
          id: 'RES_FD03',
          name: 'อาคารที่ทำการพนักงานขับรถ',
          latitude: 13.853629,
          longitude: 100.571889,
        ),
        AppWayPoint(
          id: 'RES_FD04',
          name: 'อาคารสโตร์และซ่อมบำรุง',
          latitude: 13.854055,
          longitude: 100.570651,
        ),
        AppWayPoint(
          id: 'RES_FD05',
          name: 'โรงงานผลิตทดลอง 2',
          latitude: 13.854058,
          longitude: 100.570906,
        ),
        AppWayPoint(
          id: 'RES_FD06',
          name: 'อาคารบอยเลอร์และคลังเก็บวัสดุ',
          latitude: 13.854099,
          longitude: 100.571139,
        ),
        AppWayPoint(
          id: 'RES_FD07',
          name: 'คลังน้ำมัน',
          latitude: 13.853922,
          longitude: 100.571130,
        ),
        AppWayPoint(
          id: 'RES_FD08',
          name: 'อาคารโรงงานผลิตทดลอง 1',
          latitude: 13.854053,
          longitude: 100.571523,
        ),
      ],
    },

    // 18. สถาบันค้นคว้าและพัฒนาผลิตผลทางการเกษตรฯ (KAPI)
    {
      'title': 'สถาบันค้นคว้าและพัฒนาผลิตผลทางการเกษตรฯ',
      'desc': 'สถาบันค้นคว้าและพัฒนาผลิตผลทางการเกษตรและอุตสาหกรรมเกษตร',
      'icon': Icons.eco,
      'color': const Color(0xFF4CAF50),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'RES_KAPI01',
          name: 'อาคารเทคโนโลยีการผลิตแบบการผลิตเยื่อกระดาษ',
          latitude: 13.854058,
          longitude: 100.571935,
        ),
        AppWayPoint(
          id: 'RES_KAPI02',
          name: 'อาคารปฏิบัติการวิจัยกลาง (ใช้พื้นที่ด้านทิศตะวันตก)',
          latitude: 13.853477,
          longitude: 100.571981,
        ),
        AppWayPoint(
          id: 'RES_KAPI03',
          name:
              'สถาบันค้นคว้าและพ้ฒนาผลิตผลทางการเกษตรและอุตสาหกกมเกษตร เรือนเพาะชำ 1',
          latitude: 13.853051,
          longitude: 100.572343,
        ),
        AppWayPoint(
          id: 'RES_KAPI04',
          name:
              'สถาบันค้นคว้าและพ้ฒนาผลิตผลทางการเกษตรและอุตสาหกกมเกษตร เรือนเพาะชำ 2',
          latitude: 13.852858,
          longitude: 100.572359,
        ),
      ],
    },

    // 19. ศูนย์วิจัยควบคุมศัตรูพืชโดยชีวินทรีย์แห่งชาติ
    {
      'title': 'ศูนย์วิจัยควบคุมศัตรูพืชฯ',
      'desc': 'ศูนย์วิจัยควบคุมศัตรูพืชโดยชีวินทรีย์แห่งชาติ',
      'icon': Icons.bug_report,
      'color': const Color(0xFF8BC34A),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'RES_BIO01',
          name: 'อาคาร biocontrol หลังที่ 1',
          latitude: 13.852463,
          longitude: 100.565335,
        ),
        AppWayPoint(
          id: 'RES_BIO02',
          name: 'อาคาร biocontrol หลังที่ 2',
          latitude: 13.852697,
          longitude: 100.565296,
        ),
        AppWayPoint(
          id: 'RES_BIO03',
          name: 'ศาลาพักผ่อน',
          latitude: 13.852350,
          longitude: 100.565610,
        ),
        AppWayPoint(
          id: 'RES_BIO04',
          name: 'ห้องน้ำ',
          latitude: 13.852469,
          longitude: 100.564851,
        ),
        AppWayPoint(
          id: 'RES_BIO05',
          name: 'ห้องพักคนงาน',
          latitude: 13.852412,
          longitude: 100.564838,
        ),
        AppWayPoint(
          id: 'RES_BIO06',
          name: 'โรงเลี้ยงแมลง 1',
          latitude: 13.852447,
          longitude: 100.564963,
        ),
        AppWayPoint(
          id: 'RES_BIO07',
          name: 'โรงเลี้ยงแมลง 2',
          latitude: 13.852375,
          longitude: 100.565099,
        ),
        AppWayPoint(
          id: 'RES_BIO08',
          name: 'โรงจอดรถ',
          latitude: 13.852224,
          longitude: 100.565212,
        ),
      ],
    },

    // 20. มูลนิธิโครงการหลวง
    {
      'title': 'มูลนิธิโครงการหลวง',
      'desc': 'สำนักงานและอาคารของมูลนิธิโครงการหลวง',
      'icon': Icons.local_florist,
      'color': const Color(0xFFE91E63),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'ROYAL01',
          name: 'อาคารสำนักงานโครงการหลวง',
          latitude: 13.849449,
          longitude: 100.564198,
        ),
        AppWayPoint(
          id: 'ROYAL02',
          name: 'อาคารจำหน่ายดอกไม้สด',
          latitude: 13.849818,
          longitude: 100.564375,
        ),
        AppWayPoint(
          id: 'ROYAL03',
          name: 'อาคารจำหน่ายผลิตภัณฑ์บุหงาโครงการหลวง',
          latitude: 13.849326,
          longitude: 100.564428,
        ),
        AppWayPoint(
          id: 'ROYAL04',
          name: 'โรงเก็บวัสดุบุหงาโครงการหลวง',
          latitude: 13.849652,
          longitude: 100.564235,
        ),
        AppWayPoint(
          id: 'ROYAL05',
          name: 'โรงเก็บผลิตภัณฑ์บุหงาโครงการหลวง (โรงอบ)',
          latitude: 13.849609,
          longitude: 100.564693,
        ),
        AppWayPoint(
          id: 'ROYAL06',
          name: 'อาคารพืชสวนเก่า 2 (เก็บบุหงา)',
          latitude: 13.849679,
          longitude: 100.564767,
        ),
        AppWayPoint(
          id: 'ROYAL07',
          name: 'โรงฟอกผลิตภัณฑ์บุหงาโครงการหลวง',
          latitude: 13.849680,
          longitude: 100.564933,
        ),
      ],
    },

    // 21. ศูนย์วิจัยและฝึกอบรมอื่นๆ
    {
      'title': 'ศูนย์วิจัยและฝึกอบรมอื่นๆ',
      'desc': 'สถาบันวิจัยและศูนย์ฝึกอบรมต่างๆ',
      'icon': Icons.science_outlined,
      'color': const Color(0xFF607D8B),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'RES_OTH01',
          name: 'อาคารสุวรรณวาจกกสิกิจ',
          latitude: 13.846647,
          longitude: 100.571678,
        ),
        AppWayPoint(
          id: 'RES_OTH02',
          name: 'อาคารพนมสมิตานนท์',
          latitude: 13.847050,
          longitude: 100.570061,
        ),
        AppWayPoint(
          id: 'RES_OTH03',
          name: 'อาคารวิทยบริการ',
          latitude: 13.843465,
          longitude: 100.571153,
        ),
        AppWayPoint(
          id: 'RES_OTH04',
          name: 'อาคารศูนย์ฝึกอบรมวนศาสตร์ชุมชนแห่งภูมิภาคเอเซียแปซิฟิก 1',
          latitude: 13.845730,
          longitude: 100.572865,
        ),
        AppWayPoint(
          id: 'RES_OTH05',
          name: 'อาคารศูนย์ฝึกอบรมวนศาสตร์ชุมชนแห่งภูมิภาคเอเซียแปซิฟิก 2',
          latitude: 13.846002,
          longitude: 100.572871,
        ),
      ],
    },

    // =========================================================
    // โรงเรียนสาธิตแห่งมหาวิทยาลัยเกษตรศาสตร์ (Demonstration School)
    // =========================================================

    // 22. โรงเรียนสาธิตแห่งมหาวิทยาลัยเกษตรศาสตร์
    {
      'title': 'โรงเรียนสาธิตแห่ง มก.',
      'desc': 'อาคารเรียนและสนามของโรงเรียนสาธิตฯ',
      'icon': Icons.child_care,
      'color': const Color(0xFF00BCD4),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'SATIT01',
          name: 'อาคาร 1',
          latitude: 13.850660,
          longitude: 100.568521,
        ),
        AppWayPoint(
          id: 'SATIT02',
          name: 'อาคาร 2',
          latitude: 13.850845,
          longitude: 100.569065,
        ),
        AppWayPoint(
          id: 'SATIT03',
          name: 'อาคาร 3',
          latitude: 13.851122,
          longitude: 100.569095,
        ),
        AppWayPoint(
          id: 'SATIT04',
          name: 'อาคาร 4 (นานาชาติ)',
          latitude: 13.851594,
          longitude: 100.569106,
        ),
        AppWayPoint(
          id: 'SATIT05',
          name: 'อาคาร 5',
          latitude: 13.851917,
          longitude: 100.567613,
        ),
        AppWayPoint(
          id: 'SATIT06',
          name: 'อาคาร 6 (อาคารศึกษานักเรียนมัธยมศึกษา)',
          latitude: 13.852500,
          longitude: 100.567630,
        ),
        AppWayPoint(
          id: 'SATIT07',
          name: 'อาคาร 7 (อาคารประถม )',
          latitude: 13.851939,
          longitude: 100.569193,
        ),
        AppWayPoint(
          id: 'SATIT08',
          name: 'อาคารคณะศึกษาศาสตร์เฉลิมพระเกียรติ 6 รอบพระชนมพรรษา',
          latitude: 13.852269,
          longitude: 100.568480,
        ),
        AppWayPoint(
          id: 'SATIT09',
          name: 'อาคารอุบลเรียงสุวรรณ',
          latitude: 13.851525,
          longitude: 100.568443,
        ),
        AppWayPoint(
          id: 'SATIT10',
          name: 'อาคารเกษตร',
          latitude: 13.852421,
          longitude: 100.566747,
        ),
        AppWayPoint(
          id: 'SATIT11',
          name: 'อาคารฝึกปฏิบัติงาน',
          latitude: 13.852184,
          longitude: 100.566789,
        ),
        AppWayPoint(
          id: 'SATIT12',
          name: 'อาคารการส่งเสริม พลานามัยและการกีฬา',
          latitude: 13.851676,
          longitude: 100.566765,
        ),
        AppWayPoint(
          id: 'SATIT13',
          name: 'อาคารทะเบียนและสถิติวัดประเมินผล',
          latitude: 13.850973,
          longitude: 100.569220,
        ),
        AppWayPoint(
          id: 'SATIT14',
          name: 'สนามฟุตบอล',
          latitude: 13.851170,
          longitude: 100.567549,
        ),
        AppWayPoint(
          id: 'SATIT15',
          name: 'สนามบาสเกตบอล',
          latitude: 13.850832,
          longitude: 100.566744,
        ),
        AppWayPoint(
          id: 'SATIT16',
          name: 'สนามเทนนิส',
          latitude: 13.851183,
          longitude: 100.566728,
        ),
      ],
    },

    // =========================================================
    // ศูนย์การเรียนรู้ และ หอสมุด (Libraries & Learning Centers)
    // =========================================================

    // 23. สำนักหอสมุด และ ศูนย์เรียนรวม
    {
      'title': 'หอสมุดและศูนย์เรียนรวม',
      'desc': 'อาคารเรียนรวม (ศร.) และห้องสมุดส่วนกลาง',
      'icon': Icons.local_library,
      'color': const Color(0xFFFF9800),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'LIB01',
          name: 'อาคารเทพรัตน์วิทยโชติ (อาคารการเรียนรู้)',
          latitude: 13.848184,
          longitude: 100.571842,
        ),
        AppWayPoint(
          id: 'LIB02',
          name: 'อาคารช่วงเกษตรศิลปการ',
          latitude: 13.847661,
          longitude: 100.571834,
        ),
        AppWayPoint(
          id: 'CEN_LRN01',
          name: 'อาคารศูนย์เรียนรวม 1',
          latitude: 13.847214,
          longitude: 100.570998,
        ),
        AppWayPoint(
          id: 'CEN_LRN02',
          name: 'อาคารศูนย์เรียนรวม 2',
          latitude: 13.849751,
          longitude: 100.569399,
        ),
        AppWayPoint(
          id: 'CEN_LRN03',
          name: 'อาคารศูนย์เรียนรวม 3',
          latitude: 13.849311,
          longitude: 100.569408,
        ),
        AppWayPoint(
          id: 'CEN_LRN04',
          name: 'อาคารเฉลิมพระเกียรติ 4 รอบพระชันษาจุฬาภรณ์ (ศูนย์เรียนรวม 4)',
          latitude: 13.850108,
          longitude: 100.569470,
        ),
      ],
    },

    // =========================================================
    // สำนักการกีฬา และ นันทนาการ (Sports Facilities)
    // =========================================================

    // 24. สำนักการกีฬา
    {
      'title': 'ศูนย์กีฬาและนันทนาการ',
      'desc': 'สนามกีฬา สระว่ายน้ำ และชมรมกีฬา',
      'icon': Icons.sports_tennis,
      'color': const Color(0xFFFF5722),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'SPO01',
          name: 'สนามอินทรีย์จันทรสถิตย์ (สนามฟุตบอล)',
          latitude: 13.847105,
          longitude: 100.565816,
        ),
        AppWayPoint(
          id: 'SPO02',
          name: 'สนามอินทรีย์จันทรสถิตย์ (ลู่ลานกรีฑา ยางสังเคราะห์ 1 ลู่)',
          latitude: 13.847138,
          longitude: 100.565784,
        ),
        AppWayPoint(
          id: 'SPO03',
          name: 'อัฒจันทร์สนาม อินทรีย์จันทรสถิตย์ 1',
          latitude: 13.847415,
          longitude: 100.565305,
        ),
        AppWayPoint(
          id: 'SPO04',
          name: 'อัฒจันทร์สนาม อินทรีย์จันทรสถิตย์ 2',
          latitude: 13.846874,
          longitude: 100.566285,
        ),
        AppWayPoint(
          id: 'SPO05',
          name: 'อาคารเสรีไตรรัตน์',
          latitude: 13.850316,
          longitude: 100.565022,
        ),
        AppWayPoint(
          id: 'SPO06',
          name: 'อาคารสระว่ายน้ำจุฬาภรณ์วลัยลักษณ์',
          latitude: 13.849752,
          longitude: 100.567184,
        ),
        AppWayPoint(
          id: 'SPO07',
          name: 'อาคารดาบสากล',
          latitude: 13.850838,
          longitude: 100.564985,
        ),
        AppWayPoint(
          id: 'SPO08',
          name: 'อาคารเอนกประสงค์ (ชมรมยูโด - ไอกิโด)',
          latitude: 13.845850,
          longitude: 100.567220,
        ),
        AppWayPoint(
          id: 'SPO09',
          name: 'สนามบาสเกตบอล 3 สนาม',
          latitude: 13.846861,
          longitude: 100.567780,
        ),
        AppWayPoint(
          id: 'SPO10',
          name: 'สนามเทนนิส',
          latitude: 13.851105,
          longitude: 100.565299,
        ),
        AppWayPoint(
          id: 'SPO11',
          name: 'สนามฮอกกี้',
          latitude: 13.851225,
          longitude: 100.566154,
        ),
        AppWayPoint(
          id: 'SPO12',
          name: 'อัฒจันทร์ สนามฮอกกี้',
          latitude: 13.851236,
          longitude: 100.565807,
        ),
        AppWayPoint(
          id: 'SPO13',
          name: 'สนามซอฟ์บอล',
          latitude: 13.852032,
          longitude: 100.566199,
        ),
        AppWayPoint(
          id: 'SPO14',
          name: 'สนามวอลเล่ย์บอล',
          latitude: 13.848431,
          longitude: 100.566017,
        ),
        AppWayPoint(
          id: 'SPO15',
          name: 'สนามตะกร้อ',
          latitude: 13.848910,
          longitude: 100.565340,
        ),
        AppWayPoint(
          id: 'SPO16',
          name: 'สนามเปตอง',
          latitude: 13.849460,
          longitude: 100.565344,
        ),
        AppWayPoint(
          id: 'SPO17',
          name: 'สนามฝึกสอนยิงธนู',
          latitude: 13.846185,
          longitude: 100.566493,
        ),
        AppWayPoint(
          id: 'SPO18',
          name: 'อาคารศูนย์วิจัยและพัฒนาวิทยาศาสตร์การกีฬา',
          latitude: 13.850664,
          longitude: 100.566306,
        ),
        AppWayPoint(
          id: 'SPO19',
          name: 'อาคารชมรมกีฬา',
          latitude: 13.845843,
          longitude: 100.566888,
        ),
        AppWayPoint(
          id: 'SPO20',
          name: 'อาคารชมรมรักบี้',
          latitude: 13.845999,
          longitude: 100.566930,
        ),
        AppWayPoint(
          id: 'SPO21',
          name: 'สระสุวรรณชาด',
          latitude: 13.844102,
          longitude: 100.576842,
        ),
      ],
    },

    // =========================================================
    // ที่พักอาศัย (Accommodations)
    // =========================================================

    // 25. หอพักนิสิตและอาคารพักบุคลากร
    {
      'title': 'ที่พักอาศัย',
      'desc': 'หอพักนิสิต อาคารพักบุคลากร และโรงแรม',
      'icon': Icons.hotel,
      'color': const Color(0xFF9B59B6),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'ACC_F01',
          name: 'หอพักหญิง (ดารารัตน์)',
          latitude: 13.849194,
          longitude: 100.566149,
        ),
        AppWayPoint(
          id: 'ACC_F02',
          name: 'หอพักหญิง (วาสนา)',
          latitude: 13.848832,
          longitude: 100.566138,
        ),
        AppWayPoint(
          id: 'ACC_M01',
          name: 'หอพักชาย (หอ12)',
          latitude: 13.848967,
          longitude: 100.567728,
        ),
        AppWayPoint(
          id: 'ACC_M02',
          name: 'หอพักชาย (หอ 14)',
          latitude: 13.848956,
          longitude: 100.568412,
        ),
        AppWayPoint(
          id: 'ACC_M03',
          name: 'หอพักชาย (ตึก 13)',
          latitude: 13.848765,
          longitude: 100.568125,
        ),
        AppWayPoint(
          id: 'ACC_M04',
          name: 'หอพักชาย (หอ 13)',
          latitude: 13.848504,
          longitude: 100.568317,
        ),
        AppWayPoint(
          id: 'ACC_M05',
          name: 'หอพักชาย (ตึก 5)',
          latitude: 13.847908,
          longitude: 100.568716,
        ),
        AppWayPoint(
          id: 'ACC_M06',
          name: 'หอพักชาย (ตึก 12)',
          latitude: 13.847625,
          longitude: 100.568051,
        ),
        AppWayPoint(
          id: 'ACC_PH01',
          name: 'อาคารหอพักนิสิต ซอยพหลโยธิน 45 หลังที่ 1 (พุทธชาด)',
          latitude: 13.852912,
          longitude: 100.580251,
        ),
        AppWayPoint(
          id: 'ACC_PH02',
          name: 'อาคารหอพักนิสิต ซอยพหลโยธิน 45 หลังที่ 2 (ขจีนุช)',
          latitude: 13.853396,
          longitude: 100.580369,
        ),
        AppWayPoint(
          id: 'ACC_PH03',
          name: 'อาคารหอพักนิสิต ซอยพหลโยธิน 45 หลังที่ 3 (ลีลาวดี)',
          latitude: 13.851884,
          longitude: 100.581119,
        ),
        AppWayPoint(
          id: 'ACC_PH04',
          name: 'อาคารหอพักนิสิต ซอยพหลโยธิน 45 หลังที่ 4 (เฟื่องฟ้า)',
          latitude: 13.852235,
          longitude: 100.581079,
        ),
        AppWayPoint(
          id: 'ACC_PH05',
          name: 'อาคารหอพักนิสิต ซอยพหลโยธิน 45 หลังที่ 5 (สุพรรณิการ์)',
          latitude: 13.852504,
          longitude: 100.581006,
        ),
        AppWayPoint(
          id: 'ACC_PH06',
          name: 'อาคารหอพักนิสิต ซอยพหลโยธิน 45 หลังที่ 6 (แสงจันทร์)',
          latitude: 13.852869,
          longitude: 100.580946,
        ),
        AppWayPoint(
          id: 'ACC_PH07',
          name: 'อาคารหอพักนิสิต ซอยพหลโยธิน 45 หลังที่ 7 (กฤษณา)',
          latitude: 13.853163,
          longitude: 100.580889,
        ),
        AppWayPoint(
          id: 'ACC_STAFF01',
          name: 'อาคารพักอาศัยบุคลากรซอยพหลโยธิน 45 (หลังที่ 1)',
          latitude: 13.854911,
          longitude: 100.578762,
        ),
        AppWayPoint(
          id: 'ACC_STAFF02',
          name: 'อาคารพักอาศัยบุคลากรซอยพหลโยธิน 45 (หลังที่ 2)',
          latitude: 13.854963,
          longitude: 100.579379,
        ),
        AppWayPoint(
          id: 'ACC_HOTEL01',
          name: 'อาคารสหกรณ์ออมทรัพย์ (KU. HOME)',
          latitude: 13.845215,
          longitude: 100.567688,
        ),
      ],
    },

    // =========================================================
    // ร้านอาหารและร้านค้า (Food & Shops)
    // =========================================================

    // 26. โรงอาหาร ร้านสะดวกซื้อ และผลิตภัณฑ์
    {
      'title': 'ร้านอาหารและร้านค้า',
      'desc': 'โรงอาหารกลาง KU Avenue และร้านสะดวกซื้อ',
      'icon': Icons.storefront,
      'color': const Color(0xFFE74C3C),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'SHP_CAN01',
          name: 'โรงอาหารกลาง 1',
          latitude: 13.848737,
          longitude: 100.567161,
        ),
        AppWayPoint(
          id: 'SHP_CAN02',
          name: 'โรงอาหารกลาง 2',
          latitude: 13.852037,
          longitude: 100.571777,
        ),
        AppWayPoint(
          id: 'SHP_CAN03',
          name: 'โรงอาหารสวัสดิการ มก.',
          latitude: 13.853130,
          longitude: 100.579452,
        ),
        AppWayPoint(
          id: 'SHP_711_01',
          name: 'ร้าน 7 eleven บริเวณโรงอาหารกลาง 1',
          latitude: 13.848938,
          longitude: 100.566853,
        ),
        AppWayPoint(
          id: 'SHP_711_02',
          name: 'ร้าน 7 eleven บริเวณศูนย์เรียนรวม 1',
          latitude: 13.847027,
          longitude: 100.570643,
        ),
        AppWayPoint(
          id: 'SHP_711_03',
          name: 'ร้าน 7 eleven (บริเวณศูนย์ผลิตภัณฑ์นม มก.)',
          latitude: 13.850636,
          longitude: 100.571596,
        ),
        AppWayPoint(
          id: 'SHP_AVE01',
          name: 'อาคาร KU Avenue (หลังที่ 1)',
          latitude: 13.845789,
          longitude: 100.565406,
        ),
        AppWayPoint(
          id: 'SHP_AVE02',
          name: 'อาคาร KU Avenue (หลังที่ 2)',
          latitude: 13.846130,
          longitude: 100.564902,
        ),
        AppWayPoint(
          id: 'SHP_COOP01',
          name: 'อาคารร้านค้าสหกรณ์ มหาวิทยาลัยเกษตรศาสตร์',
          latitude: 13.845496,
          longitude: 100.567053,
        ),
        AppWayPoint(
          id: 'SHP_MINI01',
          name: 'อาคาร KU.MINISHOP 1',
          latitude: 13.848089,
          longitude: 100.567092,
        ),
        AppWayPoint(
          id: 'SHP_MINI02',
          name: 'อาคาร KU.MINISHOP 2',
          latitude: 13.848135,
          longitude: 100.567242,
        ),
        AppWayPoint(
          id: 'SHP_MINI03',
          name: 'อาคาร KU.MINISHOP 3',
          latitude: 13.848133,
          longitude: 100.567375,
        ),
        AppWayPoint(
          id: 'SHP_MINI_WC',
          name: 'ห้องน้ำ (ข้างอาคาร KU.MINISHOP 3)',
          latitude: 13.848142,
          longitude: 100.567470,
        ),
        AppWayPoint(
          id: 'SHP_MILK01',
          name: 'อาคารสำนักงานศูนย์ผลิตภัณฑ์นม มก. อาคาร 1',
          latitude: 13.851126,
          longitude: 100.571371,
        ),
        AppWayPoint(
          id: 'SHP_MILK02',
          name: 'อาคารผลิตภัณฑ์นมเกษตร อาคาร2 (KU Dairy Processing Plant)',
          latitude: 13.850846,
          longitude: 100.571484,
        ),
        AppWayPoint(
          id: 'SHP_WATER01',
          name: 'อาคารผลิตน้ำดื่ม อาคาร 3',
          latitude: 13.851173,
          longitude: 100.571641,
        ),
        AppWayPoint(
          id: 'SHP_GREEN',
          name: 'อาคารโรงงานต้นแบบบรรจุภัณฑ์ (KU GREEN)',
          latitude: 13.852030,
          longitude: 100.570823,
        ),
      ],
    },

    // =========================================================
    // สวัสดิการและกิจกรรมนิสิต (Student Welfare & Activities)
    // =========================================================

    // 27. สถานพยาบาล อาคารกิจกรรม กองกิจการนิสิต
    {
      'title': 'สวัสดิการและกิจกรรม',
      'desc': 'สถานพยาบาล อาคารกิจกรรม และชมรม',
      'icon': Icons.local_hospital,
      'color': const Color(0xFF2ECC71),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'WEL_HOS01',
          name: 'อาคารภิญโญ (สถานพยาบาล อาคาร 1)',
          latitude: 13.846760,
          longitude: 100.568301,
        ),
        AppWayPoint(
          id: 'WEL_HOS02',
          name: 'สถานพยาบาล (อาคาร 2)',
          latitude: 13.846582,
          longitude: 100.568324,
        ),
        AppWayPoint(
          id: 'WEL_HOS03',
          name: 'สถานพยาบาล (อาคาร 3)',
          latitude: 13.846733,
          longitude: 100.568636,
        ),
        AppWayPoint(
          id: 'WEL_ACT01',
          name: 'อาคารเทพศาสตร์สถิตย์',
          latitude: 13.845722,
          longitude: 100.568398,
        ),
        AppWayPoint(
          id: 'WEL_ACT02',
          name: 'อาคารกิจกรรม มก. ศูนย์บริการมัลติมีเดีย (อาคาร 3)',
          latitude: 13.845458,
          longitude: 100.568054,
        ),
        AppWayPoint(
          id: 'WEL_ACT03',
          name: 'อาคารเอนกประสงค์ (กิจกรรมศิลปวัฒนธรรม)',
          latitude: 13.846539,
          longitude: 100.564186,
        ),
        AppWayPoint(
          id: 'WEL_ACT04',
          name: 'อาคารกองกิจการนิสิต',
          latitude: 13.847259,
          longitude: 100.568593,
        ),
        AppWayPoint(
          id: 'WEL_ACT05',
          name: 'กองกิจการนิสิต (ตึก 8)',
          latitude: 13.847945,
          longitude: 100.567313,
        ),
        AppWayPoint(
          id: 'WEL_ACT06',
          name: 'กองกิจการนิสิต (หอ 2)',
          latitude: 13.847601,
          longitude: 100.567387,
        ),
        AppWayPoint(
          id: 'WEL_ACT07',
          name: 'กองกิจการนิสิต (หอ 4)',
          latitude: 13.847379,
          longitude: 100.567781,
        ),
        AppWayPoint(
          id: 'WEL_ACT08',
          name: 'หน่วยซ่อมบำรุง (หอ 3)',
          latitude: 13.847490,
          longitude: 100.567586,
        ),
        AppWayPoint(
          id: 'WEL_ACT09',
          name: 'อาคารเอนกประสงค์เพื่อการบริการนิสิตและบุคลากร ซอยพหลโยธิน 45',
          latitude: 13.853786,
          longitude: 100.578706,
        ),
        AppWayPoint(
          id: 'WEL_BLD01',
          name: 'ตึกชวนชม',
          latitude: 13.849199,
          longitude: 100.563752,
        ),
        AppWayPoint(
          id: 'WEL_BLD02',
          name: 'ตึกชงโค',
          latitude: 13.848732,
          longitude: 100.563489,
        ),
        AppWayPoint(
          id: 'WEL_BLD03',
          name: 'ตึกคัทลียา',
          latitude: 13.848751,
          longitude: 100.564387,
        ),
        AppWayPoint(
          id: 'WEL_BLD04',
          name: 'ตึกมหาหงส์',
          latitude: 13.848700,
          longitude: 100.564632,
        ),
        AppWayPoint(
          id: 'WEL_BLD05',
          name: 'ตึกศึกษา (Study Room)',
          latitude: 13.848512,
          longitude: 100.564518,
        ),
        AppWayPoint(
          id: 'WEL_BLD06',
          name: 'ตึกขจรรัตน์',
          latitude: 13.848424,
          longitude: 100.564196,
        ),
        AppWayPoint(
          id: 'WEL_BLD07',
          name: 'ตึกบุษกร',
          latitude: 13.848128,
          longitude: 100.564517,
        ),
        AppWayPoint(
          id: 'WEL_BLD08',
          name: 'ตึกพุทธรักษา',
          latitude: 13.848333,
          longitude: 100.565117,
        ),
        AppWayPoint(
          id: 'WEL_BLD09',
          name: 'ตึกราชาวดี',
          latitude: 13.848006,
          longitude: 100.564929,
        ),
        AppWayPoint(
          id: 'WEL_CLUB01',
          name: 'ชมรมดนตรี KU BAND',
          latitude: 13.849689,
          longitude: 100.565245,
        ),
        AppWayPoint(
          id: 'WEL_CLUB02',
          name: 'ชมรมค่ายอาสา พัฒนาชนบท',
          latitude: 13.847714,
          longitude: 100.567448,
        ),
        AppWayPoint(
          id: 'WEL_CLUB03',
          name: 'ชมรมลูกทุ่ง รวมดาวกระจุย',
          latitude: 13.846067,
          longitude: 100.565927,
        ),
        AppWayPoint(
          id: 'WEL_WEL01',
          name: 'อาคารสวัสดิการ (อาคาร 1)',
          latitude: 13.853355,
          longitude: 100.578849,
        ),
        AppWayPoint(
          id: 'WEL_WEL02',
          name: 'อาคารสวัสดิการ (อาคาร 2)',
          latitude: 13.852900,
          longitude: 100.578909,
        ),
        AppWayPoint(
          id: 'WEL_WEL03',
          name: 'อาคารสวัสดิการ (อาคาร 3)',
          latitude: 13.853462,
          longitude: 100.579737,
        ),
        AppWayPoint(
          id: 'WEL_WEL04',
          name: 'อาคารสวัสดิการ (อาคาร 4)',
          latitude: 13.853038,
          longitude: 100.579778,
        ),
        AppWayPoint(
          id: 'WEL_WEL05',
          name: 'อาคารสวัสดิการ (บ่อบำบัด )',
          latitude: 13.852942,
          longitude: 100.579332,
        ),
      ],
    },

    // =========================================================
    // ส่วนกลางและสิ่งอำนวยความสะดวก (Central Facilities)
    // =========================================================

    // 28. สำนักงานอธิการบดี ลานจอดรถ และสิ่งอำนวยความสะดวกอื่นๆ
    {
      'title': 'ส่วนกลางและสิ่งอำนวยความสะดวก',
      'desc': 'หอประชุมใหญ่ อาคารจอดรถ และสำนักงานอธิการบดี',
      'icon': Icons.domain,
      'color': const Color(0xFF7F8C8D),
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'CEN_ADM01',
          name: 'อาคารสารนิเทศ 50 ปี (สำนักงานอธิการบดี)',
          latitude: 13.853420,
          longitude: 100.569955,
        ),
        AppWayPoint(
          id: 'CEN_ADM02',
          name: 'หอประชุมใหญ่ มก.',
          latitude: 13.841352,
          longitude: 100.574711,
        ),
        AppWayPoint(
          id: 'CEN_ADM03',
          name: 'อาคารจักรพันธ์เพ็ญศิริ',
          latitude: 13.849758,
          longitude: 100.568324,
        ),
        AppWayPoint(
          id: 'CEN_ADM04',
          name:
              'อาคารระพีสาคริก (อาคารใช้งานร่วมกัน กองกิจการนิสิตและสำนักทะเบียนและประมวลผล)',
          latitude: 13.847653,
          longitude: 100.569553,
        ),
        AppWayPoint(
          id: 'CEN_ADM05',
          name: 'อาคารสำนักทะเบียนและประมวลผล',
          latitude: 13.847194,
          longitude: 100.569281,
        ),
        AppWayPoint(
          id: 'CEN_ADM06',
          name: 'อาคารกำพล อดุลวิทย์',
          latitude: 13.847514,
          longitude: 100.570003,
        ),
        AppWayPoint(
          id: 'CEN_ADM07',
          name: 'อาคารหอประวัติ มก.',
          latitude: 13.845810,
          longitude: 100.566371,
        ),
        AppWayPoint(
          id: 'CEN_ADM08',
          name: 'อาคารปฏิบัติการทางด้านคอมพิวเตอร์',
          latitude: 13.844648,
          longitude: 100.567657,
        ),
        AppWayPoint(
          id: 'CEN_ADM09',
          name: 'อาคารปฏิบัติการคอมพิวเตอร์ (อาคาร 2)',
          latitude: 13.845577,
          longitude: 100.567764,
        ),
        AppWayPoint(
          id: 'CEN_ADM10',
          name: 'อาคารศูนย์กิจกรรมมหาวิทยาลัย อาคาร 1 (ศูนย์การศึกษานานาชาติ)',
          latitude: 13.846260,
          longitude: 100.568100,
        ),
        AppWayPoint(
          id: 'CEN_ADM11',
          name: 'อาคารวิทยพัฒนา',
          latitude: 13.843084,
          longitude: 100.571601,
        ),
        AppWayPoint(
          id: 'CEN_ADM12',
          name: 'อาคารสุวรรณวาจกกสิกิจ (ไปรษณีย์เดิม)',
          latitude: 13.845778,
          longitude: 100.572294,
        ),
        AppWayPoint(
          id: 'CEN_PARK01',
          name: 'อาคารจอดรถ งามวงศ์วาน 1',
          latitude: 13.842944,
          longitude: 100.570660,
        ),
        AppWayPoint(
          id: 'CEN_PARK02',
          name: 'อาคารจอดรถ งามวงศ์วาน 2',
          latitude: 13.843565,
          longitude: 100.569554,
        ),
        AppWayPoint(
          id: 'CEN_PARK03',
          name: 'อาคารจอดรถ บางเขน',
          latitude: 13.854163,
          longitude: 100.570353,
        ),
        AppWayPoint(
          id: 'CEN_PARK04',
          name: 'อาคารจอดรถวิภาวดีรังสิต',
          latitude: 13.851368,
          longitude: 100.564422,
        ),
        AppWayPoint(
          id: 'CEN_SER01',
          name: 'อาคารที่ทำการงานรักษาความปลอดภัย (เกษตรร่วมใจ)',
          latitude: 13.845588,
          longitude: 100.565899,
        ),
        AppWayPoint(
          id: 'CEN_SER02',
          name: 'อาคารบำบัดน้ำเสีย มก.',
          latitude: 13.854973,
          longitude: 100.569997,
        ),
        AppWayPoint(
          id: 'CEN_SER03',
          name: 'อาคารโรงบริการยานพาหนะ',
          latitude: 13.851919,
          longitude: 100.564835,
        ),
        AppWayPoint(
          id: 'CEN_SER04',
          name: 'อาคารโรงบริการยานพาหนะ (โรงซ่อมครุภัณฑ์)',
          latitude: 13.851637,
          longitude: 100.564699,
        ),
        AppWayPoint(
          id: 'CEN_SER05',
          name: 'โรงรถ กองยานอาคารพาหนะ และสถานที่',
          latitude: 13.852133,
          longitude: 100.564724,
        ),
        AppWayPoint(
          id: 'CEN_SER06',
          name: 'อาคารฝ่ายช่าง',
          latitude: 13.850672,
          longitude: 100.564222,
        ),
        AppWayPoint(
          id: 'CEN_SER07',
          name: 'อาคารพุทธเกษตร',
          latitude: 13.850816,
          longitude: 100.572030,
        ),
        AppWayPoint(
          id: 'CEN_ACT01',
          name: 'อาคารโรงละคร',
          latitude: 13.847720,
          longitude: 100.563760,
        ),
        AppWayPoint(
          id: 'CEN_ACT02',
          name: 'อาคารเวทีกลางแจ้ง',
          latitude: 13.847447,
          longitude: 100.564211,
        ),
        AppWayPoint(
          id: 'CEN_ACT03',
          name: 'ศาลาบุษบก',
          latitude: 13.847319,
          longitude: 100.564406,
        ),
        AppWayPoint(
          id: 'CEN_ACT04',
          name: 'ลานเต้นรำ',
          latitude: 13.841608,
          longitude: 100.574309,
        ),
        AppWayPoint(
          id: 'CEN_ACT05',
          name: 'ศาลาหกเหลี่ยม',
          latitude: 13.841866,
          longitude: 100.576006,
        ),
      ],
    },

    // =========================================================
    // สถานที่สำคัญและประวัติศาสตร์ (Landmarks & Historical Sites)
    // =========================================================

    // 29. สถานที่สำคัญ มก.
    {
      'title': 'สถานที่สำคัญ',
      'desc': 'อนุสาวรีย์และสถานที่สำคัญทางประวัติศาสตร์ของมหาวิทยาลัย',
      'icon': Icons.account_balance, // หรือใช้ Icons.star ก็ได้ครับ
      'color': const Color(0xFFFFC107), // สีเหลืองทอง สื่อถึงความทรงคุณค่า
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'LND_01',
          name: 'อนุสาวรีย์สามบูรพาจารย์ (สามเสือเกษตร)',
          latitude: 13.842212,
          longitude: 100.573055,
          isLandmark: true,
        ),
        AppWayPoint(
          id: 'LND_02',
          name: 'พระพิรุณทรงนาค (หน้าอาคารสุวรรณวาจกกสิกิจ)',
          latitude: 13.841037,
          longitude: 100.575473,
          isLandmark: true,
        ),
        AppWayPoint(
          id: 'LND_03',
          name: 'นนทรีทรงปลูก (หน้าหอประชุมใหญ่ มก.)',
          latitude: 13.841137,
          longitude: 100.575115,
          isLandmark: true,
        ),
        AppWayPoint(
          id: 'LND_04',
          name: 'หออนุสรณ์ 60 ปี มหาวิทยาลัยเกษตรศาสตร์',
          latitude: 13.847147,
          longitude: 100.571677,
          isLandmark: true,
        ),
        AppWayPoint(
          id: 'LND_05',
          name: 'แคปซูลเวลา (Time Capsule)',
          latitude: 13.84750,
          longitude: 100.57175,
          isLandmark: true,
        ),
      ],
    },
    // =========================================================
    // วิถีเด็กเกษตร (Lifestyle & Food)
    // =========================================================

    // 30. แหล่งของกินยอดฮิต (KU Cafeterias & Food)
    {
      'title': 'แหล่งของกินยอดฮิต (บาร์ต่างๆ)',
      'desc':
          'บาร์ใหม่ บาร์ใหม่กว่า KU Avenue และร้านสะดวกซื้อที่เด็กเกษตรต้องรู้',
      'icon': Icons.restaurant,
      'color': const Color(0xFFFF5722), // สีส้มแดงสื่อถึงของกิน
      'progress': 0.0,
      'waypoints': [
        AppWayPoint(
          id: 'FOOD_BAR01',
          name: 'โรงอาหารกลาง 1 (บาร์ใหม่)',
          latitude: 13.848737,
          longitude: 100.567161,
        ),
        AppWayPoint(
          id: 'FOOD_BAR02',
          name: 'โรงอาหารกลาง 2 (บาร์ใหม่กว่า)',
          latitude: 13.852037,
          longitude: 100.571777,
        ),
        AppWayPoint(
          id: 'FOOD_BAR03',
          name: 'โรงอาหารคณะวนศาสตร์ (บาร์ไม้)',
          latitude: 13.845916,
          longitude: 100.573163,
        ),
        AppWayPoint(
          id: 'FOOD_BAR04',
          name: 'โรงอาหารคณะสัตวแพทยศาสตร์ (บาร์หมา)',
          latitude: 13.843778,
          longitude: 100.577427,
        ),
        AppWayPoint(
          id: 'FOOD_BAR05',
          name: 'อาคารสโมสรนิสิต คณะวิศวกรรมศาสตร์ (โซนบาร์วิศวะ)',
          latitude: 13.846461,
          longitude: 100.570156,
        ),
        AppWayPoint(
          id: 'FOOD_BAR06',
          name: 'โรงอาหารคณะเทคนิคการสัตวแพทย์',
          latitude: 13.845954,
          longitude: 100.576659,
        ),
        AppWayPoint(
          id: 'FOOD_BAR07',
          name: 'โรงอาหารภาควิชาคหกรรมศาสตร์',
          latitude: 13.844225,
          longitude: 100.570733,
        ),
        AppWayPoint(
          id: 'FOOD_BAR08',
          name: 'โรงอาหารสวัสดิการ มก. (โซนหอพัก พหลฯ 45)',
          latitude: 13.853130,
          longitude: 100.579452,
        ),
        AppWayPoint(
          id: 'FOOD_AVE01',
          name: 'อาคาร KU Avenue (หลังที่ 1)',
          latitude: 13.845789,
          longitude: 100.565406,
        ),
        AppWayPoint(
          id: 'FOOD_AVE02',
          name: 'อาคาร KU Avenue (หลังที่ 2)',
          latitude: 13.846130,
          longitude: 100.564902,
        ),
        AppWayPoint(
          id: 'FOOD_MILK',
          name: 'อาคารผลิตภัณฑ์นมเกษตร (KU Dairy Processing Plant)',
          latitude: 13.850846,
          longitude: 100.571484,
        ),
        AppWayPoint(
          id: 'FOOD_COOP',
          name: 'อาคารร้านค้าสหกรณ์ มหาวิทยาลัยเกษตรศาสตร์',
          latitude: 13.845496,
          longitude: 100.567053,
        ),
        AppWayPoint(
          id: 'FOOD_711_1',
          name: 'ร้าน 7 eleven บริเวณโรงอาหารกลาง 1 (บาร์ใหม่)',
          latitude: 13.848938,
          longitude: 100.566853,
        ),
        AppWayPoint(
          id: 'FOOD_711_2',
          name: 'ร้าน 7 eleven บริเวณศูนย์เรียนรวม 1 (ศร.1)',
          latitude: 13.847027,
          longitude: 100.570643,
        ),
        AppWayPoint(
          id: 'FOOD_711_3',
          name: 'ร้าน 7 eleven บริเวณศูนย์ผลิตภัณฑ์นม มก.',
          latitude: 13.850636,
          longitude: 100.571596,
        ),
        AppWayPoint(
          id: 'FOOD_MINI',
          name: 'อาคาร KU.MINISHOP 1',
          latitude: 13.848089,
          longitude: 100.567092,
        ),
        AppWayPoint(
          id: 'STARBUCKS',
          name: 'STARBUCKS',
          latitude: 13.844402,
          longitude: 100.568894,
        ),
        AppWayPoint(
          id: 'NESCAFÉ',
          name: 'NESCAFÉ',
          latitude: 13.848662,
          longitude: 100.566687,
        ),
        AppWayPoint(
          id: 'Hotto Bun',
          name: 'Hotto Bun',
          latitude: 13.85216,
          longitude: 100.57066,
        ),
      ],
    },
  ];
}
