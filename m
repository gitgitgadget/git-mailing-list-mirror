From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: topgit patches
Date: Thu, 26 Feb 2009 00:15:50 +0100
Message-ID: <20090225231550.GA19741@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de> <20090225212309.GM12275@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "martin f. krafft" <madduck@debian.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Feb 26 00:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcT0F-0004QE-5H
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 00:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759790AbZBYXPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 18:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbZBYXPy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 18:15:54 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39288 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618AbZBYXPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 18:15:53 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcSyl-00056n-Em; Thu, 26 Feb 2009 00:15:51 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcSyk-00058b-Ib; Thu, 26 Feb 2009 00:15:50 +0100
Content-Disposition: inline
In-Reply-To: <20090225212309.GM12275@machine.or.cz>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111510>

Hi Petr,

On Wed, Feb 25, 2009 at 10:23:09PM +0100, Petr Baudis wrote:
> On Wed, Feb 25, 2009 at 08:58:56PM +0100, Uwe Kleine-K=F6nig wrote:
> > The following changes since commit 8c77c342166ddc6ecb3840628d89ddc5=
bb6b043b:
> >   Kirill Smelkov (1):
> >         tg-completion: complete options for `tg remote`
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.pengutronix.de/git/ukl/topgit.git pu
> >=20
> > Uwe Kleine-K=F6nig (5):
> >       [TOPGIT] limit rev-list in branch_contains to a single rev
> >       [TOPGIT] allow working with annihilated branches
> >       [TOPGIT] make tg remote idempotent
> >       [TOPGIT] make creating a commit from a topgit branch a functi=
on
> >       [TOPGIT] implement linearize export method
> >=20
>   I'm unfortunately not actively using topgit right now and I have no
> time to maintain it or review patches. :-( Martin seems to be in simi=
lar
> situation. So, would you like push access to the main repository? ;-)
Well, I already wondered if there is someone using topgit apart from me=
=2E
:-)

If you give me push access I'd only push the first three patches to
master and maybe create a pu branch for the linearize method.

Given this situation it probably doesn't make sense to describe some
problems I currently see using topgit :-|.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
Peiner Strasse 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-=
0    |
Amtsgericht Hildesheim, HRA 2686              | Fax:   +49-5121-206917-=
5555 |
