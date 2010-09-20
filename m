From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] po/sv.po: Add Swedish translation.
Date: Mon, 20 Sep 2010 11:17:40 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009201116430.22862@ds9.cixit.se>
References: <0001.Command.names.should.not.be.translated.20100920@softwolves.pp.se> <0002.po.sv.po.Add.Swedish.translation.patch.20100920@softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	Swedish <tp-sv@listor.tp-sv.se>
X-From: git-owner@vger.kernel.org Mon Sep 20 12:18:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxdRt-0007Uc-T8
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 12:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab0ITKR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 06:17:56 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:41422 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755778Ab0ITKRz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 06:17:55 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8KAHeRI002156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Sep 2010 12:17:40 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o8KAHeIT002153;
	Mon, 20 Sep 2010 12:17:40 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <0002.po.sv.po.Add.Swedish.translation.patch.20100920@softwolves.pp.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 20 Sep 2010 12:17:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156610>

Peter Krefting:

> po/sv.po | 2967 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++

Changes between the previously posted version and this one:

G =3D sv-old.po
N =3D sv-new.po
   # Swedish translation of git
   # Copyright =C2=A9 2010 Peter krefting <peter@softwolves.pp.se>
   # Peter Krefting <peter@softwolves.pp.se>, 2010.
   #
   msgid ""
  msgstr ""
  "Project-Id-Version: git 1.7.3\n"
  "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
G "POT-Creation-Date: 2010-09-10 20:09+0100\n"
G "PO-Revision-Date: 2010-09-12 21:07+0100\n"
N "POT-Creation-Date: 2010-09-20 08:50+0100\n"
N "PO-Revision-Date: 2010-09-16 12:24+0100\n"
  "Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
  "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
  "MIME-Version: 1.0\n"
   "Content-Type: text/plain; charset=3DUTF-8\n"
   "Content-Transfer-Encoding: 8bit\n"
   "Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"


  #: builtin/add.c:41
  #, c-format
  msgid "unexpected diff status %c"
G msgstr "diff-status %c f=C3=B6rv=C3=A4ntades inte"
N msgstr "ov=C3=A4ntad diff-status %c"

  #: builtin/add.c:67 builtin/commit.c:244
  msgid "updating files failed"
   msgstr "misslyckades uppdatera filer"


  #: builtin/add.c:191
  msgid "Unstaged changes after refreshing the index:"
G msgstr "Osp=C3=A5rade =C3=A4ndringar efter att ha uppdaterat indexet:=
"
N msgstr "Ok=C3=B6ade =C3=A4ndringar efter att ha uppdaterat indexet:"

  #: builtin/add.c:194 builtin/add.c:452 builtin/rm.c:194
  #, c-format

  #: builtin/archive.c:17
  #, c-format
  msgid "could not create archive file '%s'"
G msgstr "Kunde inte skapa arkivfilen \"%s\""
N msgstr "kunde inte skapa arkivfilen \"%s\""

  #: builtin/archive.c:20
  msgid "could not redirect output"
   msgstr "kunde inte omdirigera utdata"


   #: builtin/branch.c:136
   #, c-format
   msgid ""
  "deleting branch '%s' that has been merged to\n"
  "         '%s', but it is not yet merged to HEAD."
  msgstr ""
G "tar bort grenen \"%s\" som inte har slagits ihop med\n"
N "tar bort grenen \"%s\" som har slagits ihop med\n"
  "         \"%s\", men som =C3=A4nnu inte slagits ihop med HEAD."

  #: builtin/branch.c:140
   #, c-format
   msgid ""
  "not deleting branch '%s' that is not yet merged to\n"
  "         '%s', even though it is merged to HEAD."
  msgstr ""
G "tar inte bort grenen \"%s\" som inte har slagits ihop med\n"
N "tar inte bort grenen \"%s\" som =C3=A4nnu inte har slagits ihop med\=
n"
  "         \"%s\", trots att den har slagits ihop med HEAD."

  #. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
   #: builtin/branch.c:161

  #: builtin/branch.c:198
  #, c-format
  msgid "Couldn't look up commit object for '%s'"
G msgstr "Kunde inte sl=C3=A5 upp incheckningsobjekt f=C3=B6r \"%s\""
N msgstr "Kunde inte sl=C3=A5 upp incheckningsobjektet f=C3=B6r \"%s\""

  #: builtin/branch.c:204
  #, c-format

  #: builtin/branch.c:557
  msgid "cannot rename the current branch while not on any."
G msgstr ""
G "kunde inte byta namn p=C3=A5 aktuell gren n=C3=A4r du inte befinner =
dig p=C3=A5 n=C3=A5gon."
N msgstr "kan inte byta namn p=C3=A5 aktuell gren n=C3=A4r du inte befi=
nner dig p=C3=A5 n=C3=A5gon."

  #: builtin/branch.c:567 builtin/branch.c:571
  #, c-format
  msgid "Invalid branch name: '%s'"
G msgstr "Felaktigt namn p=C3=A5 gren: \"%s\""
N msgstr "Felaktigt grennamn: \"%s\""

  #: builtin/branch.c:574
  #, c-format
  msgid "A branch named '%s' already exists."
G msgstr "Det finns redan en gren som heter \"%s\""
N msgstr "Det finns redan en gren som heter \"%s\"."

  #: builtin/branch.c:580
  msgid "Branch rename failed"
G msgstr "Misslyckades byta namn p=C3=A5 gren"
N msgstr "Misslyckades byta grennamn"

  #: builtin/branch.c:584
  #, c-format

  #: builtin/checkout.c:554
  #, c-format
  msgid "Switched to and reset branch '%s'\n"
G msgstr "V=C3=A4xlade till och nollst=C3=A4llde grenen \"%s\"\n"
N msgstr "Bytte till och nollst=C3=A4llde grenen \"%s\"\n"

  #: builtin/checkout.c:556
  #, c-format
  msgid "Switched to a new branch '%s'\n"
G msgstr "V=C3=A4xlade till en ny gren \"%s\"\n"
N msgstr "Bytte till en ny gren \"%s\"\n"

  #: builtin/checkout.c:558
  #, c-format
  msgid "Switched to branch '%s'\n"
G msgstr "V=C3=A4xlade till grenen \"%s\"\n"
N msgstr "Bytte till grenen \"%s\"\n"

  #: builtin/checkout.c:575
  msgid "HEAD is now at"
   msgstr "HEAD =C3=A4r nu p=C3=A5"

  #: builtin/checkout.c:603
  msgid "You are on a branch yet to be born"
G msgstr "Du =C3=A4r p=C3=A5 en gren som =C3=A4nnu inte =C3=A4r f=C3=B6=
dd"
N msgstr "Du =C3=A4r p=C3=A5 en gren som =C3=A4nnu inte finns"

  #: builtin/checkout.c:617
  msgid "Previous HEAD position was"
   msgstr "Tidigare position f=C3=B6r HEAD var"


  #: builtin/checkout.c:744
  msgid "--track needs a branch name"
G msgstr "--track beh=C3=B6ver ett namn p=C3=A5 en gren"
N msgstr "--track beh=C3=B6ver ett grennamn"

  #: builtin/checkout.c:751
  msgid "Missing branch name; try -b"
   msgstr "Grennamn saknas; f=C3=B6rs=C3=B6k med -b"

  #: builtin/checkout.c:757
  msgid "--orphan and -b|-B are mutually exclusive"
G msgstr "--orphan och --b|-B kan inte anv=C3=A4ndas samtidigt"
N msgstr "--orphan och -b|-B kan inte anv=C3=A4ndas samtidigt"

  #: builtin/checkout.c:759
  msgid "--orphan cannot be used with -t"
   msgstr "--orphan kan inte anv=C3=A4ndas med -t"


   #: builtin/checkout.c:886
   #, c-format
   msgid ""
  "git checkout: updating paths is incompatible with switching branches=
=2E\n"
  "Did you intend to checkout '%s' which can not be resolved as commit?=
"
  msgstr ""
G "git checkout: uppdatera s=C3=B6kv=C3=A4gar =C3=A4r inkompatibelt med=
 att v=C3=A4xla gren.\n"
N "git checkout: uppdatera s=C3=B6kv=C3=A4gar =C3=A4r inkompatibelt med=
 att byta gren.\n"
  "Ville du checka ut \"%s\" som inte kan l=C3=B6sas som en sammanslani=
ng?"

  #: builtin/checkout.c:888
  msgid "git checkout: updating paths is incompatible with switching br=
anches."
G msgstr "git checkout: uppdatera s=C3=B6kv=C3=A4gar =C3=A4r inkompatib=
elt med att v=C3=A4xla gren."
N msgstr "git checkout: uppdatera s=C3=B6kv=C3=A4gar =C3=A4r inkompatib=
elt med att byta gren."

  #: builtin/checkout.c:893
  msgid ""
   "git checkout: --ours/--theirs, --force and --merge are incompatible=
 when\n"
   "checking out of the index."
   msgstr ""
   "git checkout: --ours/--theirs, --force och --merge =C3=A4r inkompat=
ibla n=C3=A4r\n"
   "du checkar ut fr=C3=A5n indexet."

  #: builtin/checkout.c:904
  #, c-format
  msgid "git checkout: we do not like '%s' as a branch name."
G msgstr "git checkout: vi tycker inte om \"%s\" som namn p=C3=A5 en gr=
en."
N msgstr "git checkout: vi tycker inte om \"%s\" som grennamn."

  #: builtin/checkout.c:909
  #, c-format

  #: builtin/checkout.c:916
  msgid "Cannot switch branch to a non-commit."
G msgstr "Kan inte v=C3=A4xla gren p=C3=A5 en icke-incheckning."
N msgstr "Kan inte byta gren p=C3=A5 en icke-incheckning."

  #: builtin/checkout.c:919
  msgid "--ours/--theirs is incompatible with switching branches."
G msgstr "--ours/--theirs =C3=A4r inkompatibla n=C3=A4r du v=C3=A4xlar =
gren."
N msgstr "--ours/--theirs =C3=A4r inkompatibla n=C3=A4r du byta gren."

  #: builtin/clean.c:78
  msgid "-x and -X cannot be used together"
   msgstr "-x och -X kan inte anv=C3=A4ndas samtidigt"


  #: builtin/commit.c:271
  msgid "failed to unpack HEAD tree object"
G msgstr "misslyckades packa upp HEAD:s tr=C3=A4dobjekt"
N msgstr "misslyckades packa upp HEAD-tr=C3=A4dobjektet"

  #: builtin/commit.c:299
  msgid "interactive add failed"
   msgstr "interaktiv till=C3=A4ggning misslyckades"


  #: builtin/commit.c:380
  msgid "cannot do a partial commit during a merge."
G msgstr "kan inte utf=C3=B6ra en delvis incheckning under en sammansla=
gning."
N msgstr "kan inte utf=C3=B6ra en partiell incheckning under en sammans=
lagning."

  #: builtin/commit.c:389
  msgid "cannot read the index"
   msgstr "kan inte l=C3=A4sa indexet"


  #: builtin/commit.c:456 builtin/commit.c:1294
  msgid "could not parse HEAD commit"
G msgstr "kunde inte tolka HEAD:s incheckning"
N msgstr "kunde inte tolka HEAD-incheckningen"

  #: builtin/commit.c:475 builtin/commit.c:481
  #, c-format

   #: builtin/commit.c:650
   #, c-format
   msgid ""
   "#\n"
   "# It looks like you may be committing a MERGE.\n"
   "# If this is not correct, please remove the file\n"
   "#\t%s\n"
   "# and try again.\n"
   "#\n"
  msgstr ""
  "#\n"
  "# Det verkar som du checkar in en SAMMANSLAGNING.\n"
G "# Om det inte st=C3=A4mmer tar du bort filen\n"
N "# Om det inte st=C3=A4mmer s=C3=A5 ta bort filen\n"
  "#\t%s\n"
G "# och f=C3=B6rs=C3=B6ker igen.\n"
N "# och f=C3=B6rs=C3=B6k igen.\n"
  "#\n"

  #: builtin/commit.c:659
   #, c-format

   #: builtin/commit.c:663
   #, c-format
   msgid ""
   " Lines starting\n"
  "# with '#' will be ignored, and an empty message aborts the commit.\=
n"
  msgstr ""
  " Rader som inleds\n"
G "# med \"#\" kommer ignoreras, och ett tomt meddelande avbryter "
N "# med \"#\" kommer att ignoreras, och ett tomt meddelande avbryter "
  "incheckningen.\n"

  #: builtin/commit.c:668
   #, c-format
   msgid ""
   " Lines starting\n"
   "# with '#' will be kept; you may remove them yourself if you want t=
o.\n"
  "# An empty message aborts the commit.\n"
  msgstr ""
  " Rader som inleds\n"
G "# med \"#\" kommer beh=C3=A5llas; du kan sj=C3=A4lv ta bort dem om d=
u vill.\n"
N "# med \"#\" kommer att beh=C3=A5llas; du kan sj=C3=A4lv ta bort dem =
om du vill.\n"
  "# Ett tomt meddelande avbryter incheckningen.\n"

  #: builtin/commit.c:680
   #, c-format

  #: builtin/commit.c:737
  msgid "Error building trees"
G msgstr "Fel vid byggande av tr=C3=A4d"
N msgstr "Fel vid skapande av tr=C3=A4d"

  #: builtin/commit.c:752 builtin/tag.c:321
  #, c-format
  msgid "Please supply the message using either -m or -F option.\n"
G msgstr "Ange meddelandet en av flaggorna -m eller -F.\n"
N msgstr "Ange meddelandet med en av flaggorna -m eller -F.\n"

  #: builtin/commit.c:832
  #, c-format

  #: builtin/commit.c:880
  msgid "You are in the middle of a merge -- cannot amend."
G msgstr "Du =C3=A4r i mitten av en incheckning -- kan inte ut=C3=B6ka.=
"
N msgstr "Du =C3=A4r i mitten av en sammanslagning -- kan inte ut=C3=B6=
ka."

  #: builtin/commit.c:889
  msgid "Only one of -c/-C/-F can be used."
   msgstr "Kan endast anv=C3=A4nda en av -c/-C/-F."


  #: builtin/commit.c:943
  msgid "Explicit paths specified without -i nor -o; assuming --only pa=
ths..."
G msgstr "Explicita s=C3=B6kv=C3=A4gar angavs utan -i eller -o; antar -=
-only-paths..."
N msgstr "Explicita s=C3=B6kv=C3=A4gar angavs utan -i eller -o; antar -=
-only-s=C3=B6kv=C3=A4gar..."

  #: builtin/commit.c:953
  #, c-format

  #: builtin/commit.c:1142
  msgid "couldn't look up newly created commit"
G msgstr "kunde inte sl=C3=A5 upp en precis skapad incheckning"
N msgstr "kunde inte hitta en nyskapad incheckning"

  #: builtin/commit.c:1144
  msgid "could not parse newly created commit"
G msgstr "kunde inte tolka en precis skapad incheckning"
N msgstr "kunde inte tolka en nyskapad incheckning"

  #: builtin/commit.c:1185
  msgid "detached HEAD"
   msgstr "fr=C3=A5nkopplad HEAD"


  #: builtin/commit.c:1375
  msgid "cannot lock HEAD ref"
G msgstr "kunde inte l=C3=A5sa HEAD-referens"
N msgstr "kan inte l=C3=A5sa HEAD-referensen"

  #: builtin/commit.c:1379
  msgid "cannot update HEAD ref"
G msgstr "kunde inte uppdatera HEAD-referens"
N msgstr "kan inte uppdatera HEAD-referensen"

  #: builtin/commit.c:1388
  msgid ""
   "Repository has been updated, but unable to write\n"
   "new_index file. Check that disk is not full or quota is\n"
   "not exceeded, and then \"git reset HEAD\" to recover."
   msgstr ""
   "Arkivet har uppdaterats, men kunde inte skriva filen\n"
   "new_index. Kontrollera att disken inte =C3=A4r full och\n"
   "att kvoten inte har =C3=B6verskridits, och k=C3=B6r sedan\n"
   "\"git reset HEAD\" f=C3=B6r att =C3=A5terst=C3=A4lla."

  #: builtin/describe.c:205
  #, c-format
  msgid "annotated tag %s not available"
G msgstr "den dekorerade taggen %s inte tillg=C3=A4nglig"
N msgstr "den annoterade taggen %s inte tillg=C3=A4nglig"

  #: builtin/describe.c:209
  #, c-format
  msgid "annotated tag %s has no embedded name"
G msgstr "den dekorerade taggen %s har inget inb=C3=A4ddat namn"
N msgstr "den annoterade taggen %s har inget inb=C3=A4ddat namn"

  #: builtin/describe.c:211
  #, c-format

   #: builtin/describe.c:319
   #, c-format
   msgid ""
  "No annotated tags can describe '%s'.\n"
  "However, there were unannotated tags: try --tags."
  msgstr ""
G "Inga dekorerade taggar kan beskriva \"%s\".\n"
G "Det finns dock odekorerade taggar: testa --tags."
N "Inga annoterade taggar kan beskriva \"%s\".\n"
N "Det finns dock icke-annoterade taggar: testa --tags."

  #: builtin/describe.c:323
  #, c-format

  #: builtin/fetch.c:325 builtin/fetch.c:648
  #, c-format
  msgid "cannot open %s: %s\n"
G msgstr "kan inte =C3=B6ppna %s. %s\n"
N msgstr "kan inte =C3=B6ppna %s: %s\n"

  #: builtin/fetch.c:403
  #, c-format

  #: builtin/fetch.c:917
  msgid "Fetching a group and specifying refspecs does not make sense"
G msgstr "Kan inte h=C3=A4mta fr=C3=A5n grupp och ange referensspecifik=
ationer"
N msgstr ""
N "Det =C3=A4r inte m=C3=B6jligt att h=C3=A4mta fr=C3=A5n grupp och sam=
tidigt ange ref."
N "specifikationer"

  #: builtin/gc.c:63
  #, c-format
  msgid "Invalid %s: '%s'"
G msgstr "Felaktigt %s: \"%s\""
N msgstr "Felaktig %s: \"%s\""

  #: builtin/gc.c:78
  msgid "Too many options specified"
   msgstr "F=C3=B6r m=C3=A5nga flaggor angavs"


  #: builtin/grep.c:252
  #, c-format
  msgid "grep: failed to create thread: %s"
G msgstr "grep: misslyckades skapa tr=C3=A5d. %s"
N msgstr "grep: misslyckades skapa tr=C3=A5d: %s"

  #: builtin/grep.c:457
  #, c-format

  #: builtin/grep.c:703
  #, c-format
  msgid "unable to grep from object of type %s"
G msgstr "Kunde inte \"grep\" fr=C3=A5n objekt av typen %s"
N msgstr "Kunde inte utf=C3=B6ra texts=C3=B6kning (grep) fr=C3=A5n obje=
kt av typen %s"

  #: builtin/grep.c:755
  #, c-format
  msgid "switch `%c' expects a numerical value"
G msgstr "flaggan \"%c\" antar ett numeriskt v=C3=A4rde"
N msgstr "flaggan \"%c\" f=C3=B6rv=C3=A4ntar ett numeriskt v=C3=A4rde"

  #: builtin/grep.c:771
  #, c-format

  #: builtin/init-db.c:34
  #, c-format
  msgid "Could not make %s writable by group"
G msgstr "Kunde inte g=C3=B6ra %s skrivbar f=C3=B6r grubben"
N msgstr "Kunde inte g=C3=B6ra %s skrivbar f=C3=B6r gruppen"

  #: builtin/init-db.c:61
  #, c-format

  #: builtin/init-db.c:96
  #, c-format
  msgid "cannot readlink '%s'"
G msgstr "kan inte l=C3=A4sa l=C3=A4nk (readlink) \"%s\""
N msgstr "kan inte l=C3=A4sa l=C3=A4nken (readlink) \"%s\""

  #: builtin/init-db.c:98
  #, c-format

   #: builtin/init-db.c:356
  msgid "Initialized empty"
  msgstr "Initierade tomt"

   # Adding "och" for readability
  #: builtin/init-db.c:357
  msgid " shared"
G msgstr " delat"
N msgstr " och delat"

  #: builtin/init-db.c:376
  msgid "cannot tell cwd"
G msgstr "kan inte l=C3=A4sa aktuell katalog (cwd)"
N msgstr "kan inte avg=C3=B6ra aktuell katalog (cwd)"

  #: builtin/init-db.c:450 builtin/init-db.c:457
  #, c-format

  #: builtin/log.c:630
  msgid "name of output directory is too long"
G msgstr "namn p=C3=A5 utdatakatalogen =C3=A4r f=C3=B6r l=C3=A5ng"
N msgstr "namnet p=C3=A5 utdatakatalogen =C3=A4r f=C3=B6r l=C3=A5ngt"

  #: builtin/log.c:641
  #, c-format

  #: builtin/log.c:1166
  msgid "standard output, or directory, which one?"
G msgstr "standard ut, eller katalog, vilken skall det vara?"
N msgstr "standard ut, eller katalog, vilket skall det vara?"

  #: builtin/log.c:1168
  #, c-format

  #: builtin/merge.c:223
  msgid "could not run stash."
G msgstr "kunde k=C3=B6ra stash."
N msgstr "kunde inte k=C3=B6ra stash."

  #: builtin/merge.c:228
  msgid "stash failed"
   msgstr "stash misslyckades"


  #: builtin/merge.c:396
  #, c-format
  msgid "'%s' does not point to a commit"
G msgstr "\"%s\" verkar inte peka p=C3=A5 en incheckning"
N msgstr "\"%s\" pekar inte p=C3=A5 en incheckning"

  #: builtin/merge.c:491
  #, c-format

  #: builtin/merge.c:651
  #, c-format
  msgid "Unknown option for merge-recursive: -X%s"
G msgstr "Felaktig flagga f=C3=B6r merge-recursive: -X%s"
N msgstr "Felaktig flagga f=C3=B6r \"merge-recursive\": -X%s"

  #: builtin/merge.c:666
  #, c-format

  #: builtin/merge.c:1271
  #, c-format
  msgid "Using the %s to prepare resolving by hand.\n"
G msgstr "Anv=C3=A4nder %s f=C3=B6r att f=C3=B6rbereda l=C3=B6sning f=C3=
=B6r hand.\n"
N msgstr "Anv=C3=A4nder strategin %s f=C3=B6r att f=C3=B6rbereda l=C3=B6=
sning f=C3=B6r hand.\n"

  #: builtin/merge.c:1314
  #, c-format

  #: builtin/mv.c:209
  #, c-format
  msgid "renaming '%s' failed"
G msgstr "misslyckades byta namn p=C3=A5 \"%s\""
N msgstr "namnbytet av \"%s\" misslyckades"

  #: builtin/notes.c:122
  #, c-format

  #: builtin/notes.c:234 builtin/tag.c:445
  #, c-format
  msgid "cannot read '%s'"
G msgstr "kunde inte l=C3=A4sa \"%s\""
N msgstr "kan inte l=C3=A4sa \"%s\""

  #: builtin/notes.c:236 builtin/tag.c:448
  #, c-format

  #: builtin/notes.c:505
  msgid "list"
G msgstr "list"
N msgstr "lista"

  #: builtin/notes.c:514 builtin/notes.c:758
  #, c-format
  msgid "No note found for object %s."
  msgstr "Inga anteckningar hittades f=C3=B6r objektet %s."

   #: builtin/notes.c:562
N msgid "add"
N msgstr "l=C3=A4gga till"
N
  #: builtin/notes.c:567
  #, c-format
  msgid ""
   "Cannot add notes. Found existing notes for object %s. Use '-f' to o=
verwrite "
   "existing notes"
   msgstr ""
   "Kan inte l=C3=A4gga till anteckningar. Hittade befintliga antecknin=
gar f=C3=B6r "
   "objektet %s. Anv=C3=A4nd \"-f\" f=C3=B6r att skriva =C3=B6ver befin=
tliga anteckningar"


  #: builtin/notes.c:638
  msgid "copy"
G msgstr "copy"
N msgstr "kopiera"

  #: builtin/notes.c:643
  #, c-format

  #: builtin/notes.c:754
  msgid "show"
G msgstr "show"
N msgstr "visa"

  #: builtin/notes.c:791
  msgid "remove"
G msgstr "remove"
N msgstr "ta bort"

  #: builtin/notes.c:795
  #, c-format

  #: builtin/notes.c:825
  msgid "prune"
G msgstr "prune"
N msgstr "rensa"

  #: builtin/notes.c:877
  #, c-format

   #: builtin/push.c:132
   #, c-format
   msgid ""
   "To prevent you from losing history, non-fast-forward updates were r=
ejected\n"
  "Merge the remote changes (e.g. 'git pull') before pushing again.  Se=
e the\n"
  "'Note about fast-forwards' section of 'git push --help' for details.=
\n"
  msgstr ""
G "F=C3=B6r att f=C3=B6rhindra att du tappar historik har icke snabbspo=
lande "
N "F=C3=B6r att f=C3=B6rhindra att du tappar historik har icke-snabbspo=
lande "
  "uppdateringar\n"
G "avvisats. Sl=C3=A5 ihop fj=C3=A4rr=C3=A4ndringarna (t.ex \"git pull\=
") innan du s=C3=A4nder "
N "avvisats. Sl=C3=A5 ihop fj=C3=A4rr=C3=A4ndringarna (t.ex. \"git pull=
\") innan du s=C3=A4nder "
  "igen.\n"
  "Se avsnittet \"Note about fast-forward\" i \"git push --help\" f=C3=B6=
r "
  "detaljer.\n"


  #: builtin/reset.c:97
  msgid "Failed to find tree of HEAD."
G msgstr "Kunde inte hitta tr=C3=A4der f=C3=B6r HEAD."
N msgstr "Kunde inte hitta tr=C3=A4det f=C3=B6r HEAD."

  #: builtin/reset.c:103
  #, c-format
  msgid "Failed to find tree of %s."
G msgstr "Kunde inte hitta tr=C3=A4der f=C3=B6r %s."
N msgstr "Kunde inte hitta tr=C3=A4det f=C3=B6r %s."

  #: builtin/reset.c:108
  msgid "Could not write new index file."
   msgstr "Kunde inte skriva ny indexfil."


  #: builtin/reset.c:307
  #, c-format
  msgid "Could not parse object '%s'."
G msgstr "Kan inte tolka objektet \"%s\""
N msgstr "Kunde inte tolka objektet \"%s\""

  #: builtin/reset.c:312
  msgid "--patch is incompatible with --{hard,mixed,soft}"
   msgstr "--patch =C3=A4r inkompatibel med --{hard,mixed,soft}"


  #: builtin/revert.c:270
  #, c-format
  msgid "Error wrapping up %s"
G msgstr "Fel vid ombrytning av %s"
N msgstr "Fel vid avslutandet av %s"

  #: builtin/revert.c:290
  msgid ""
   "Your local changes would be overwritten by revert.\n"
  "Please, commit your changes or stash them to proceed."
  msgstr ""
  "Dina lokala =C3=A4ndringar skulle skrivas =C3=B6ver av \"revert\".\n=
"
G "Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"stash\" f=C3=B6r a=
tt forts=C3=A4tta."
N "Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"git stash\" f=C3=B6=
r att forts=C3=A4tta."

  #: builtin/revert.c:293
  msgid ""
   "Your local changes would be overwritten by cherry-pick.\n"
  "Please, commit your changes or stash them to proceed."
  msgstr ""
  "Dina lokala =C3=A4ndringar skulle skrivas =C3=B6ver av \"cherry-pick=
\".\n"
G "Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"stash\" f=C3=B6r a=
tt forts=C3=A4tta."
N "Checka in dina =C3=A4ndringar eller anv=C3=A4nd \"git stash\" f=C3=B6=
r att forts=C3=A4tta."

  #. TRANSLATORS: %s will be "revert" or "cherry-pick"
  #: builtin/revert.c:351
   #, c-format

  #: builtin/revert.c:449
  #, c-format
  msgid "Mainline was specified but commit %s is not a merge."
G msgstr "Huvudlinje angavs, men incheckningen %s =C3=A4r inte en samma=
nslagning"
N msgstr "Huvudsp=C3=A5r angavs, men incheckningen %s =C3=A4r inte en s=
ammanslagning"

  #. TRANSLATORS: The first %s will be "revert" or
  #. "cherry-pick", the second %s a SHA1
   #: builtin/revert.c:460
   #, c-format

  #: builtin/shortlog.c:161
  #, c-format
  msgid "Missing author: %s"
G msgstr "Saknad f=C3=B6rfattare: %s"
N msgstr "F=C3=B6rfattare saknas i: %s"

  #: builtin/tag.c:123 builtin/tag.c:464
  #, c-format
  msgid "tag name too long: %.*s..."
G msgstr "taggnamnet f=C3=B6r l=C3=A5ngt: %.*s..."
N msgstr "taggnamnet =C3=A4r f=C3=B6r l=C3=A5ngt: %.*s..."

  #: builtin/tag.c:128
  #, c-format

  #: builtin/tag.c:170
  msgid "committer info too long."
G msgstr "incheckarinformation f=C3=B6r l=C3=A5ng."
N msgstr "incheckarinformation =C3=A4r f=C3=B6r l=C3=A5ng."

  #: builtin/tag.c:190
  msgid "could not run gpg."
   msgstr "kunde inte k=C3=B6ra gpg."

  #: builtin/tag.c:196
  msgid "gpg did not accept the tag data"
G msgstr "gpg godtog inte taggdata"
N msgstr "gpg godtog inte tagginformationen"

  #: builtin/tag.c:203
  msgid "gpg failed to sign the tag"
G msgstr "gpg misslyckades signera taggen"
N msgstr "gpg misslyckades att signera taggen"

  #: builtin/tag.c:218
  msgid ""
   "\n"
   "#\n"
   "# Write a tag message\n"
   "#\n"
   msgstr ""
   "\n"
   "#\n"
   "# Skriv ett taggmeddelande\n"
   "#\n"

  #: builtin/tag.c:226
  #, c-format
  msgid "signing key value too long (%.10s...)"
G msgstr "signeringsnyckelv=C3=A4rdet f=C3=B6r l=C3=A5ngt (%.10s...)"
N msgstr "signeringsnyckelv=C3=A4rdet =C3=A4r f=C3=B6r l=C3=A5ngt (%.10=
s...)"

  #: builtin/tag.c:272
  msgid "unable to sign the tag"
   msgstr "kunde inte signera taggen"


  #: builtin/tag.c:302
  msgid "tag header too big."
G msgstr "tagghuvud f=C3=B6r stort."
N msgstr "f=C3=B6r stort tagghuvud."

  #: builtin/tag.c:329
  msgid "no tag message?"
   msgstr "inget taggmeddelande?"

  #: builtin/tag.c:335
  #, c-format
  msgid "The tag message has been left in %s\n"
G msgstr "Taggmeddelandet har l=C3=A4mnats i %s\n"
N msgstr "Taggmeddelandet har l=C3=A4mnats kvar i %s\n"

  #: builtin/tag.c:428
  msgid "-n option is only allowed with -l."
G msgstr "Flaggan -n =C3=A4r endast till=C3=A5ten tillsammans med -l."
N msgstr "flaggan -n =C3=A4r endast till=C3=A5ten tillsammans med -l."

  #: builtin/tag.c:430
  msgid "--contains option is only allowed with -l."
G msgstr "Flaggan --contains =C3=A4r endast till=C3=A5ten tillsammans m=
ed -l"
N msgstr "flaggan --contains =C3=A4r endast till=C3=A5ten tillsammans m=
ed -l"

  #: builtin/tag.c:438
  msgid "only one -F or -m option is allowed."
   msgstr "endast en av flaggorna -F eller -m till=C3=A5ts."


   #: git-am.sh:120
   msgid ""
  "Did you hand edit your patch?\n"
  "It does not apply to blobs recorded in its index."
  msgstr ""
G "Vill du handredigera din patch?\n"
G "Den kan inte appliceras p=C3=A5 blobbar som antecknats i dess index.=
"
N "Handredigerade din patch?\n"
N "Den kan inte appliceras p=C3=A5 de blobbar som beskrivs i dess index=
=2E"

  #: git-am.sh:236
  msgid "Only one StGIT patch series can be applied at once"
  msgstr "Endast en StGIT-patchserie kan appliceras =C3=A5t g=C3=A5ngen=
"


--=20
\\// Peter - http://www.softwolves.pp.se/
