From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: (topgit question) deleting a dependency
Date: Tue, 28 Apr 2009 22:40:18 +0200
Message-ID: <20090428204018.GA17722@pengutronix.de>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net> <20090428094138.GB9415@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, martin f krafft <madduck@madduck.net>,
	505303@bugs.debian.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:40:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyu6l-0005gR-14
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbZD1UkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbZD1UkW
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 16:40:22 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59713 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbZD1UkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 16:40:21 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lyu6G-0000Lq-Ic; Tue, 28 Apr 2009 22:40:20 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lyu6E-0000jx-JA; Tue, 28 Apr 2009 22:40:18 +0200
Content-Disposition: inline
In-Reply-To: <20090428094138.GB9415@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117809>

Hello Sitaram,

On Tue, Apr 28, 2009 at 11:41:38AM +0200, martin f krafft wrote:
> also sprach Sitaram Chamarty <sitaramc@gmail.com> [2009.04.28.1049 +0=
200]:
> [...]
> > I know "tg depend" only has the "add" subcommand right now,
> > but is there a manual way of getting the effect of a
> > hypothetical "tg depend remove"?
>=20
> No, not yet, see http://bugs.debian.org/505303 for further
> discussion on the issue.
But note that you might get some problems after doing that.  See

	http://thread.gmane.org/gmane.comp.version-control.git/116193/focus=3D=
116205

for some more details.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
