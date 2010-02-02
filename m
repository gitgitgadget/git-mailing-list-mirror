From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TOPGIT PATCH] Make 'tg patch' work in subdirectories
Date: Tue, 2 Feb 2010 11:55:59 +0100
Message-ID: <20100202105559.GB32099@pengutronix.de>
References: <1265106672-18518-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue Feb 02 11:56:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcGQT-0006lx-DK
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 11:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab0BBK4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 05:56:04 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52655 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab0BBK4B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 05:56:01 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NcGQK-0007gv-3b; Tue, 02 Feb 2010 11:56:00 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NcGQJ-00074z-Om; Tue, 02 Feb 2010 11:55:59 +0100
Content-Disposition: inline
In-Reply-To: <1265106672-18518-1-git-send-email-sojkam1@fel.cvut.cz>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138710>

Hello Michal,

On Tue, Feb 02, 2010 at 11:31:12AM +0100, Michal Sojka wrote:
> When 'tg patch' is called from a subdirectory, it outputs only the
> commit message and no diff.
Thanks

Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
