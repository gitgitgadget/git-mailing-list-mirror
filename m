From: Christian Stimming <stimming@tuhh.de>
Subject: Re: German translations
Date: Mon, 23 Jul 2007 21:20:32 +0200
Message-ID: <200707232120.32963.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <85tzrxr0m9.fsf@lola.goethe.zz> <20070722165232.30e01005.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Edgar Toernig <froese@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:21:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID3Sn-0006IR-FZ
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 21:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765988AbXGWTUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Jul 2007 15:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765954AbXGWTUj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 15:20:39 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:51108 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761486AbXGWTUi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 15:20:38 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6NJKINn025415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 23 Jul 2007 21:20:19 +0200
Received: from [192.168.2.102] (p5490052D.dip0.t-ipconnect.de [84.144.5.45])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6NJKHF0029836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 21:20:18 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20070722165232.30e01005.froese@gmx.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53464>

Am Sonntag, 22. Juli 2007 16:52 schrieb Edgar Toernig:
> > >> > +msgid "Commit"
> > >> > +msgstr "=DCbertragen"
> > >>
> > >> Einpflegen ist als Verb gebr=E4uchlich, aber dann ist es schwer,=
 ein
> > >> passendes Substantiv zu finden.  "Sendung"?
> >
> > Ich habe was: Einspielen, Ausspielen, Einspielung, Ausspielung.
>
> Das ist genau der Grund, warum ich normalerweise keine deutschen
> Lokalisierungen benutze - total unverstaendlicher Kauderwelsch.
>
> Denkt doch bitte mal an die Zielgruppe! =20

Ja, genau das sag ich doch.

> Das sind Techniker, keine=20
> Grossmuetter.  Ihr duerft Fachvokabular benutzen!  Und gerade hier
> wird die Zielgruppe schon englische Dokumentation gelesen haben.

Nein. Die Zielgruppe der deutschen =DCbersetzung sind jene Techniker, d=
ie=20
partout mit Englisch auf Kriegsfu=DF stehen. Jaja, solche gibt es. Und =
f=FCr=20
solche muss man =FCberlegen, ob es deutsche Begriffe gibt, die man in d=
er=20
gleichen Bedeutung verwenden kann. Das geht nicht so spontan - also bit=
te=20
erstmal abwarten und selber =FCberlegen. Die englischen Begriffe sind a=
ls=20
fallback immer noch m=F6glich, aber erstmal wird =FCberlegt.

Ich bin auch f=FCr Anregungen dankbar, wie andere =DCbersetzer das denn=
 gel=F6st=20
haben. Das erw=E4hnte TortoiseSVN mit einer IMHO gelungenen deutschen D=
oku hat=20
commit=3D=FCbertragen gew=E4hlt, ist aber bei checkout=3Dauschecken geb=
lieben. Die=20
anderen SVN-Clients, bei denen man einen deutsche =DCbersetzung sehen k=
ann,=20
bieten da leider nur mindere Qualit=E4t und haben praktisch s=E4mtliche=
=20
Schl=FCsselworte auf Englisch gelassen.

> Solch zwanghaft eingedeutschten Begriffe verwirren da nur.
> Also sagt doch bitte einfach "der Commit" und "comitten" wie es
> jeder Techniker macht.  Ihr duerft auch "das Repository", "der
> Index" und mMn auch ruhig "der Branch" benutzen.

Nein. Wenn dir diese englischen Begriffe lieber sind, dann bleib gerne =
bei=20
LANG=3DC bzw. en und fertig. Hier wird erstmal diskutiert, ob sich nich=
t doch=20
deutsche Begriffe finden lassen. Es ist ja nicht so, als ob hier das=20
allererste Mal ein SCM auf deutsch erkl=E4rt werden m=FCsste.

> Verstaendlichkeit, Klarheit, Exaktheit - das ist das oberste Ziel!

- der deutschen =DCbersetzung, richtig! Wer das mit den englischen Begr=
iffen=20
erreichen will, bleibt bei LANG=3DC.

> PS: bzgl. "Sign Off": "Guthei=DFen" ist zu lasch - das entspricht
>     dem Ack'ed-by.

Ich finde da den Vorschlag "abzeichnen" bisher am besten.

Gru=DF

Christian
