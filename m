From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: as promised, docs: git for the confused
Date: 12 Dec 2005 12:39:39 -0800
Message-ID: <86y82qyrqs.fsf@blue.stonehenge.com>
References: <20051209215414.14072.qmail@science.horizon.com>
	<7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
	<20051212195319.11d41269.tihirvon@gmail.com>
	<Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, junkio@cox.net,
	linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 21:44:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EluSi-00008y-Ch
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 21:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVLLUjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 15:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVLLUjq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 15:39:46 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:11335 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751142AbVLLUjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 15:39:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 3B5C88F6B1;
	Mon, 12 Dec 2005 12:39:40 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 24221-01-6; Mon, 12 Dec 2005 12:39:39 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 989308F6B5; Mon, 12 Dec 2005 12:39:39 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.12.15.14; tzolkin = 12 Ix; haab = 12 Mac
In-Reply-To: <Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13538>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> So instead of teaching people about "git-read-tree --reset HEAD" etc that 
Linus> you'd never know on your own, just teach about "git reset". And not 
Linus> bothering with the "git-write-tree + git-commit-tree + git-update-ref" 
Linus> approach, just make people use "git commit" from the very beginning.

I learned more by reading the cg-tutorial, at least from the user
perspective.  I then went back to the git-tutorial, and was able to
finally understand that these commands are worth ignoring. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
