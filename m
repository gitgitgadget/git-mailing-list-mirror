From: Edgar Toernig <froese@gmx.de>
Subject: Re: German translations
Date: Sun, 22 Jul 2007 16:52:32 +0200
Message-ID: <20070722165232.30e01005.froese@gmx.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<200707211437.43524.stimming@tuhh.de>
	<85ps2l98eq.fsf@lola.goethe.zz>
	<200707212127.51840.stimming@tuhh.de>
	<85tzrxr0m9.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 16:52:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICcnZ-0005Vo-TD
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 16:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbXGVOwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 10:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbXGVOwi
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 10:52:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:59618 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752020AbXGVOwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 10:52:37 -0400
Received: (qmail invoked by alias); 22 Jul 2007 14:52:36 -0000
Received: from p50900A3B.dip0.t-ipconnect.de (EHLO dialup) [80.144.10.59]
  by mail.gmx.net (mp027) with SMTP; 22 Jul 2007 16:52:36 +0200
X-Authenticated: #271361
X-Provags-ID: V01U2FsdGVkX1+fxgJbo/ef6umYLxm3rDw0mJ6s6ZtbMxldZ4wAm9
	d55z/tM6+pxllG
In-Reply-To: <85tzrxr0m9.fsf@lola.goethe.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53272>

> >> > +#: git-gui.sh:1627 git-gui.sh:1802 git-gui.sh:2134
> >> > +msgid "Commit"
> >> > +msgstr "=DCbertragen"
> >>
> >> Einpflegen ist als Verb gebr=E4uchlich, aber dann ist es schwer, e=
in
> >> passendes Substantiv zu finden.  "Sendung"?
> [...]
> Ich habe was: Einspielen, Ausspielen, Einspielung, Ausspielung.
> Symmetrisch, verst=E4ndlich, als Verb und Substantiv zu gebrauchen.
>
> [usw]

Das ist genau der Grund, warum ich normalerweise keine deutschen
Lokalisierungen benutze - total unverstaendlicher Kauderwelsch.

Denkt doch bitte mal an die Zielgruppe!  Das sind Techniker, keine
Grossmuetter.  Ihr duerft Fachvokabular benutzen!  Und gerade hier
wird die Zielgruppe schon englische Dokumentation gelesen haben.
Solch zwanghaft eingedeutschten Begriffe verwirren da nur.
Also sagt doch bitte einfach "der Commit" und "comitten" wie es
jeder Techniker macht.  Ihr duerft auch "das Repository", "der
Index" und mMn auch ruhig "der Branch" benutzen.

Verstaendlichkeit, Klarheit, Exaktheit - das ist das oberste Ziel!
Wir sind doch keine Franzosen ;-)

Ciao, ET.


PS: bzgl. "Sign Off": "Guthei=DFen" ist zu lasch - das entspricht
    dem Ack'ed-by.
