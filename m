From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Allow default core.logallrefupdates to be overridden with template's config
Date: Tue, 23 Jan 2007 18:58:11 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070123175811.GA8070@cepheus>
References: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com> <Pine.LNX.4.64.0701230827440.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 23 18:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9PuZ-0005iH-WA
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 18:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbXAWR6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 12:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965363AbXAWR6S
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 12:58:18 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:65078 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965302AbXAWR6R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 12:58:17 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9PuS-0000yU-7d; Tue, 23 Jan 2007 18:58:16 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0NHwDvO023247;
	Tue, 23 Jan 2007 18:58:13 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0NHwC8i023246;
	Tue, 23 Jan 2007 18:58:12 +0100 (MET)
To: Linus Torvalds <torvalds@linux-foundation.org>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701230827440.32200@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37554>

Hi Linus,

Linus Torvalds wrote:
>  just out of curiosity, what _is_ your curious text-attachment thing:
>=20
>    1 Shown      8 lines  Text (charset: UTF-8)
>    2   OK    ~928 bytes  Text (charset: ANSI_X3.4-1968)
ANSI_X3.4-1968 is just the offical name for us-ascii.

	zeisberg@cepheus:~$ LANG=3DC locale charmap
	ANSI_X3.4-1968

I'm not sure that this was making you curious.

Another strange thing is, that Alex' MUA choosed
"Content-Transfer-Encoding: 7bit" for the first part although UTF-8 is
an 8bit charset.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dthe+speed+of+light+in+m%2Fs
