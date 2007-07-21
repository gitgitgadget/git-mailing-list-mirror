From: David Kastrup <dak@gnu.org>
Subject: Re: German translations
Date: Sat, 21 Jul 2007 21:57:18 +0200
Message-ID: <85tzrxr0m9.fsf@lola.goethe.zz>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<200707211437.43524.stimming@tuhh.de> <85ps2l98eq.fsf@lola.goethe.zz>
	<200707212127.51840.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 21:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICL53-0005q3-BI
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 21:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760218AbXGUT53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jul 2007 15:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759886AbXGUT53
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 15:57:29 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:36797 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759329AbXGUT52 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 15:57:28 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id E705515B6E6;
	Sat, 21 Jul 2007 21:57:24 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id D5EA92DA964;
	Sat, 21 Jul 2007 21:57:24 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id A6FF52BAEF9;
	Sat, 21 Jul 2007 21:57:24 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 63B8B1D1E17B; Sat, 21 Jul 2007 21:57:19 +0200 (CEST)
In-Reply-To: <200707212127.51840.stimming@tuhh.de> (Christian Stimming's message of "Sat\, 21 Jul 2007 21\:27\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3716/Sat Jul 21 19:42:25 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53184>

Christian Stimming <stimming@tuhh.de> writes:

> Am Samstag, 21. Juli 2007 15:46 schrieb David Kastrup:
>> Christian Stimming <stimming@tuhh.de> writes:
>> > And a new German translation, so far 100% but many more strings ar=
e to
>> > come.
>>
>> I have somewhat different proposals which sound less awkward, I
>> think.  Of course, it is always a matter of taste whether a technica=
l
>> term should really be translated always, but assuming that, I'll mak=
e
>> some German proposals.  Some may be tongue in cheek.
>
> Thanks for additional word proposals. I'll discuss these and the two
> followups in German below.
>
>> > +#: git-gui.sh:1627 git-gui.sh:1802 git-gui.sh:2134
>> > +msgid "Commit"
>> > +msgstr "=DCbertragen"
>>
>> Einpflegen ist als Verb gebr=E4uchlich, aber dann ist es schwer, ein
>> passendes Substantiv zu finden.  "Sendung"?
>
> Richtig - eine Kombination Substantiv/Verb wird ben=F6tigt. Ich habe =
im=20
> Glossar "=FCbertragen (senden?, =FCbergeben?)". Ersteres wird bei Tor=
toiseSVN=20
> benutzt. Im Prinzip gehen die anderen auch; bei "Sendung"/"senden" be=
f=FCrchte=20
> ich aber zu viele Mehrdeutigkeiten, wenn man z.B. davon redet. den co=
mmit=20
> =FCber TCP wohin senden will. Die Sendung wohin senden? Andererseits =
hat man=20
> bei =DCbertragung das gleiche Problem.

Ich habe was: Einspielen, Ausspielen, Einspielung, Ausspielung.
Symmetrisch, verst=E4ndlich, als Verb und Substantiv zu gebrauchen.

>> > +#: git-gui.sh:1631
>> > +msgid "Fetch"
>> > +msgstr "Holen"
>>
>> Importieren (haupts=E4chlich, weil es zu Exportieren pa=DFt und Schi=
eben
>> h=E4=DFlich ist)
>
> Importieren ist bereits f=FCr "git-{cvs,svn}import" reserviert, kann
> also hier nicht verwendet werden.

Ok.

> Deswegen wird was anderes ben=F6tigt. F=FCr fetch und pull gleicherma=
=DFen
> w=FCrden holen/ziehen/=FCbernehmen gehen und man muss sich halt auf e=
ine
> Zuordnung festlegen.

fetch =3D anfordern, pull =3D =FCbernehmen?

>> > +#: git-gui.sh:1632 git-gui.sh:2140
>> > +msgid "Push"
>> > +msgstr "Schieben"
>>
>> Exportieren
>
> Dito - bereits reserviert f=FCr git-cvsexport u.=E4., also hier nicht
> benutzbar.  Deswegen momentan dieses, ich bin aber auch nicht
> gl=FCcklich damit. Siehe Glossar: "schieben (hochladen? verschicken?)=
"

Ausliefern?  Durchgeben?

>> > +#: git-gui.sh:1641
>> > +msgid "Browse Current Branch"
>> > +msgstr "Aktuellen Zweig durchbl=E4ttern"
>>
>> Im aktuellen Zweig st=F6bern.
>
> st=F6bern f=FCr "to browse"? Das ist aber definitiv nicht das, was
> normalerweise als =DCbersetzung von "to browse" gew=E4hlt wird. Da is=
t
> man eben bei bl=E4ttern.

Aber das w=E4re "leafing through" und ist eben auf B=FCcher beschr=E4nk=
t.

> Au=DFerdem ist "st=F6bern" hart an der Grenze zur Flapsigkeit, die ma=
n
> (im Gegensatz zum engl. Original) bei deutscher Software unbedingt
> vermeiden muss.

=46inde ich nicht, aber bei Interfaces ist nat=FCrlich die
Mehrheitsmeinung ausschlaggebend.  "w=FChlen" w=E4re flapsig.  Etwas
hochsprachlicher w=E4re noch "durchforsten", aber das tr=E4gt uns
nat=FCrlich den Zorn der F=F6rster f=FCr den Begriffsmi=DFbrauch zu.
"erkunden" w=E4re auch noch m=F6glich.

>> > +#: git-gui.sh:2057
>> > +msgid "Staged Changes (Will Be Committed)"
>> > +msgstr "Bereitgestellte =C4nderungen (werden =FCbertragen)"
>>
>> Einzupflegende =C4nderungen
>
> Nein, hier muss irgendwie die "staging area" mit auftauchen, denn so
> lautet die Beschriftung der linken Listbox. Da ich die mit
> "Bereitstellung" gew=E4hlt habe, muss das Wort hier wieder auftauchen=
=2E

Sehe ich zwar nicht so.

>> > David Kastrup wrote:
>> >>> +#: git-gui.sh:1798 git-gui.sh:2130 git-gui.sh:2228
>> >>> +msgid "Sign Off"
>> >>> +msgstr "Freizeichnen"
>> >>
>> >> Gegenzeichnen?
>> >
>> > Abzeichnen!
>>
>> Absegnen. =A0Ich denke mal, in der Form mit "Ab" ist das derma=DFen
>> gebr=E4uchlich, da=DF man damit keine religi=F6sen Befindlichkeiten
>> verletzt.
>>
>> Ansonsten: Abnicken oder Guthei=DFen.
>
> Absegnen ist zu flapsig, Abnicken und Guthei=DFen erst recht.

Abnicken ja, aber Guthei=DFen ist nun wirklich ein hochsprachlicher
Begriff.

>  Abzeichnen w=E4re okay, aber das ist Freizeichnen auch.

=46reizeichnen ist viel zu nischensprachlich.  Mit Abzeichnen k=F6nnte =
ich
leben, obwohl ich Guthei=DFen besser f=E4nde.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
