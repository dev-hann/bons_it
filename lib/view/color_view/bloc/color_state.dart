part of 'color_bloc.dart';

abstract class ColorState extends Equatable {
  const ColorState();
  
  @override
  List<Object> get props => [];
}

class ColorInitial extends ColorState {}
