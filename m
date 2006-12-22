From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git (stable)
Date: 22 Dec 2006 10:21:37 -0800
Message-ID: <86wt4jrdu6.fsf@blue.stonehenge.com>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
	<86k60jsvh8.fsf@blue.stonehenge.com>
	<86fyb7sv9f.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0612221902490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<861wmrsstc.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 19:24:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxp43-0006Ib-4G
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 19:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWLVSYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 13:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWLVSYD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 13:24:03 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:34380 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbWLVSYB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 13:24:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id E68798DB47;
	Fri, 22 Dec 2006 10:21:37 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 04535-01-17; Fri, 22 Dec 2006 10:21:37 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 7673D8DB46; Fri, 22 Dec 2006 10:21:37 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.16.9; tzolkin = 10 Muluc; haab = 2 Kankin
In-Reply-To: <861wmrsstc.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35194>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> But that's not upward compatible.  The default should be the old behavior,
Randal> or we need a better way to notify people that this breaks things.

Not to mention that the manpage still says:

       git pull, git pull origin
           Fetch the default head from the repository you cloned from and
           merge it into your current branch.

So even if I was *looking* for a change in behavior, it wasn't documented.
Nothing changed in that area in recent history.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
