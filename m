From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH 2/2] Add Swedish translation.
Date: Thu, 16 Sep 2010 09:49:11 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749BFA3D1A3@xmail3.se.axis.com>
References: <20100912202111.B11522FC00@perkele>
 <alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se>
 <A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>
 <201009160046.47367.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, Git <git@vger.kernel.org>,
	Swedish <tp-sv@listor.tp-sv.se>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 09:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow9Df-0001HA-9r
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 09:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab0IPHtR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 03:49:17 -0400
Received: from anubis.se.axis.com ([195.60.68.12]:35162 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab0IPHtQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 03:49:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 2B5C319D94;
	Thu, 16 Sep 2010 09:49:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2QjXOUNTAeVI; Thu, 16 Sep 2010 09:49:13 +0200 (CEST)
Received: from miranda.se.axis.com (miranda.se.axis.com [10.0.2.171])
	by anubis.se.axis.com (Postfix) with ESMTPS id C381619D0B;
	Thu, 16 Sep 2010 09:49:13 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o8G7nD27012722;
	Thu, 16 Sep 2010 09:49:13 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 16 Sep 2010 09:49:13 +0200
Thread-Topic: [PATCH 2/2] Add Swedish translation.
Thread-Index: ActVKBOQMXXgywm9SWqWHPb/nkIShAARyUBw
In-Reply-To: <201009160046.47367.robin.rosenberg@dewire.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156289>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Robin Rosenberg
> Sent: den 16 september 2010 00:47
> To: Peter Kjellerstedt
> Cc: Peter Krefting; Git; Swedish
> Subject: Re: [PATCH 2/2] Add Swedish translation.
>=20
> onsdagen den 15 september 2010 17.31.43 skrev  Peter Kjellerstedt:
> > > -----Original Message-----
> > > From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org=
]
> > > On Behalf Of Peter Krefting
> > > Sent: den 15 september 2010 12:25
> > > To: Peter Kjellerstedt
> > > Cc: Git; Swedish
> > > Subject: RE: [PATCH 2/2] Add Swedish translation.
> > >
> > > Peter Kjellerstedt:
> > > > Mainly comments on the Swedish translation below, but there are=
 a
> > > > few references to the English messages as well.
> > >
> > > Thanks.
> > >
> > > Cc'ing TP-SV as I posted the translation for review there as well=
=2E
> >
> > [cut]
> >
> > > >> +#: builtin/commit.c:380
> > > >> +msgid "cannot do a partial commit during a merge."
> > > >> +msgstr "kan inte utf=F6ra en delvis incheckning under en
> > > >> sammanslagning."
> > > >
> > > > "delvis" -> "partiell"
> > >
> > > Is that better? Sounds a bit to technical to me.
> >
> > Well, "en delvis incheckning" doesn't sound like correct Swedish...
>=20
> H=E5ller med. "delvis incheckning" =E4r inte svenska.
>=20
> (My comments are in swedish as it feels more natural in this context)=
=2E
>=20
> > [cut]
> >
> > > >> +#: builtin/commit.c:737
> > > >> +msgid "Error building trees"
> > > >> +msgstr "Fel vid byggande av tr=E4d"
> > > >
> > > > "byggande av tr=E4d" -> "tr=E4dbygge" ?
> > >
> > > That sounds even weirder to me.
> >
> > Hmm, you may be right. Alternatives for "byggande" is
> > "konstruktion" and "skapande", don't know if either of those
> > make it sound better.
>=20
> Skriv om hel.
> 	Kunde inte bygga tr=E4det.

tr=E4det -> tr=E4den

However, to me "bygga" sounds like compile rather than create,
which is why I would prefer "konstruera" eller "skapa".

> > [cut]
> >
> > > >> +#: builtin/describe.c:205
> > > >> +#, c-format
> > > >> +msgid "annotated tag %s not available"
> > > >> +msgstr "den dekorerade taggen %s inte tillg=E4nglig"
> > > >
> > > > "dekorerade" -> "annoterade"
> > >
> > > Is that a word?
> >
> > Yes. At least it is in SAOL which I think should be indicative
> > of its existence ;)
>=20
> Dekorerade l=E5ter konstigt. "annoterade" eller "kommenterade" funkar=
=2E
>=20
> > [cut]
> >
> > > >> +#: builtin/fetch.c:917
> > > >> +msgid "Fetching a group and specifying refspecs does not make=
 sense"
> > > >> +msgstr "Kan inte h=E4mta fr=E5n grupp och ange referensspecif=
ikationer"
> > > >
> > > > "fr=E5n" -> "en" ?
> > >
> > > Well, I was thinking "fetch" -> "h=E4mta fr=E5n", and just droppe=
d the
> > > "en".
> >
> > Ok.
>=20
> Ni byter mening. Den engelska texten antyder att det man f=F6rs=F6ker=
 inte
> kan fungera, medan =F6vers=E4ttningen betyder att operationen inte ly=
ckades=20
> den h=E4r g=E5ngen.
>=20
> "Det =E4r inte m=F6jligt att h=E4mta en grupp och samtidigt ange refe=
rensspecifikationer"

Could replace "Det =E4r inte m=F6jligt att" with "Kan inte" for a=20
shorter version.

> Jag lyfte medvetet bort idiotf=F6rklaringen av anv=E4ndaren.
>=20
> > [cut]
> >
> > > >> +#: builtin/grep.c:581
> > > >> +#, c-format
> > > >> +msgid "Failed to chdir: %s"
> > > >> +msgstr "Kunde inte byta katalog (chdir): %s"
> > > >
> > > > I think you can skip the " (chdir)" explanation without
> > > > loss of information.
> > >
> > > As long as the original string uses the system call reference, an=
d not
> > > the action, I will keep it in the translation.
> >
> > Ok (guess the English message could do with an update...)
> >
> > > >> +#: builtin/grep.c:703
> > > >> +#, c-format
> > > >> +msgid "unable to grep from object of type %s"
> > > >> +msgstr "Kunde inte \"grep\" fr=E5n objekt av typen %s"
> > > >
> > > > "\"grep\"" -> "greppa" ?
> > >
> > > That's a word that means something else... I don't really have an=
y good
> > > idea on how to translate "grep" when used as a verb...
> >
> > Yeah, I know... I've no better suggestion I'm afraid.
>=20
> Varf=F6r =E4ndra tempus?  s/Kunde/Kan/. Som tidigare s=E5 handlar det=
 inte
> om att greppandet misslyckades denna g=E5ng. Det /kan/ inte fungera n=
=E5n
> g=E5ng (i denna version av Git). Dessutom =E4r det inte viktigt om gr=
ep
> eller n=E5n annan mekanism anv=E4nds.
>=20
> "Kan inte utf=F6ra texts=F6kning i \"%s\"-objekt"

Sounds good to me. s/Kan/kan/ to maintain case.

[cut]

> > > >> +#: builtin/mv.c:206
> > > >> +#, c-format
> > > >> +msgid "Renaming %s to %s\n"
> > > >> +msgstr "Byter namn p=E5 %s till %s\n"
> > > >
> > > > "Byter namn p=E5" -> "D=F6per om" ?
> > >
> > > I've used "byta namn" in other places, so if I change here, I sho=
uld
> > > change it globally.
> >
> > Either should work I guess...
>=20
> Trenden =E4r nog att alltmer anv=E4nda religi=F6sa termer enbart f=F6=
r
> religion. Titta i andra program s=E5 ser ni att "Byt namn..."=20
> oftast =E4r det som anv=E4nds i menyer o.dyl. D=E4remot anv=E4nder ma=
n=20
> ofta "d=F6pa om" i talspr=E5k.

Thanks for the explanation. That sounds like a good reason to=20
stick to "Byter namn".

> > [cut]
> >
> > > >> +#: builtin/push.c:77
> > > >> +#, c-format
> > > >> +msgid "The current branch %s is tracking multiple branches, r=
efusing
> > > >> to push." +msgstr "Den aktuella grenen %s sp=E5rar flera grena=
r, v=E4grar
> > > >> s=E4nda."
> > > >
> > > > "s=E4nda" -> "trycka iv=E4g" ?
> > >
> > > "Trycka iv=E4g" sounds horrible, IMHO. I used "S=E4nd" in the git=
-gui
> > > translation of "Push". As long as git doesn't grow a "git send"
> > > command, I think that should be OK.
>=20
> =D6vers=E4ttningarna i Git-gui =E4r prejudicerande f=F6r denna =F6ver=
s=E4ttning.
> Sen kanske de inte =E4r 100%-aga heller, men i s=E5 fall b=F6r b=E5de=
 C Git=20
> och Git Gui =E4ndras.  Sen finns kanske ytterligare =F6vers=E4ttninga=
r av=20
> andra Git-verktyg. Personligen f=F6redrar jag nog Skicka.  Absolut in=
te=20
> trycka.

Ok.

> > Ok.
> >
> > > >> +#: builtin/push.c:132
> > > >> +#, c-format
> > > >> +msgid ""
> > > >> +"To prevent you from losing history, non-fast-forward updates=
 were rejected\n"
> > > >> +"Merge the remote changes (e.g. 'git pull') before pushing ag=
ain. See the\n"
> > > >> +"'Note about fast-forwards' section of 'git push --help' for =
details.\n"
> > > >> +msgstr ""
> > > >> +"F=F6r att f=F6rhindra att du tappar historik har icke snabbs=
polande uppdateringar\n"
> > > >> +"avvisats. Sl=E5 ihop fj=E4rr=E4ndringarna (t.ex \"git pull\"=
) innan du s=E4nder igen.\n"
> > > >> +"Se avsnittet \"Note about fast-forward\" i \"git push --help=
\" f=F6r detaljer.\n"
> > >
> > > > "icke snabbspolande" -> "icke-snabbspolande"
> > >
> > > Changed.
> > >
> > > > "t.ex" -> "t ex"
> > >
> > > I think it looks clearer with the full stop.
> >
> > Then it should be "t. ex." according to SAOL.
>=20
> Har inte senast upplagan, men jag tror inte det. Det skall vara "t ex=
"
> eller "t.ex." enligt Myndigheternas Skrivregler. Svenska Akademien=20
> anv=E4nder "t.ex." p=E5 webben i alla fall (utan blank).

I stand corrected.

> > [cut
> >
> > > >> +#: builtin/reset.c:321
> > > >> +msgid "--mixed with paths is deprecated; use 'git reset --
> <paths>'
> > >
> > > instead."
> > >
> > > >> +msgstr "--mixed rekommenderas inte med s=F6kv=E4gar; anv=E4nd=
 \"git
> reset
> > >
> > > -- <s=F6kv=E4gar>\"."
> > >
> > > > "." -> " ist=E4llet."
> > >
> > > I dropped it to fit an 80 character line.
> >
> > Ok.
> >
> > > >> +#: builtin/revert.c:270
> > > >> +#, c-format
> > > >> +msgid "Error wrapping up %s"
> > > >> +msgstr "Fel vid ombrytning av %s"
> > > >
> > > > I do not think this "wrapping up" refers to reformatting of the=
 commit
> > > > message. I think it refers to finishing writing the message (a
> > > > rephrasing of the English message is advisable). Thus the Swedi=
sh
> > > > translation should probably be:
> > > >
> > > > "Fel vid avslutandet av %s"
> > >
> > > Are you sure about that? I was unable to figure it out when I loo=
ked at
> > > it.
> >
> > I am pretty sure. That error message is output in case a file
> > called "somefile.lock" cannot be closed and renamed to "somefile"
> > (see lockfile.c:commit_lock_file().)
>=20
> Felmeddelandet =E4r inte vettigt p=E5 engelska heller.  Kanske detta?
> "Kunde inte avsluta skrivning av filen %s"

Sounds ok to me.

> > [cut]
> >
> > > >> +#: builtin/shortlog.c:161
> > > >> +#, c-format
> > > >> +msgid "Missing author: %s"
> > > >> +msgstr "Saknad f=F6rfattare: %s"
> > > >
> > > > "Saknad" -> "Saknar"
> > >
> > > I think "missing" it is an adjective and not a verb here. The mes=
sage
> > > is clear either way.
> >
> > Ok.
>=20
> Usch.
> "F=F6rfattare saknas i: %s"
>=20
> Det funkar inte s=E5 bra att forkorta lika h=E5rt som i engelska", d=E4=
rav
> det lilla "i"-et.

%s here is a SHA-1, so "f=F6r" may be better than "i"?

> > [cut]
> >
> > > >> +#: builtin/tag.c:196
> > > >> +msgid "gpg did not accept the tag data"
> > > >> +msgstr "gpg godtog inte taggdata"
> > > >
> > > > "taggdata" -> "taggdatan"
> > >
> > > "taggdatana" in that case. "data" is always plural.
>=20
> Innovativt :) Data =E4r plural och singularform saknas (om
> man inte g=E5r tillbaka till latinets datum, men det =E4r ingen
> som anv=E4nder p=E5 svenska i den betydelsen).
>=20
> > Maybe better to use "tagginformationen"?
>=20
> Tag =3D etikett

Heh, probably some more places where tagg needs to be replaced=20
then... ;)

> "gpg accepterade inte etikettinformationen"

[cut]

> -- robin

//Peter
