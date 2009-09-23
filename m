From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [ANNOUNCE] TopGit 0.8
Date: Wed, 23 Sep 2009 11:32:58 +0200
Message-ID: <20090923093258.GA16838@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Ringle <jon@ringle.org>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	Marc Weber <marco-oweber@gmx.de>,
	"Bernhard R. Link" <brlink@debian.org>,
	"martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 11:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqODi-0003t7-7T
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 11:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbZIWJc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2009 05:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbZIWJc5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 05:32:57 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54921 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602AbZIWJc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 05:32:56 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MqODb-0002fa-IR; Wed, 23 Sep 2009 11:32:59 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MqODa-0005kt-SD; Wed, 23 Sep 2009 11:32:58 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128976>

Hello,

I'm happy to announce that TopGit 0.8 was released today.

TopGit aims to make handling of large amount of interdependent topic
branches easier. In fact, it is designed especially for the case when
you maintain a queue of third-party patches on top of another (perhaps
Git-controlled) project and want to easily organize, maintain and submi=
t
them - TopGit achieves that by keeping a separate topic branch for each
patch and providing few tools to maintain the branches

It has been a bit silent around TopGit for some time.  Still a few
patches accumulated since the last relase.  To get them out I have made
this release.

The highlight is a new command tg-push that makes pushing topgit
branches more comfortable.  Thanks to Marc Weber and Bert Wesarg.

Other than that there are quite a few bugfixes.

If ever you have problems with or suggestions for or need for discussio=
n
about TopGit, join us in #topgit in the freenode irc network.

As usual the release is available at

	http://repo.or.cz/w/topgit.git

I will talk to martin to get this release into Debian/unstable soon.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
