From: Dave Jones <davej@redhat.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 15:04:09 -0400
Message-ID: <20060505190409.GC9937@redhat.com>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505163629.GZ27689@pasky.or.cz> <Pine.LNX.4.64.0605050944200.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, linux@horizon.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 05 21:04:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc5bW-0000k7-DI
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWEETEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWEETEY
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:04:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751532AbWEETEX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 15:04:23 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k45J4AZm000690;
	Fri, 5 May 2006 15:04:10 -0400
Received: from nwo.kernelslacker.org (vpn83-123.boston.redhat.com [172.16.83.123])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k45J4Awp018564;
	Fri, 5 May 2006 15:04:10 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.6/8.13.5) with ESMTP id k45J4AEv014043;
	Fri, 5 May 2006 15:04:10 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.6/8.13.6/Submit) id k45J49bw014042;
	Fri, 5 May 2006 15:04:09 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605050944200.3622@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19629>

On Fri, May 05, 2006 at 10:48:38AM -0700, Linus Torvalds wrote:

 > (and yes, I'm somewhat biased: in my opinion, having a 
 > million monkeys throwing crap at the walls and encoding the information in 
 > the patterns on monkey shit is a better format than CVS), so it would 
 > actually have improved BK, while also making it possible to interoperate 
 > if you didn't want to use BK itself.
 >  ...
 > So that was really my "fallback" position: if nothing out there worked, 
 > I'd rather go back to lists of patches than use CVS. 

I've encountered managing kernel trees in CVS both during my tenure at SuSE,
and to a more involved extent as Fedora/RHEL maintainer, and I'd just like
to echo how much it _completely sucks_ at times.

Rebasing to a newer release is a *nightmare* that usually takes
up most of an afternoon compared to rebasing my git based projects.

In the event I can't persuade the powers at be to switch to git at some point
for managing our packages, I'll be sure to bring up your suggestion of
a million monkeys. I believe you can pick them up fairly cheap these days.

		Dave

-- 
http://www.codemonkey.org.uk
