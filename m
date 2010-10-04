From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 2/6] tg-remote: use default remote if non is
	given
Date: Mon, 4 Oct 2010 08:43:04 +0200
Message-ID: <20101004064304.GG28679@pengutronix.de>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com> <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com> <AANLkTin_erzxiOgthOq5_9dtFXeRT+K5K4uGTGa1OOZP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Peter Simons <simons@cryp.to>,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	martin f krafft <madduck@debian.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:43:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2elc-0003ug-Au
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab0JDGnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:43:11 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58497 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab0JDGnK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 02:43:10 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2elQ-00050l-Gb; Mon, 04 Oct 2010 08:43:08 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2elM-0003Gt-JT; Mon, 04 Oct 2010 08:43:04 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTin_erzxiOgthOq5_9dtFXeRT+K5K4uGTGa1OOZP@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157983>

On Mon, Oct 04, 2010 at 03:13:24AM +0000, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> On Sun, Oct 3, 2010 at 21:25, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
>=20
> Minor: I think you mean "none" in the subject, not "non".
Right, I fixed that up when committing, together with s/usefull/useful/

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
