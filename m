From: Christian Stimming <stimming@tuhh.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Mon, 20 May 2013 21:41:48 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <7402110.vsgz8zEiin@cs-pc>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net> <CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com> <CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ralph =?ISO-8859-1?Q?Hau=DFmann?= <ralph@scanmyfood.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 21:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeVyf-0003UU-Og
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 21:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912Ab3ETTmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 15:42:32 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:43121 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab3ETTmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 15:42:20 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id r4KJft3Y028785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 20 May 2013 21:41:55 +0200
Received: from cs-pc.localnet (g224012021.adsl.alicedsl.de [92.224.12.21])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id r4KJfsi1002997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 May 2013 21:41:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2013-21;
	t=1369078915; bh=yfN+vniUIi0uHnQ/ec/hlrUdeIk7/zL2a42H/TJJGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qPdyhGIm7nkN454ONzYqHBqr9mjSmeHFboulhSqv7bqmq2Og3Q0gR98ZD1MTX81xg
	 8lJ8C38Bo+40Pqek2rca+j2TfiQfr3rQ3eJIHy7pU8gUaI65h0Y5pCAQMMpELW2A1f
	 lR37ZS8pi5xgRNPyDyR2C3wO6moASAFhX2IVTL3I=
User-Agent: KMail/4.7.3 (Linux/3.0.0-32-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224974>

Thanks for the update. I would like to add some comments on this G+E gl=
ossary=20
and I hope you are interested in reading those, even though it is known=
 that I=20
prefer a "pure Ger" translation. However, as I wrote in my other messag=
e I=20
agree that for the command line tool the criteria for choosing the tran=
slation=20
approach are different from those for a GUI tool. So I can very well en=
vision=20
a good G+E translation for git core and subsequently all related books.

Am Sonntag, 19. Mai 2013, 18:53:18 schrieb Ralf Thielow:
> Basic repository objects:
>=20
>     blob           =3D Blob
>     tree           =3D Baum, Baum-Objekt (bevorzugt), "Tree"-Objekt
>     submodule      =3D Submodul
>     pack(noun)     =3D Pack-Datei
>     pack(verb)     =3D packen (ggf. Pack-Datei erstellen)
>     ancestor       =3D Vorfahre, Vorg=E4nger, Vorg=E4nger-Commit (bev=
orzugt)

Yes. Does the "Pack-Datei" appear anywhere in the book? I wouldn't unde=
rstand=20
the term, but then again, this is probably because I don't understand t=
he=20
semantic of this thingy as a repository object regardless of the langua=
ge...

> Content in a repository:
>=20
>     file(s)        =3D Datei(en)
>     tracked file   =3D beobachtete Datei
>     track file     =3D beobachte Datei
>     untracked file =3D unbeobachtete Datei
>     directory      =3D Verzeichnis

Yes.

> Repositories / tracking concepts:
>=20
>     clone (verb)           =3D klonen
>     clone (noun)           =3D der Klon
>     repository             =3D Repository
>     bare repository        =3D Bare Repository

Yes. After some evaluation of the git-gui translation I think using=20
"Repository" there as well is probably the better choice.

>     working directory      =3D Arbeitsverzeichnis
>     working tree           =3D -||-
>=20
>     remote branch          =3D Remote-Branch
>     remote-tracking branch =3D Remote-Tracking-Branch
>     upstream branch        =3D Upstream-Branch

Yes. What's the main reason for using "Branch" in the German text? Cons=
istency=20
with the commands, or assumed familiarity of the term within the target=
=20
audience? "Zweig" is available.

>     remote repository      =3D Remote-Repository
>     remote(noun)           =3D -||-
>     remote(adj)            =3D extern, entfernt liegend
>=20
> Authorship:
>=20
>     author    =3D Autor
>     committer =3D Commit-Ersteller
>     tagger    =3D Tag-Ersteller

Yes.

> Commits, tags and other references:
>=20
>     HEAD           =3D HEAD
> Konzept aus der Git-Welt, daher nicht zu =FCbersetzen.
>     detached HEAD  =3D losgel=F6ster HEAD
>=20
>     commit(noun)      =3D Commit
>     commit(verb)      =3D committen
>     commit the result =3D das Ergebnis committen
>     parent commit     =3D Eltern-Commit
>     child commit      =3D Kind-Commit
>     commit message    =3D Commit-Beschreibung

Yes, for the G+E approach.

>     stash(noun)       =3D der Stash
>     stash(verb)       =3D "stashen", "stash" benutzen (bevorzugt)
>     unstash(verb)     =3D "unstashen", "zur=FCckladen", "aus 'stash'
> zur=FCckladen" (bevorzugt)

Using "Stash" in G+E is quite ugly, but the noun is probably unavoidabl=
e=20
because the feature is pretty much unique to git. I'd suggest to use on=
ly the=20
noun and use the verbs as "stash benutzen" and "aus stash zur=FCckladen=
" as=20
proposed.

>     reference      =3D Referenz
>     revision       =3D Commit
>     branch         =3D Branch
>     tag(noun)      =3D Tag
>     tag(verb)      =3D taggen, Tag erstellen
>     annotated tag  =3D annotierter Tag
>     tag message    =3D Tag-Beschreibung

I've commented on "Branch" above. As for "Tag": Yes, the term is famili=
ar=20
among the target audience. However, do you really want this noun which =
is the=20
same word as "Tag wie in Datum"? Some more disambiguation between the t=
ag and=20
the date would be helpful, wouldn't it?
The derived forms are fine, and also here I'd suggest to use only the G=
+E noun=20
but construct the verbs with other German words: "Tag erstellen".

>     stage/index (noun) =3D Staging-Area, Index
>     stage/index (verb) =3D (f=FCr einen | zum) Commit vormerken
> (bevorzugt), zur Staging Area hinzuf=FCgen, dem Index hinzuf=FCgen
>     unstage (verb)     =3D aus Staging Area entfernen, aus Index entf=
ernen

I'd strongly suggest not to use "Index". I've never understood why this=
 term=20
showed up in the English wording to begin with. It took me years until =
I got=20
the point that from the user's point of view, this thingy has nothing t=
o do=20
with a book's index or a database's index, which is where I go to look =
up more=20
information about a keyword. It is a big improvement to use "staging ar=
ea" on=20
the English side. If it has to be an English word due to consistency wi=
th the=20
commands, I'd suggest "Staging-Area" or "Staging-Bereich". For the verb=
 I'd=20
agree to keep only the noun in English but construct the verb with Germ=
an=20
verbs, like already proposed here.

> Moving data around:
>=20
>     fetch =3D anfordern
>     pull  =3D zusammenf=FChren
>     push  =3D versenden
>=20
>     fast-forward     =3D vorspulen
>     non-fast-forward =3D nicht vorspulen

IMHO yes, and the German terms make me even understand what is going on=
=2E (On=20
the English side it took me ages to memorize the difference between fet=
ch and=20
pull, as the words don't offer any difference in meaning. But that's a=20
different story.) However, you probably get a hard time here when expla=
ining=20
how to keep consistency with the command names: It isn't clear for the =
user=20
why "fetch" should be the command name related to "anfordern" but "pull=
" is=20
not. This unfortunately probably means you have to introduce the words =
"pull"=20
and "fetch" somewhere in the German text.

> Commands:
>=20
>     log                =3D Log
>     interactive commit =3D interaktiver Commit
>     cherry-pick        =3D "cherry-pick" benutzen
>     rebase(verb)       =3D "rebase" benutzen
>     rebase(noun)       =3D "rebase"
>     archive            =3D archivieren
>     revert             =3D zur=FCcknehmen
>     clean(verb)        =3D s=E4ubern/aufr=E4umen
>     clean(noun)        =3D S=E4uberung
>     merge              =3D zusammenf=FChren

Yes. (I'd hope to see some German word for "cherry-pick" and "rebase"=20
("pfl=FCcken" and "neu aufbauen"), but then again, in G+E you probably =
keep that=20
words.)

>     bundle(noun)       =3D Paket
>     bundle(verb)       =3D Paket erstellen
>     unbundle(verb)     =3D Paket entpacken
>=20
>     bisect             =3D bin=E4re Suche
>     bisecting          =3D bei einer bin=E4ren Suche sein, bin=E4re S=
uche
> durchf=FChren

Yes

> Diff/patch related:
>=20
>     diff               =3D Differenz
>     delta              =3D Differenz (or Delta)
>     patch              =3D Patch
>     apply              =3D anwenden
>     diffstat           =3D (leave it as it is)
>     hunk               =3D Bereich

IMHO "Kontext" is better if you use a German word. Technically the cont=
ext is=20
something else, but in a German text IMHO it fits nicer when explaining=
 to the=20
user where he/she can select the n-th hunk.

>     whitespace         =3D Whitespace

Yes. Indeed I haven't heard a good German word that transports the same=
=20
meaning.


> Still being worked out:
>=20
>     prune              =3D veraltete(n) Branch(es) entfernen

Yes, and it makes me even understand what the command is about to do.

>     checkout(verb)     =3D auschecken
>=20
>     git add      =3D hinzuf=FCgen
>=20
>     merge conflict =3D Merge-Konflikt
>     3-way merge    =3D 3-Wege-Merge

If merge was "zusammenf=FChren" above, it should be "Zusammenf=FChrungs=
-Konflikt"=20
here, and "3-Wege-Zusammenf=FChrung".

>     paths          =3D Pfade
>=20
>     symbolic link =3D symbolische Verkn=FCfung
>     path =3D Pfad
>     link =3D Verkn=FCpfung
>=20
>     reflog =3D Referenzprotokoll
>     partial commit (verb) =3D teilweise committen, partiell committen

Teilweise committen. (No partial derivatives here...)

>     partial commit (noun) =3D Teil-Commit
>=20
>     reset =3D neu setzen (maybe "umsetzen"?)
>=20
>     register   =3D in die Konfiguration eintragen
>     unregister =3D aus der Konfiguration austragen

Best Regards,

Christian
