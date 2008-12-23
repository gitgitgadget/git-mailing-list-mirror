From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: a few Topgit patches
Date: Tue, 23 Dec 2008 15:30:35 +0100
Message-ID: <20081223143035.GA24087@cassiopeia.tralala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@debian.org>, Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 15:33:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF8Ik-0005HE-I3
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 15:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYLWOan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2008 09:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbYLWOan
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 09:30:43 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55230 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbYLWOam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 09:30:42 -0500
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=cassiopeia.tralala)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <u.kleine-koenig@pengutronix.de>)
	id 1LF8HM-0006Iz-Tg; Tue, 23 Dec 2008 15:30:41 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 92.198.50.58
X-SA-Exim-Mail-From: u.kleine-koenig@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.5 tests=AWL,BAYES_00,RCVD_IN_PBL
	shortcircuit=no autolearn=no version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103821>

Hello,

I hacked using topgit for some time now, and found the following change=
s
to topgit useful:

Uwe Kleine-K=F6nig (3):
      tg export: implement skipping empty patches for collapse driver
      tg export: Implement flattening patch paths for quilt mode
      tg export (quilt): Implement numbering the patches

 README       |    1 -
 tg-export.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++------=
--
 2 files changed, 44 insertions(+), 9 deletions(-)

You can fetch or pull these from

	git://git.pengutronix.de/git/ukl/topgit.git master

or browse them using the following URL:

	http://git.pengutronix.de/?p=3Dukl/topgit.git

=46or review I send the patches as a reply to this mail.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
      |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/ |
