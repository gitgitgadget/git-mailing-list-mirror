From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: TopGit successor
Date: Mon, 8 Jun 2009 09:44:37 +0200
Message-ID: <20090608074437.GA12109@pengutronix.de>
References: <1244148073-2313-1-git-send-email-bert.wesarg@googlemail.com> <20090605202526.GB671@pengutronix.de> <36ca99e90906080031r3f5f545eo26c077e1966bf67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 09:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDZXB-0007no-2U
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 09:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbZFHHoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 03:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbZFHHog
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 03:44:36 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35696 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZFHHog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 03:44:36 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MDZX3-0003Ne-T0; Mon, 08 Jun 2009 09:44:37 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MDZX3-00039i-6s; Mon, 08 Jun 2009 09:44:37 +0200
Content-Disposition: inline
In-Reply-To: <36ca99e90906080031r3f5f545eo26c077e1966bf67@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121046>

Hello Bert,

On Mon, Jun 08, 2009 at 09:31:01AM +0200, Bert Wesarg wrote:
> BTW: Do you have any infos or need help on your TopGit successor?
I want to get running at least the patch command, then I'm willing to
share it.  The key difference to topgit is that it doesn't use branches
to track dependencies only commits.  I hope this will make some things
easier and cleaner.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
