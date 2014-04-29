From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 10:34:56 +0200 (CEST)
Message-ID: <1473502218.1282188.1398760496823.JavaMail.zimbra@dewire.com>
References: <535C47BF.2070805@game-point.net> <535e18cdc7bce_338911e930c72@nysa.notmuch> <87bnvl6bdg.fsf@fencepost.gnu.org> <535e8e4253196_45651483310b3@nysa.notmuch> <152626b3-0642-4e26-9333-7d911d45c669@email.android.com> <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch> <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com> <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Denholm <nod.helm@gmail.com>, David Kastrup <dak@gnu.org>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 10:35:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf3VS-0007W1-2c
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 10:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbaD2IfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Apr 2014 04:35:07 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:56462 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739AbaD2IfC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2014 04:35:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id B58B481548;
	Tue, 29 Apr 2014 10:35:00 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0lMLuZUb8brj; Tue, 29 Apr 2014 10:34:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 3275781563;
	Tue, 29 Apr 2014 10:34:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7elXnJW8OW_f; Tue, 29 Apr 2014 10:34:57 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 169BE81548;
	Tue, 29 Apr 2014 10:34:57 +0200 (CEST)
In-Reply-To: <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
X-Originating-IP: [80.252.171.62]
X-Mailer: Zimbra 8.0.7_GA_6020 (ZimbraWebClient - FF28 (Mac)/8.0.7_GA_6020)
Thread-Topic: Recording the current branch on each commit?
Thread-Index: UVPix0MHeMSI/GiSwvYMrtkKT0Vrcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247530>



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "Felipe Contreras" <felipe.contreras@gmail.com>
> Till: "James Denholm" <nod.helm@gmail.com>, "Felipe Contreras" <felip=
e.contreras@gmail.com>
> Kopia: "David Kastrup" <dak@gnu.org>, "Jeremy Morton" <admin@game-poi=
nt.net>, "Johan Herland" <johan@herland.net>,
> "Git mailing list" <git@vger.kernel.org>
> Skickat: tisdag, 29 apr 2014 5:32:29
> =C3=84mne: Re: Recording the current branch on each commit?
>=20
> James Denholm wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > > James Denholm wrote:
> > >> It's not anybody else's job to take your patches and drizzle the=
m in the
> > >> honey of respectable discourse.
> > >
> > > It's nobody's job to do anything. This a collaborative effort and=
 in a
> > > collaborative effort everbody chimes in to do different things.
[...]

> In the Git project though, we choose to starve to death. Neither were=
 my
> patches picked, nor did anybody else step up with a different proposa=
l, we
> just
> did nothing, which is what we always do.

Just because you are starving, the others may not be. I'll skip dinner =
today.

Not all people view the world the same way you do. Sometimes they don't=
 "see it"=20
because they don't share your experience. A year later other people may=
 have come to the
same conclusion as you (or not) and whatever the idea you had may come
from someone else, when the world is ready.=20

Whining won't help, it will just reduce your credibility, perhaps to th=
e point
that people won't even read a improved proposal if you come up with one=
=2E

Remember this is a high volume list, so you don't get much time to expl=
ain an idea. It's
a matter of karma.

-- robin
