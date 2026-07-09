mkdir -p no48v

file=AudioPowerSupply_Acramonics

cp $file.kicad_prl no48v
./fixfile_sch.pl $file.kicad_sch >no48v/$file.kicad_sch
./fixfile_pro.pl $file.kicad_pro >no48v/$file.kicad_pro
