abstract class NewSearchSallaState{}

class NewInitializeSearchState extends NewSearchSallaState {}

class NewGetSearchSuccessState extends NewSearchSallaState {}

class NewGetSearchErrorState extends NewSearchSallaState {
  final String error ;
  NewGetSearchErrorState(this.error) ;
}

class NewGetSearchLoadingState extends NewSearchSallaState {}
