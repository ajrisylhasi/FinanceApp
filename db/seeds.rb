Kompani.create(kompania: "Kompania Test", numri_fiskal: "1239635", numri_biznesit: "75396312", numri_tvsh: "1452638", numri_identifikues: "8528528", shteti: "Kosove", qyteti: "Gjakove", adresa: "Tirana", zip: "50000",
               bank_account: "XK051701001012556636", bank: "NLB BANKA", account_holder: "Intertex shpk", corresponding_bank: "NLB Banka", swift_code: "NLPR XK PR")
User.create({first_name: "arlinduus", last_name: "Admin", name: "arlinduus", password: "Lindilindi91..", kategoria: "admin", password_confirmation: "Lindilindi91..", email: "test@test.com", tel_number: "+383 011 110"})
Client.create([{kompania: "Intertex", shteti: "Kosove", qyteti: "Gjakove", adresa: "Tirana", numri_tel: "+383 45 555 666", numri_fiskal: "123456789", numri_biz: "987654321", numri_tvsh: "258963147", konsignacioni: "Sporting", shteti_k: "Kosove", qyteti_k: "Prizren", adresa_k: "Qendra", numri_tel_k: "+383 44 999 888", term: 65, email: "test@test.com", vat:18}, {kompania: "Helo", term: 65, vat:0}])
Import.create([{nr_dud: 37515, data: "2017-07-21", transporti: 2980, client_id: 1, dogana: "3031=*=PKK MERDARE", destinimi: "2020=*=ZBD PRISHTINE"},
              {nr_dud: 39056, data: "2017-07-21", transporti: 2980, client_id: 1, dogana: "3031=*=PKK MERDARE", destinimi: "2020=*=ZBD PRISHTINE"},
              {nr_dud: 222, data: "2017-07-21", transporti: 1500, client_id: 2, dogana: "3031=*=PKK MERDARE", destinimi: "2020=*=ZBD PRISHTINE"}])
Autorizim.create([{data_leshimit: "2017-05-12", data_skadimit: "2200-07-12", shteti: "Kosove", qyteti: "Prishtine", adresa: "Bujar Roka"}])
Garancion.create(identifikimi: "234234", pershkrimi: "Garancioni 1", vlera: 10000.0, data: "2017-05-12", data_skadimit: "2030-07-12")
Garancion.create(identifikimi: "421452", pershkrimi: "Garancioni 2", vlera: 20000.0, data: "2017-05-12", data_skadimit: "2030-07-12")
Akciza.create([{lloji: "%"}, {lloji: "Pa akcize"}, {lloji: "€/Kg"}, {lloji: "€/Njesi"}])
Dogana.create([{kodi: "3031", pershkrimi: "PKK MERDARE"}])
Destinim.create([{kodi: "2020", pershkrimi: "ZBD PRISHTINE"}])
Njesi.create([{lloji: "Metra"}, {lloji: "Cope"}, {lloji: "Liter"}])
Product.create([{pershkrimi: "Tiguan Rails HBC", tarif_kodi: 17016591, qmimi: 15, articlenr: "908"}, {pershkrimi: "Touran Rails HBC", tarif_kodi: 17009630, qmimi: 25, articlenr: "911"}, {pershkrimi: "Cord Only", tarif_kodi: 17009630, qmimi: 50, articlenr: "456"}])
Normative.create([{nr_normatives: 1, product_id: 1, data: Date.today.to_s, kategoria: "auto"}, {nr_normatives: 2, product_id: 2, data: Date.today.to_s, kategoria: "auto"}, {nr_normatives: 3, product_id: 3, data: Date.today.to_s, kategoria: "auto"}])

Article.create([
{pershkrimi: 'Laminat 1550 ', tarif_kodi: 39219090, njesia: 'Metra', kodi: '25123', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe dhe shirita të tjera, prej plastike', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Laminat 1870', tarif_kodi: 39219090, njesia: 'Metra', kodi: '25124', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe dhe shirita të tjera, prej plastike', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Laminat 1700', tarif_kodi: 39219090, njesia: 'Metra', kodi: '25126', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe dhe shirita të tjera, prej plastike', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Cord', tarif_kodi: 56075090, njesia: 'Metra', kodi: '30107', pershkrimi_gjate: 'Spango, kordonë, litarëdhe kabllo, nëse janë apo jo të gërshetuara apo të pështjelluar dhe nëse janë apo jo të ngopura, veshura, mbuluara apo mbrojtura me gomë apo plastike', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Thread', tarif_kodi: 54011014, njesia: 'Metra', kodi: '30108', pershkrimi_gjate: 'Fill për qepje prej filamenteve të bëra nga njerëzit, nëse është vendosur apo jo për shitjen me pakicë', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Foam 8 mm', tarif_kodi: 56075090, njesia: 'Metra', kodi: '30111', pershkrimi_gjate: 'Spango, kordonë, litarëdhe kabllo, nëse janë apo jo të gërshetuara apo të pështjelluar dhe nëse janë apo jo të ngopura, veshura, mbuluara apo mbrojtura me gomë apo plastike', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'WindowFilm 1050mm', tarif_kodi: 39201089, njesia: 'Metra', kodi: '30205', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe dhe shirita të tjerë, prej plastike, jo celulare dhe jo të përforcuara, jo të laminuara të pambështetura apo të pakombinuara në mënyra të ngjashme e materiale të tjera', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Elastic 10mm', tarif_kodi: 58062000, njesia: 'Metra', kodi: '30408', pershkrimi_gjate: 'Pëlhura të tjera të endura, që përmbajnë ndaj peshës 5 % apo më shumë fije elastomerike apo fije gome', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Double Stick Tape', tarif_kodi: 39191080, njesia: 'Metra', kodi: '30428', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe, shirita dhe forma të tjera të rregullta, vetë ngjitëse, prej plastike, nëse janë apo jo në role', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Windows Tape 80mm', tarif_kodi: 39191080, njesia: 'Metra', kodi: '30431', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe, shirita dhe forma të tjera të rregullta, vetë ngjitëse, prej plastike, nëse janë apo jo në role', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Windows Tape 65mm', tarif_kodi: 39191080, njesia: 'Metra', kodi: '30436', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe, shirita dhe forma të tjera të rregullta, vetë ngjitëse, prej plastike, nëse janë apo jo në role', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Velcro 20mm Hard', tarif_kodi: 58061000, njesia: 'Metra', kodi: '30703', pershkrimi_gjate: 'Pëlhura të endura me file të dala jashtë dhe pëlhurat me push të krehur', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Velcro 20mm Loop', tarif_kodi: 58061000, njesia: 'Metra', kodi: '30704', pershkrimi_gjate: 'Pëlhura të endura me file të dala jashtë dhe pëlhurat me push të krehur', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Paper Cartons', tarif_kodi: 48191000, njesia: 'Cope', kodi: '90201', pershkrimi_gjate: 'Kartonet, kutite dhe valixhet, prej letre apo prej kartoni të korruguar', dogana: 0.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'paketim'},
{pershkrimi: 'Plastic Bag', tarif_kodi: 39232100, njesia: 'Metra', kodi: '90302', pershkrimi_gjate: 'Artikujt për mbajtjen apo paketimin e mallrave, prej plastike; tapat, kapakët, kupat dhe mbylles të tjerë, prej plastike: --Prej polimerive të etilenit', dogana: 10.0, akciza: 3, lloji_akcizes: '€/Kg', tvsh: 18.0, kategoria: 'paketim'},
{pershkrimi: 'Label', tarif_kodi: 39191080, njesia: 'Cope', kodi: '91104', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe, shirita dhe forma të tjera të rregullta, vetë ngjitëse, prej plastike, nëse janë apo jo në role', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'paketim'},
{pershkrimi: 'Paper Corner', tarif_kodi: 48237090, njesia: 'Cope', kodi: '99993', pershkrimi_gjate: 'Letër, karton, mbushje celulozike dhe tekstile të fibrave celulozike, të tjera, të prera me përmasa apo në forma; artikuj të tjere prej brumit të letrës, kartonit, mbushjeve celulozike apo tekstileve prej fibrave celulozike', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'paketim'},
{pershkrimi: 'ABI Tape 50mm', tarif_kodi: 39191080, njesia: 'Metra', kodi: '30433', pershkrimi_gjate: 'Pllaka, fleta, filma, krisafe, shirita dhe forma të tjera të rregullta, vetë ngjitëse, prej plastike, nëse janë apo jo në role', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'},
{pershkrimi: 'Laminat 1870', tarif_kodi: 56075090, njesia: 'Metra', kodi: '25129', pershkrimi_gjate: 'Spango, kordonë, litarëdhe kabllo, nëse janë apo jo të gërshetuara apo të pështjelluar dhe nëse janë apo jo të ngopura, veshura, mbuluara apo mbrojtura me gomë apo plastike', dogana: 10.0, akciza: 0, lloji_akcizes: 'Pa akcize', tvsh: 18.0, kategoria: 'lende'}])

AutorizimArticle.create([
{article_id:1, autorizim_id: 1, max: 20},
{article_id:2, autorizim_id: 1, max: 20},
{article_id:3, autorizim_id: 1, max: 20},
{article_id:4, autorizim_id: 1, max: 20},
{article_id:5, autorizim_id: 1, max: 20},
{article_id:6, autorizim_id: 1, max: 20},
{article_id:7, autorizim_id: 1, max: 20},
{article_id:8, autorizim_id: 1, max: 20},
{article_id:9, autorizim_id: 1, max: 20},
{article_id:10, autorizim_id: 1, max: 20},
{article_id:11, autorizim_id: 1, max: 20},
{article_id:12, autorizim_id: 1, max: 20},
{article_id:13, autorizim_id: 1, max: 20},
{article_id:14, autorizim_id: 1, max: 20},
{article_id:15, autorizim_id: 1, max: 20},
{article_id:16, autorizim_id: 1, max: 20},
{article_id:17, autorizim_id: 1, max: 20},
{article_id:18, autorizim_id: 1, max: 20},
{article_id:19, autorizim_id: 1, max: 20}])

# NormativeArticle.create([
# {normative_id: 1, article_id: 1, sasia: 3.21, mbetja: 19.51, pesha_qmimi: "0.1554265 0.6372956291310494804125780268475", mbetja_peshe: 19.51},
# {normative_id: 1, article_id: 2, sasia: 1.17, mbetja: 13.07, pesha_qmimi: "0.181683642857142857142857143 0.768988127555237295740052893757071428571428571", mbetja_peshe: 13.07},
# {normative_id: 1, article_id: 3, sasia: 0.55, mbetja: 14.16, pesha_qmimi: "0.16575345 0.664620478110688960750738949894", mbetja_peshe: 14.16},
# {normative_id: 1, article_id: 5, sasia: 40.0, mbetja: 0.0, pesha_qmimi: "0.0000735 0.00107153644193581452761102611694", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 6, sasia: 2.48, mbetja: 0.0, pesha_qmimi: "0.00116 0.035209316916994348545379475601715921597777777777777778", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 8, sasia: 3.36, mbetja: 0.0, pesha_qmimi: "0.0012 0.028931483932266992245497705214", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 16, sasia: 2.0, mbetja: 0.0, pesha_qmimi: "0.0007440625 0.005357682209679072638055130633125", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 12, sasia: 0.3, mbetja: 0.0, pesha_qmimi: "0.004 0.07822216026131446051560490648", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 13, sasia: 0.25, mbetja: 0.0, pesha_qmimi: "0.004 0.07822216026131446051560490648", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 11, sasia: 1.3, mbetja: 0.0, pesha_qmimi: "0.004666666666666666666666667 0.306459422393642954896753470464", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 7, sasia: 0.38, mbetja: 0.0, pesha_qmimi: "0.1028575 0.287171766438798293399754999775", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 18, sasia: 1.08, mbetja: 0.0, pesha_qmimi: "0.004666666666666667 0.128584373032297743313323134284444444444444444", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 9, sasia: 0.3, mbetja: 0.0, pesha_qmimi: "0.009 0.160730466290372179141653917902857142857142857", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 15, sasia: 0.072, mbetja: 0.0, pesha_qmimi: "0.095554166666666666666666667 0.241095699435558268712480876783333333333333333", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 14, sasia: 0.01, mbetja: 0.0, pesha_qmimi: "4.95 5.508206020756784588387586673888073619142857142857142857", mbetja_peshe: 0.0},
# {normative_id: 1, article_id: 17, sasia: 0.04, mbetja: 0.0, pesha_qmimi: "0.1 0.259209695094436921806474667006497583892857142857142857", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 2, sasia: 3.65, mbetja: 24.0, pesha_qmimi: "0.181683642857142857142857143 0.768988127555237295740052893715714285714285714", mbetja_peshe: 24.0},
# {normative_id: 2, article_id: 19, sasia: 1.18, mbetja: 22.0, pesha_qmimi: "0.155549166666666666666666667 0.716768808955929429820278803161925500925", mbetja_peshe: 22.0},
# {normative_id: 2, article_id: 5, sasia: 40.0, mbetja: 0.0, pesha_qmimi: "0.0000735 0.00107153644193581452761102611694", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 4, sasia: 3.04, mbetja: 0.0, pesha_qmimi: "0.01 0.063220650074213057129050540940909090909090909", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 8, sasia: 3.1, mbetja: 0.0, pesha_qmimi: "0.0012 0.028931483932266992245497705214", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 16, sasia: 2.0, mbetja: 0.0, pesha_qmimi: "0.0007440625 0.005357682209679072638055130633125", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 12, sasia: 0.3, mbetja: 0.0, pesha_qmimi: "0.004 0.07822216026131446051560490648", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 13, sasia: 0.25, mbetja: 0.0, pesha_qmimi: "0.004 0.07822216026131446051560490648", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 10, sasia: 1.28, mbetja: 0.0, pesha_qmimi: "0.0197 0.381466973329149971829525297957777777777777778", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 7, sasia: 0.38, mbetja: 0.0, pesha_qmimi: "0.1028575 0.287171766438798293399754999775", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 15, sasia: 0.1, mbetja: 0.0, pesha_qmimi: "0.095554166666666666666666667 0.241095699435558268712480876783333333333333333", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 14, sasia: 0.008, mbetja: 0.0, pesha_qmimi: "4.95 5.508206020756784588387586673888073619142857142857142857", mbetja_peshe: 0.0},
# {normative_id: 2, article_id: 17, sasia: 0.032, mbetja: 0.0, pesha_qmimi: "0.1 0.259209695094436921806474667006497583892857142857142857", mbetja_peshe: 0.0},
# {normative_id: 3, article_id: 4, sasia: 50, mbetja: 10, pesha_qmimi: "1 1", mbetja_peshe: 10}])

ImportArticle.create([
{import_id: 1, article_id: 1, sasia: 16000.0, emertimi: "1", pesha: 2486.824, qmimi: 9515.99},
{import_id: 1, article_id: 2, sasia: 14000.0, emertimi: "2", pesha: 2543.571, qmimi: 10047.10},
{import_id: 1, article_id: 3, sasia: 20000.0, emertimi: "3", pesha: 3315.069, qmimi: 12405.0},
{import_id: 1, article_id: 4, sasia: 22000.0, emertimi: "4", pesha: 220.0, qmimi: 1298.0},
{import_id: 1, article_id: 5, sasia: 1000000, emertimi: "5", pesha: 73.5, qmimi: 1000.0},
{import_id: 1, article_id: 7, sasia: 4000.0, emertimi: "6", pesha: 411.43, qmimi: 1072.0},
{import_id: 1, article_id: 8, sasia: 20000.0, emertimi: "7", pesha: 24.0, qmimi: 540.0},
{import_id: 1, article_id: 9, sasia: 3500.0, emertimi: "8", pesha: 31.5, qmimi: 525.0},
{import_id: 1, article_id: 10, sasia: 9000.0, emertimi: "9", pesha: 177.3, qmimi: 3204.0},
{import_id: 1, article_id: 18, sasia: 4500.0, emertimi: "10", pesha: 21.0, qmimi: 540.0},
{import_id: 1, article_id: 11, sasia: 1875.0, emertimi: "11", pesha: 8.75, qmimi: 536.25},
{import_id: 1, article_id: 12, sasia: 2500.0, emertimi: "12", pesha: 10.0, qmimi: 182.5},
{import_id: 1, article_id: 13, sasia: 1250.0, emertimi: "13", pesha: 5.0, qmimi: 91.25},
{import_id: 1, article_id: 15, sasia: 2400.0, emertimi: "14", pesha: 229.33, qmimi: 540.0},
{import_id: 1, article_id: 16, sasia: 32000.0, emertimi: "15", pesha: 23.81, qmimi: 160.0},
{import_id: 2, article_id: 1, sasia: 16000.0, emertimi: "1", pesha: 2445.431, qmimi: 9515.98},
{import_id: 2, article_id: 2, sasia: 14000.0, emertimi: "2", pesha: 2559.355, qmimi: 10047.10},
{import_id: 2, article_id: 3, sasia: 10000.0, emertimi: "3", pesha: 1661.293, qmimi: 6202.5},
{import_id: 2, article_id: 19, sasia: 4800.0, emertimi: "4", pesha: 746.636, qmimi: 3185.52},
{import_id: 2, article_id: 4, sasia: 20000.0, emertimi: "5", pesha: 200.0, qmimi: 1180.0},
{import_id: 2, article_id: 5, sasia: 500000.0, emertimi: "6", pesha: 36.75, qmimi: 500.0},
{import_id: 2, article_id: 6, sasia: 9000.0, emertimi: "7", pesha: 10.44, qmimi: 293.4},
{import_id: 2, article_id: 7, sasia: 5600.0, emertimi: "8", pesha: 575.0, qmimi: 1500.8},
{import_id: 2, article_id: 8, sasia: 40000.0, emertimi: "9", pesha: 48.0, qmimi: 1080.0},
{import_id: 2, article_id: 18, sasia: 10500.0, emertimi: "10", pesha: 48.99, qmimi: 1260.0},
{import_id: 2, article_id: 11, sasia: 3750.0, emertimi: "11", pesha: 17.5, qmimi: 1072.5},
{import_id: 2, article_id: 12, sasia: 2500.0, emertimi: "12", pesha: 10.0, qmimi: 182.5},
{import_id: 2, article_id: 13, sasia: 2500.0, emertimi: "13", pesha: 10.0, qmimi: 182.5},
{import_id: 2, article_id: 15, sasia: 800.0, emertimi: "14", pesha: 76.44, qmimi: 180.0},
{import_id: 2, article_id: 14, sasia: 140.0, emertimi: "15", pesha: 693.0, qmimi: 714.0},
{import_id: 2, article_id: 17, sasia: 560.0, emertimi: "16", pesha: 56.0, qmimi: 134.4},
{import_id: 3, article_id: 4, sasia: 500, emertimi: "500", pesha: 500, qmimi: 100}])

AutorizimProduct.create([
  {autorizim_id: 1, product_id: 1},
  {autorizim_id: 1, product_id: 2},
  {autorizim_id: 1, product_id: 3},
])

Export.create(nr_exportit: "R-65334", data: Date.today, client: Client.first)
Fatura.create(export_id: 1, data: Date.today, nr_fatures: "Not Set")