From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Distinguish branches by more than case in tests.
Date: Fri, 06 Apr 2007 16:02:59 -0700
Message-ID: <86mz1lt8bg.fsf@blue.stonehenge.com>
References: <20070406054204.GA13108@Hermes.local>
	<7v7ispjhtx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704061502000.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZxSd-0002iT-Jt
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbXDFXDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 19:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933347AbXDFXDH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 19:03:07 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:4023 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933320AbXDFXDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 19:03:00 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9CB3E1DE3B7; Fri,  6 Apr 2007 16:02:59 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.14; tzolkin = 11 Ix; haab = 2 Pop
In-Reply-To: <Pine.LNX.4.64.0704061502000.6730@woody.linux-foundation.org> (Linus Torvalds's message of "Fri, 6 Apr 2007 15:06:33 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43939>

>>>>> "Linus" == Linus Torvalds <torvalds@linux-foundation.org> writes:

Linus> People who do it tend to universally do it because they haven't thought
Linus> it through, and are supporting some older behaviour. And in the process
Linus> they make their filesystem less reliable *and* slower.

Just playing the devil's advocate (I prefer the clean filesystem of Unix), the
argument the case-folding fans make is "well, taxes and TAXES is the same
word, right?".

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
