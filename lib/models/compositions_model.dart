class CompositionModel {
  double? age;
  double? gender;
  double? totalBilirubin;
  double? directBilirubin;
  double? alkalinePhosphotase;
  double? alamineAminotransferase;
  double? aspartateAminotransferase;
  double? totalProtiens;
  double? albumin;
  double? albuminAndGlobulinRatio;

  CompositionModel(
      {this.age,
      this.gender,
      this.totalBilirubin,
      this.directBilirubin,
      this.alkalinePhosphotase,
      this.alamineAminotransferase,
      this.aspartateAminotransferase,
      this.totalProtiens,
      this.albumin,
      this.albuminAndGlobulinRatio});

  CompositionModel fromMap(Map<String, dynamic> data) {
    return CompositionModel(
      totalBilirubin: data["Total Bilirubin"],
      directBilirubin: data["Direct Bilirubin"],
      alkalinePhosphotase: data["Alkaline Phosphotase"],
      alamineAminotransferase: data["Alamine Aminotransferase"],
      aspartateAminotransferase: data["Aspartate Aminotransferase"],
      totalProtiens: data["Total Proteins"],
      albumin: data["Albumin"],
      albuminAndGlobulinRatio: data["Albumin and Globulin Ratio"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Age"] = age;
    data["Gender"] = gender;
    data["Total_Bilirubin"] = totalBilirubin;
    data["Direct_Bilirubin"] = directBilirubin;
    data["Alkaline_Phosphotase"] = alkalinePhosphotase;
    data["Alamine_Aminotransferase"] = alamineAminotransferase;
    data["Aspartate_Aminotransferase"] = aspartateAminotransferase;
    data["Total_Protiens"] = totalProtiens;
    data["Albumin"] = albumin;
    data["Albumin_and_Globulin_Ratio"] = albuminAndGlobulinRatio;
    return data;
  }
}
