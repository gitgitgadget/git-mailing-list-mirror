From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Last mile to 1.0?
Date: Sat, 23 Jul 2005 08:56:00 -0400
Organization: None, usuallly detectable by casual observers
Message-ID: <200507230856.00212.gene.heskett@verizon.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
 <20050723081549.GC3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 14:56:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwJY9-0000Il-5M
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 14:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVGWM4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 08:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGWM4L
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 08:56:11 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:11676 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261643AbVGWM4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 08:56:10 -0400
Received: from coyote.coyote.den ([151.205.63.153])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IK2006AYZXCR5Q2@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 23 Jul 2005 07:56:01 -0500 (CDT)
In-reply-to: <20050723081549.GC3255@mythryan2.michonline.com>
To: Ryan Anderson <ryan@michonline.com>
Content-disposition: inline
User-Agent: KMail/1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Saturday 23 July 2005 04:15, Ryan Anderson wrote:
>On Sat, Jul 16, 2005 at 10:46:00AM -0700, Junio C Hamano wrote:
>> I do not know what release plan Linus has in mind, and also
>> expect things to be quieter next week during OLS and kernel
>> summit, but I think we are getting really really close.
>
>Looking at the set of patches we just all dumped on Linus, I think
> they pretty much show us that we don't have any major issues.
>
>As I see it, the status is currently like this:
>
>Revision control - Stable
>Pulling locally or over rsync - Stable
>Pushing over ssh - Stable
>
>Remote, anonymous pulls not using rsync - Beta
>Usability features[1] - Beta
>
>Documentation - Alpha

One old farts comment re the docs here folks.

This will need to be improved considerably if you want all us lurking 
frogs to be able to use it without drowning this list with what 
really should be RTFMable questions.  Specifically, we should be able 
to dl one package and install something that, by reading the 
manpages, can be made to work OOTB given an adequate network 
connection.

My lurking & reading the mail here tends to give me the impression 
that while it can be made to work, there are yet rough edges for the 
new user.  Potentially discouraging rough edges...

>My feeling is that we're pretty well set to do a 1.0 release.
>
>1 - Usability features are all the things around git-apply,
>git-format-patch, etc, that we're clearly working on to make life
> more pleasant, but aren't really critical.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
