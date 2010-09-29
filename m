From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Pull request for msysGit patches
Date: Wed, 29 Sep 2010 21:48:20 +0100
Message-ID: <4CA3A614.1010203@ramsay1.demon.co.uk>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 19:35:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1N2g-0002ng-E2
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 19:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797Ab0I3RfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 13:35:12 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:55973 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756785Ab0I3RfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 13:35:09 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Sep 2010 13:35:09 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1P1MiO-000502-d6; Thu, 30 Sep 2010 17:15:00 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <87ocbitd33.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157696>

Pat Thoyts wrote:
> Junio,
> 
> The msysGit tree currently tracks some 50+ patches on top of 'next'. I
> have gathered 42 of these that look good to move upstream. 
> Please pull from
>   git://repo.or.cz/git/mingw/4msysgit.git work/pt/for-junio
> also visible for inspection at
>   http://repo.or.cz/w/git/mingw/4msysgit.git/shortlog/refs/heads/work/pt/for-junio
> 
> Output of git-request-pull....

I am carrying a patch by Peter Harris (Modify MSVC wrapper script) in my
repo, which I would hope could be included soon. I have never used 4msysgit.git
(I thought it was no longer used, except for building installers!), but I
just had a quick look via the web interface - the commit I'm referring to is
commit 358f1be616da601b2169463521d409a8aa86466a (Modify MSVC wrapper script,
2010-07-05).

[Note the "Fix MSVC build" companion commit was not needed on git.git]

ATB,
Ramsay Jones
