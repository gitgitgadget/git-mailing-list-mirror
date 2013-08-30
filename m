From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
Subject: Re: [GIT PULL] hotfix on fr.po for the maint branch
Date: Fri, 30 Aug 2013 19:23:54 +0200
Message-ID: <21533323.C8UgJI1nMs@cayenne>
References: <CANYiYbG6MweCwLaUw5Uk3S9a0hUY1vuS+ORCF1BipkZkJeHjrw@mail.gmail.com> <xmqq61un15lo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Sebastien Helleu <flashcode@flashtux.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 19:24:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFSRD-0004Pw-10
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 19:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584Ab3H3RYn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 13:24:43 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:44255 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab3H3RYm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 13:24:42 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 8753377CD9F
	for <git@vger.kernel.org>; Fri, 30 Aug 2013 19:24:38 +0200 (CEST)
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 163F04B0064;
	Fri, 30 Aug 2013 19:23:55 +0200 (CEST)
User-Agent: KMail/4.10.5 (Linux/3.11.0-rc4jna; KDE/4.10.5; x86_64; ; )
In-Reply-To: <xmqq61un15lo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233446>

Le vendredi 30 ao=FBt 2013 09:54:59 Junio C Hamano a =E9crit :
> Jiang Xin <worldhello.net@gmail.com> writes:
> > Please merge this commit to the maint branch.
> >=20
> > The following changes since commit=20
e230c568c4b9a991e3175e5f65171a566fd8e39c:
> >   Git 1.8.4 (2013-08-23 11:49:46 -0700)
> >=20
> > are available in the git repository at:
> >   git://github.com/git-l10n/git-po master
> >=20
> > for you to fetch changes up to 21860882c8782771e99aa68fab6e365c628f=
f39d:
> >   l10n: fr.po: hotfix for commit 6b388fc (2013-08-30 16:59:29 +0800=
)
> >=20
> > ----------------------------------------------------------------
> >=20
> > Sebastien Helleu (1):
> >       l10n: fr.po: hotfix for commit 6b388fc
>=20
> Hmph, what happened that requires a "hotfix" to message strings?

Well, as the author of the first commit,, I must say that the quality w=
as not=20
good. But it became visible and hooked up a reviewer only when it was p=
romoted=20
to stable version...

There are some strings that do not make sense in the usage pages, a mis=
sing %s=20
in one.  	Agreed that applying this patch does not solve a critical iss=
ue, but=20
it is low risk.

>=20
> >  po/TEAMS |    1 +
> >  po/fr.po | 1591
> >  ++++++++++++++++++++++++++++++++++---------------------------- 2 f=
iles
> >  changed, 874 insertions(+), 718 deletions(-)
> >=20
> > --
> > Jiang Xin
