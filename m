From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Thu, 16 Sep 2010 00:46:46 +0200
Message-ID: <201009160046.47367.robin.rosenberg@dewire.com>
References: <20100912202111.B11522FC00@perkele> <alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se> <A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, Git <git@vger.kernel.org>,
	Swedish <tp-sv@listor.tp-sv.se>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 00:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow0l0-0002q9-II
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 00:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab0IOWrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 18:47:08 -0400
Received: from mail.dewire.com ([83.140.172.130]:23161 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809Ab0IOWrH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 18:47:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 653511396D8F;
	Thu, 16 Sep 2010 00:47:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yW1BfCrq8pVu; Thu, 16 Sep 2010 00:47:03 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CC44C80034D;
	Thu, 16 Sep 2010 00:47:02 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156266>

onsdagen den 15 september 2010 17.31.43 skrev  Peter Kjellerstedt:
> > -----Original Message-----
> > From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] =
On
> > Behalf Of Peter Krefting
> > Sent: den 15 september 2010 12:25
> > To: Peter Kjellerstedt
> > Cc: Git; Swedish
> > Subject: RE: [PATCH 2/2] Add Swedish translation.
> >=20
> > Peter Kjellerstedt:
> > > Mainly comments on the Swedish translation below, but there are a=
 few
> > > references to the English messages as well.
> >=20
> > Thanks.
> >=20
> > Cc'ing TP-SV as I posted the translation for review there as well.
>=20
> [cut]
>=20
> > >> +#: builtin/commit.c:380
> > >> +msgid "cannot do a partial commit during a merge."
> > >> +msgstr "kan inte utf=F6ra en delvis incheckning under en
> > >> sammanslagning."
> > >=20
> > > "delvis" -> "partiell"
> >=20
> > Is that better? Sounds a bit to technical to me.
>=20
> Well, "en delvis incheckning" doesn't sound like correct Swedish...

H=E5ller med. "delvis incheckning" =E4r inte svenska.

(My comments are in swedish as it feels more natural in this context).

> [cut]
>=20
> > >> +#: builtin/commit.c:737
> > >> +msgid "Error building trees"
> > >> +msgstr "Fel vid byggande av tr=E4d"
> > >=20
> > > "byggande av tr=E4d" -> "tr=E4dbygge" ?
> >=20
> > That sounds even weirder to me.
>=20
> Hmm, you may be right. Alternatives for "byggande" is
> "konstruktion" and "skapande", don't know if either of those
> make it sound better.

Skriv om hel.
	Kunde inte bygga tr=E4det.

> [cut]
>=20
> > >> +#: builtin/describe.c:205
> > >> +#, c-format
> > >> +msgid "annotated tag %s not available"
> > >> +msgstr "den dekorerade taggen %s inte tillg=E4nglig"
> > >=20
> > > "dekorerade" -> "annoterade"
> >=20
> > Is that a word?
>=20
> Yes. At least it is in SAOL which I think should be indicative
> of its existence ;)

Dekorerade l=E5ter konstigt. "annoterade" eller "kommenterade" funkar.

> [cut]
>=20
> > >> +#: builtin/fetch.c:917
> > >> +msgid "Fetching a group and specifying refspecs does not make s=
ense"
> > >> +msgstr "Kan inte h=E4mta fr=E5n grupp och ange referensspecifik=
ationer"
> > >=20
> > > "fr=E5n" -> "en" ?
> >=20
> > Well, I was thinking "fetch" -> "h=E4mta fr=E5n", and just dropped =
the
> > "en".
>=20
> Ok.

Ni byter mening. Den engelska texten antyder att det man f=F6rs=F6ker i=
nte kan
fungera, medan =F6vers=E4ttningen betyder att operationen inte lyckades=
 den h=E4r=20
g=E5ngen.

"Det =E4r inte m=F6jligt att h=E4mta en grupp och samtidigt ange=20
referensspecifikationer"

Jag lyfte medvetet bort idiotf=F6rklaringen av anv=E4ndaren.

> [cut]
>=20
> > >> +#: builtin/grep.c:581
> > >> +#, c-format
> > >> +msgid "Failed to chdir: %s"
> > >> +msgstr "Kunde inte byta katalog (chdir): %s"
> > >=20
> > > I think you can skip the " (chdir)" explanation without
> > > loss of information.
> >=20
> > As long as the original string uses the system call reference, and =
not
> > the action, I will keep it in the translation.
>=20
> Ok (guess the English message could do with an update...)
>=20
> > >> +#: builtin/grep.c:703
> > >> +#, c-format
> > >> +msgid "unable to grep from object of type %s"
> > >> +msgstr "Kunde inte \"grep\" fr=E5n objekt av typen %s"
> > >=20
> > > "\"grep\"" -> "greppa" ?
> >=20
> > That's a word that means something else... I don't really have any =
good
> > idea on how to translate "grep" when used as a verb...
>=20
> Yeah, I know... I've no better suggestion I'm afraid.

Varf=F6r =E4ndra tempus?  s/Kunde/Kan/. Som tidigare s=E5 handlar det i=
nte
om att greppandet misslyckades denna g=E5ng. Det /kan/ inte fungera n=E5=
n
g=E5ng (i denna version av Git). Dessutom =E4r det inte viktigt om grep=
 eller
n=E5n annan mekanism anv=E4nds.

"Kan inte utf=F6ra texts=F6kning i \"%s\"-objekt"

> [cut]
>=20
> > >> +#: builtin/log.c:825
> > >> +#, c-format
> > >> +msgid "insane in-reply-to: %s"
> > >> +msgstr "tokigt in-reply-to: %s"
> > >=20
> > > "tokigt" -> "tokig"
> >=20
> > My sense of language says that it should be "neutrum", so "tokigt".
>=20
> Well, I read it with an implicit "header" (i.e., as "insane
> in-reply-to header: %s")...

"tokigt v=E4rde f=F6r \"in-reply-to\""

> [cut]
>=20
> > >> +#: builtin/merge.c:651
> > >> +#, c-format
> > >> +msgid "Unknown option for merge-recursive: -X%s"
> > >> +msgstr "Felaktig flagga f=F6r merge-recursive: -X%s"
> > >=20
> > > "merge-recursive" -> "rekursiv ihopslagning" ?
> >=20
> > No, merge-recursive is a name of a merge strategy.
>=20
> Maybe add quotes around it then do indicate that?

Citera n=E4r ordet inte skall =F6ver=E4ttas.

"Felaktig flagga f=F6r \"merge-recursive\": -X%s"

> > >> +#: builtin/merge.c:1271
> > >> +#, c-format
> > >> +msgid "Using the %s to prepare resolving by hand.\n"
> > >> +msgstr "Anv=E4nder %s f=F6r att f=F6rbereda l=F6sning f=F6r han=
d.\n"
> > >=20
> > > "%s" -> "strategin %s" ?
> >=20
> > Yeah. The English string should probably also be fixed, though.
>
> Agree.
+1
=20
> > >> +#: builtin/mv.c:206
> > >> +#, c-format
> > >> +msgid "Renaming %s to %s\n"
> > >> +msgstr "Byter namn p=E5 %s till %s\n"
> > >=20
> > > "Byter namn p=E5" -> "D=F6per om" ?
> >=20
> > I've used "byta namn" in other places, so if I change here, I shoul=
d
> > change it globally.
>=20
> Either should work I guess...

Trenden =E4r nog att alltmer anv=E4nda religi=F6sa termer enbart f=F6r =
religion. Titta
i andra program s=E5 ser ni att "Byt namn..." oftast =E4r det som anv=E4=
nds i menyer=20
o.dyl. D=E4remot anv=E4nder man ofta "d=F6pa om" i talspr=E5k.

> [cut]
>=20
> > >> +#: builtin/push.c:77
> > >> +#, c-format
> > >> +msgid "The current branch %s is tracking multiple branches, ref=
using
> > >> to push." +msgstr "Den aktuella grenen %s sp=E5rar flera grenar,=
 v=E4grar
> > >> s=E4nda."
> > >=20
> > > "s=E4nda" -> "trycka iv=E4g" ?
> >=20
> > "Trycka iv=E4g" sounds horrible, IMHO. I used "S=E4nd" in the git-g=
ui
> > translation of "Push". As long as git doesn't grow a "git send"
> > command, I think that should be OK.

=D6vers=E4ttningarna i Git-gui =E4r prejudicerande f=F6r denna =F6vers=E4=
ttning. Sen=20
kanske de inte =E4r 100%-aga heller, men i s=E5 fall b=F6r b=E5de C Git=
 och Git Gui
=E4ndras.  Sen finns kanske ytterligare =F6vers=E4ttningar av andra Git=
-verktyg.
Personligen f=F6redrar jag nog Skicka.  Absolut inte trycka.

> Ok.
>=20
> > >> +#: builtin/push.c:132
> > >> +#, c-format
> > >> +msgid ""
> > >> +"To prevent you from losing history, non-fast-forward updates w=
ere
> > rejected\n"
> > >> +"Merge the remote changes (e.g. 'git pull') before pushing agai=
n.
> > See the\n"
> > >> +"'Note about fast-forwards' section of 'git push --help' for
> > details.\n"
> > >> +msgstr ""
> > >> +"F=F6r att f=F6rhindra att du tappar historik har icke snabbspo=
lande
> > uppdateringar\n"
> > >> +"avvisats. Sl=E5 ihop fj=E4rr=E4ndringarna (t.ex \"git pull\") =
innan du
> > s=E4nder igen.\n"
> >=20
> > >> +"Se avsnittet \"Note about fast-forward\" i \"git push --help\"=
 f=F6r
> >=20
> > detaljer.\n"
> >=20
> > > "icke snabbspolande" -> "icke-snabbspolande"
> >=20
> > Changed.
> >=20
> > > "t.ex" -> "t ex"
> >=20
> > I think it looks clearer with the full stop.
>=20
> Then it should be "t. ex." according to SAOL.

Har inte senast upplagan, men jag tror inte det. Det skall vara "t ex" =
eller=20
"t.ex." enligt
Myndigheternas Skrivregler. Svenska Akademien anv=E4nder "t.ex." p=E5 w=
ebben i=20
alla fall (utan blank).

> [cut=20
>=20
> > >> +#: builtin/reset.c:321
> > >> +msgid "--mixed with paths is deprecated; use 'git reset -- <pat=
hs>'
> >=20
> > instead."
> >=20
> > >> +msgstr "--mixed rekommenderas inte med s=F6kv=E4gar; anv=E4nd \=
"git reset
> >=20
> > -- <s=F6kv=E4gar>\"."
> >=20
> > > "." -> " ist=E4llet."
> >=20
> > I dropped it to fit an 80 character line.
>=20
> Ok.
>=20
> > >> +#: builtin/revert.c:270
> > >> +#, c-format
> > >> +msgid "Error wrapping up %s"
> > >> +msgstr "Fel vid ombrytning av %s"
> > >=20
> > > I do not think this "wrapping up" refers to reformatting of the c=
ommit
> > > message. I think it refers to finishing writing the message (a
> > > rephrasing of the English message is advisable). Thus the Swedish
> > > translation should probably be:
> > >=20
> > > "Fel vid avslutandet av %s"
> >=20
> > Are you sure about that? I was unable to figure it out when I looke=
d at
> > it.
>
> I am pretty sure. That error message is output in case a file
> called "somefile.lock" cannot be closed and renamed to "somefile"
> (see lockfile.c:commit_lock_file().)

=46elmeddelandet =E4r inte vettigt p=E5 engelska heller.  Kanske detta?
"Kunde inte avsluta skrivning av filen %s"=20
=20
> [cut]
>=20
> > >> +#: builtin/shortlog.c:161
> > >> +#, c-format
> > >> +msgid "Missing author: %s"
> > >> +msgstr "Saknad f=F6rfattare: %s"
> > >=20
> > > "Saknad" -> "Saknar"
> >=20
> > I think "missing" it is an adjective and not a verb here. The messa=
ge
> > is clear either way.
>=20
> Ok.

Usch.
"F=F6rfattare saknas i: %s"

Det funkar inte s=E5 bra att forkorta lika h=E5rt som i engelska", d=E4=
rav det lilla=20
"i"-et.

> [cut]
>=20
> > >> +#: builtin/tag.c:196
> > >> +msgid "gpg did not accept the tag data"
> > >> +msgstr "gpg godtog inte taggdata"
> > >=20
> > > "taggdata" -> "taggdatan"
> >=20
> > "taggdatana" in that case. "data" is always plural.

Innovativt :) Data =E4r plural och singularform saknas (om
man inte g=E5r tillbaka till latinets datum, men det =E4r ingen
som anv=E4nder p=E5 svenska i den betydelsen).

> Maybe better to use "tagginformationen"?

Tag =3D etikett

"gpg accepterade inte etikettinformationen"

>=20
> [cut]
>=20
> > >> +#: git-am.sh:120
> > >> +msgid ""
> > >> +"Did you hand edit your patch?\n"
> > >> +"It does not apply to blobs recorded in its index."
> > >> +msgstr ""
> > >> +"Vill du handredigera din patch?\n"
> > >> +"Den kan inte appliceras p=E5 blobbar som antecknats i dess ind=
ex."
> > >=20
> > > "Vill du handredigera" -> "Handredigerade du"
> >=20
> > Fixed.
> >=20
> > > "antecknats" -> "finns"
> >=20
> > That's ambiguous. Changed second sentence to:
> > "Den kan inte appliceras p=E5 de blobbar som beskrivs i dess index.=
"
>=20
> Good.

-- robin
