// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Course_detals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 1;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      Course_code: fields[0] as String,
      Course_Name: fields[1] as String,
      Time_course: (fields[2] as List).cast<Timings>(),
      Total_Classes: fields[3] as int,
      Classes_present_in: fields[4] as int,
      Classes_yet: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.Course_code)
      ..writeByte(1)
      ..write(obj.Course_Name)
      ..writeByte(2)
      ..write(obj.Time_course)
      ..writeByte(3)
      ..write(obj.Total_Classes)
      ..writeByte(4)
      ..write(obj.Classes_present_in)
      ..writeByte(5)
      ..write(obj.Classes_yet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class locationAdapter extends TypeAdapter<location> {
  @override
  final int typeId = 2;

  @override
  location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return location(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      address: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, location obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is locationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimingsAdapter extends TypeAdapter<Timings> {
  @override
  final int typeId = 3;

  @override
  Timings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timings(
      Day: fields[0] as String,
      Starting_Time: fields[1] as TimeofDay,
      Ending_Time: fields[2] as TimeofDay,
    );
  }

  @override
  void write(BinaryWriter writer, Timings obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.Day)
      ..writeByte(1)
      ..write(obj.Starting_Time)
      ..writeByte(2)
      ..write(obj.Ending_Time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimeofDayAdapter extends TypeAdapter<TimeofDay> {
  @override
  final int typeId = 4;

  @override
  TimeofDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeofDay(
      hour: fields[0] as int,
      minute: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TimeofDay obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeofDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
