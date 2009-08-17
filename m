From: Johan Herland <johan@herland.net>
Subject: Re: Git User's Survey 2009 partial summary, part 2 - from first 10
Date: Mon, 17 Aug 2009 12:44:21 +0200
Message-ID: <200908171244.21693.johan@herland.net>
References: <200908171224.44686.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 12:44:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MczhY-0004Fo-5W
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 12:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbZHQKoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 06:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757528AbZHQKoX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 06:44:23 -0400
Received: from smtp.getmail.no ([84.208.15.66]:41516 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751754AbZHQKoW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 06:44:22 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI00EETOHYJDA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 12:44:22 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI003SMOHYJ550@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 12:44:22 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.17.103040
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <200908171224.44686.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126156>

On Monday 17 August 2009, Jakub Narebski wrote:
> 9) On which operating system(s) do you use Git?
>    (Choice - Multiple answers)
>
> On Unix-based operating system you can get the name of operation
> system by running 'uname'.

I find it interesting to compare the answers to this question against 
previous years' surveys:

=============================================================
Operating system            | 2009 [%] | 2008 [%] | 2007 [%]
-------------------------------------------------------------
Linux                       |      88% |      86% |      90%
MacOS X (Darwin)            |      44% |      47% |      15%
MS Windows/Cygwin           |       9% |      10% |      >3%?
MS Windows/msysGit (MINGW)  |      21% |      16% |      >0%?
............................|..........|..........|..........
MS Windows (any)            |      27% |     <26%?|       9%

Although several of these numbers are probably inaccurate, and
assuming that the responses on this question is representative,
we see a stabilizing trend in Git's user base, at least when
looking at Linux vs. MacOS. Windows seems to be growing steadily,
and it's good to see that the msysGit portion is outgrowing the
Cygwin portion.

Thanks to Dscho and all the others that make msysGit better
every day!


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
