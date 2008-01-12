From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Sat, 12 Jan 2008 18:08:42 +0300
Message-ID: <20080112150842.GG2963@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de> <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org> <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de> <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org> <14E7B5D5-B1B8-4532-A471-106B14B912B8@zib.de> <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org> <20080111195022.GC29189@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 16:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDhyy-0004B0-4d
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 16:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbYALPIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 10:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbYALPIo
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 10:08:44 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:57410 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbYALPIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 10:08:44 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id E611518710AF;
	Sat, 12 Jan 2008 18:08:42 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id BA3C9187107C;
	Sat, 12 Jan 2008 18:08:42 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JDhyU-00043l-F2; Sat, 12 Jan 2008 18:08:42 +0300
Content-Disposition: inline
In-Reply-To: <20080111195022.GC29189@uranus.ravnborg.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70322>

On Fri, Jan 11, 2008 at 08:50:22PM +0100, Sam Ravnborg wrote:
> On Fri, Jan 11, 2008 at 11:16:02AM -0800, Linus Torvalds wrote:
> > 
> > (Every place I've ever been at, people who had a choice would never ever 
> > develop under Windows, so I've never seen any real mixing - even when some 
> > parts of the project were DOS/Windows stuff, there was a clear boundary 
> > between the stuff that was actually done under Windows)
> 
> The reality I see is the other way around as common practice.
> For people that has never tried a Linux box the barrier
> is quite high and they prefer to stick with Windows.

And for those who have never tried Windows, it would be a great learning
barrier as well, and it is far for obvious what would be easy to learn
for someone has never had any experience with either of them before...
Of course, most people who has used computers for some time could not
escape having at least some experience with Windows, and, naturally
people prefer to stick to what they know, especially those who do not
like or find difficult to learn new stuff. Based on my observation, I
would say that those found learning Linux difficult would also find
difficult to learn other new things (like a new programming language),
and usually had more troubles in dealing with novel situations or doing
anything that required out-of-the-box thinking... Usually, they are
good only on one thing -- doing what they were told. There are some
exceptions, of course, but take a look at the number of open source
projects (where people write for fun of programming) and compare how
many of them are done by *nix users and Windows users. Isn't obvious
what most people who like programing prefer to use?

Dmitry
