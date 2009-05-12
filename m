From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] topgit tg push feature
Date: Tue, 12 May 2009 11:02:01 +0200
Message-ID: <20090512090201.GA10150@pengutronix.de>
References: <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com> <20090509103625.GC13344@lapse.rw.madduck.net> <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de> <20090511195532.GA28340@pengutronix.de> <20090511210614.GA6118@gmx.de> <20090512051334.GA22757@pengutronix.de> <20090512075413.GA7764@gmx.de> <36ca99e90905120155x1954bdf2n2cd015dd0c28af3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 12 11:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3nsN-0005gU-7r
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 11:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbZELJCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 05:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZELJCE
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 05:02:04 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56648 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbZELJCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 05:02:03 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M3nsA-0000Eo-Af; Tue, 12 May 2009 11:02:02 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M3ns9-00017I-Ku; Tue, 12 May 2009 11:02:01 +0200
Content-Disposition: inline
In-Reply-To: <36ca99e90905120155x1954bdf2n2cd015dd0c28af3c@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118883>

Hello,

> Ahh, thanks for the pointer, I haven't seen this line.
I changed the remote handling a bit and pushed it out.  IMO we could no=
w
remove the push entries added by tg and then call it 0.8 after some
testing.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
