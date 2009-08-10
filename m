From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: .gitignore vs untracked working file
Date: Mon, 10 Aug 2009 12:01:48 +0200
Message-ID: <20090810100148.GB22200@pengutronix.de>
References: <286817520908100257n35b178ebu387161658554b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rostislav Svoboda <rostislav.svoboda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 12:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaRhd-000523-VK
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 12:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbZHJKBt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 06:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbZHJKBs
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 06:01:48 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36382 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbZHJKBs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 06:01:48 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MaRhM-0003Bt-Tg; Mon, 10 Aug 2009 12:01:48 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MaRhM-0007dW-S9; Mon, 10 Aug 2009 12:01:48 +0200
Content-Disposition: inline
In-Reply-To: <286817520908100257n35b178ebu387161658554b4a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125429>

Hello,

> $ git checkout master
> error: Untracked working tree file 'Project/bin/path/file.jjt' would
> be overwritten by merge.
What is the output of

	$ git ls-files master bin/

?

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
