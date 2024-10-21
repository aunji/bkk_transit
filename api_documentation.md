# API Documentation สำหรับ BKK Transit

## 1. ดึงข้อมูลสถานีทั้งหมด

### Request
GET /api/stations


### Response
200
json
{
  "status": "success",
  "data": [
    {
      "id": "BTS001",
      "name": "สยาม",
      "line": "BTS สุขุมวิท"   
    },
    {
      "id": "BTS002",
      "name": "ชิดลม",
      "line": "BTS สุขุมวิท"
    }
  ]
}
404
json
{
  "status": "error",
  "message": "ไม่พบสถานีที่ระบุ",
  "errorCode": "STATION_NOT_FOUND"
}

## 2. ค้นหาเส้นทาง

### Request
POST /api/routes/search
Content-Type: application/json
{
  "startStationId": "BTS001",
  "endStationId": "MRT003"
}

### Response
201
json
{
  "status": "success",
  "data": {
    "start": {
      "id": "BTS001",
      "name": "สยาม",
      "line": "BTS สุขุมวิท"
    },
    "end": {
      "id": "MRT003",
      "name": "พระราม 9",
      "line": "MRT"
    },
    "stations": [
      {
        "id": "BTS001",
        "name": "สยาม",
        "line": "BTS สุขุมวิท"
      }
    ],
    "totalStations": 8,
    "lines": ["BTS สุขุมวิท", "MRT"],
    "estimatedTime": 25,
    "hasTransfer": true
  }
}
404
json
{
  "status": "error",
  "message": "ไม่พบสถานีที่ระบุ",
  "errorCode": "STATION_NOT_FOUND"
}

## 3. ดึงข้อมูลสถานีเฉพาะ

### Request
GET /api/stations/{stationId}

### Response
200
json
{
  "status": "success",
  "data": {
    "id": "BTS001",
    "name": "สยาม",
    "line": "BTS สุขุมวิท",
    "connections": ["BTS002", "BTS007"],
    "facilities": ["ลิฟต์", "บันไดเลื่อน", "ห้องน้ำ"],
    "nearbyPlaces": ["สยามพารากอน", "สยามเซ็นเตอร์"]
  }
}
404
json
{
  "status": "error",
  "message": "ไม่พบสถานีที่ระบุ",
  "errorCode": "STATION_NOT_FOUND"
}

## 4. ดึงข้อมูลสายรถไฟฟ้าทั้งหมด

### Request
GET /api/lines

### Response    
200
json
{
  "status": "success",
  "data": [
    {
      "id": "BTS_SUKHUMVIT",
      "name": "BTS สุขุมวิท",
      "color": "#59B949"
    },
    {
      "id": "BTS_SILOM",
      "name": "BTS สีลม",
      "color": "#0F9D58"
    },
    {
      "id": "MRT_BLUE",
      "name": "MRT สายสีน้ำเงิน",
      "color": "#1E3A8A"
    }
  ]
}
404
json
{
  "status": "error",
  "message": "ไม่พบสถานีที่ระบุ",
  "errorCode": "STATION_NOT_FOUND"
}

## 5. ดึงข้อมูลค่าโดยสาร

### Request
GET /api/fares?from={startStationId}&to={endStationId}

### Response
200
json
{
  "status": "success",
  "data": {
    "fare": 42,
    "currency": "THB"
  }
}

404
json
{
  "status": "error",
  "message": "ไม่พบสถานีที่ระบุ",
  "errorCode": "STATION_NOT_FOUND"
}

## 6. ดึงข้อมูลเวลาเดินรถ

### Request
GET /api/schedules?stationId={stationId}&direction={inbound|outbound}

### Response
200
json
{
  "status": "success",
  "data": {
    "stationId": "BTS001",
    "stationName": "สยาม",
    "direction": "outbound",
    "schedules": [
      {
        "time": "06:00",
        "destination": "หมอชิต"
      },
      {
        "time": "06:05",
        "destination": "หมอชิต"
      }
    ]
  }
}

404
json
{
  "status": "error",
  "message": "ไม่พบสถานีที่ระบุ",
  "errorCode": "STATION_NOT_FOUND"
}

## 7. รายงานปัญหาหรือเหตุขัดข้อง

### Request
POST /api/reports
Content-Type: application/json
{
  "stationId": "BTS001",
  "type": "FACILITY_ISSUE",
  "description": "ลิฟต์ขัดข้อง",
  "reportedBy": "user123"
}

### Response
201
json
{
  "status": "success",
  "data": {
    "reportId": "REP12345",
    "message": "ขอบคุณสำหรับรายงาน เราจะดำเนินการแก้ไขโดยเร็วที่สุด"
  }
}

404
json
{
  "status": "error",
  "message": "ไม่พบสถานีที่ระบุ",
  "errorCode": "STATION_NOT_FOUND"
}