From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: TopGit release?
Date: Sun, 26 Dec 2010 13:25:53 +0100
Message-ID: <20101226122553.GI14221@pengutronix.de>
References: <87ei9k42v5.fsf@write-only.cryp.to> <20101215080148.GA28971@pengutronix.de> <AANLkTi=E2H8n8jZPQ0Rz5gxaQTeLtJXeCFFZv08dip0E@mail.gmail.com> <20101215153226.GF28971@pengutronix.de> <AANLkTinfDgvmodzrW7eMW-iizxpvb+gvBgSsH9B3LOdu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Simons <simons@cryp.to>, git@vger.kernel.org,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 13:26:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWpfm-0003CZ-D8
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 13:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab0LZMZ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Dec 2010 07:25:57 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35741 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab0LZMZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 07:25:56 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1PWpfe-0007GR-V7; Sun, 26 Dec 2010 13:25:54 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PWpfd-00081v-6o; Sun, 26 Dec 2010 13:25:53 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTinfDgvmodzrW7eMW-iizxpvb+gvBgSsH9B3LOdu@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164192>

Hi Bert,

On Wed, Dec 15, 2010 at 05:48:39PM +0100, Bert Wesarg wrote:
> 2010/12/15 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > Hi Bert,
> >
> > On Wed, Dec 15, 2010 at 03:54:28PM +0100, Bert Wesarg wrote:
> >> 2010/12/15 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> >> > [1] http://thread.gmane.org/gmane.comp.version-control.git/15943=
3
> >> > =A0 =A0hint to Bert: this series doesn't apply to master
> >>
> >> I know, you applied a patch, which was rendered obsolete with this
> >> patch series. you commited on Nov 02, and I send the series Oct 20=
=2E
> > If you tell me the commit you based your series on I can use the sa=
me
> > and merge the result into master.
>=20
> 8b0f1f9d215d767488542a7853320d1789838d92
>=20
> But I just refreshed my repo.or.cz fork (topgit/bertw), where I pushe=
d
> a rebased series (I've done this some time ago already)
>=20
> git://repo.or.cz/topgit/bertw.git index-wt
I now finally merged that (skipping the two RFC commits) and pushed it
out.  I will tag it in a few days as 0.9 giving a chance to others to
test a bit.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
