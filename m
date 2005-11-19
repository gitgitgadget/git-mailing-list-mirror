From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Teach "approxidate" about weekday syntax
Date: 18 Nov 2005 16:28:32 -0800
Message-ID: <864q69bhvz.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
	<7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
	<Pine.LNX.4.64.0511171520390.13959@g5.osdl.org>
	<20051118121210.GA19714@abridgegame.org>
	<Pine.LNX.4.63.0511181419340.28109@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0511180806550.25159@shark.he.net>
	<Pine.LNX.4.64.0511180857170.13959@g5.osdl.org>
	<7vzmo1ecbf.fsf@assigned-by-dhcp.cox.net> <437E6CAB.8060200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:31:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdGaw-0007YX-G1
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 01:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVKSA2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 19:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVKSA2i
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 19:28:38 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:29591 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750794AbVKSA2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 19:28:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id EBE288F3C4;
	Fri, 18 Nov 2005 16:28:32 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28245-03-2; Fri, 18 Nov 2005 16:28:32 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 5991D8F3C7; Fri, 18 Nov 2005 16:28:32 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
x-mayan-date: Long count = 12.19.12.14.10; tzolkin = 1 Oc; haab = 8 Ceh
In-Reply-To: <437E6CAB.8060200@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12307>

>>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:

>>> [torvalds@g5 git]$ ./test-date "2005-11-02 14:45:00"
>> Doesn't ISO spell that as "2005-11-02T14:45:00"?
>> 

Andreas> nox!exon:~$ date --iso-8601=seconds
Andreas> 2005-11-19T01:04:56+0100

Andreas> No human will spell it with T though.

But they might be getting it out of another tool like that.

And, let me apologize for derailing Linus for a week.  Sorry.  :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
