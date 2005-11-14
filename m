From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Simple questions on GIT usage.
Date: 14 Nov 2005 08:37:29 -0800
Message-ID: <86iruvxk1i.fsf@blue.stonehenge.com>
References: <cda58cb80511140746w2f691fb8y@mail.gmail.com>
	<4378B687.3060701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 14 17:39:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhKo-0004Nh-Dn
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVKNQhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVKNQhb
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:37:31 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:32403 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751173AbVKNQha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:37:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 4F3F98F7AE;
	Mon, 14 Nov 2005 08:37:30 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17526-01-89; Mon, 14 Nov 2005 08:37:29 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E36618F7AF; Mon, 14 Nov 2005 08:37:29 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)Git Mailing List <git@vger.kernel.org>
								     ^-missing end of address
x-mayan-date: Long count = 12.19.12.14.6; tzolkin = 10 Cimi; haab = 4 Ceh
In-Reply-To: <4378B687.3060701@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11810>

>>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:

Andreas> man git-branch

Andreas> It will tell you about its -d and -D options.

It will?  My manpage has no -d or -D option for git-branch.

And I've been looking for something like that too.  If I want to
abandon a what-if branch, how do I make sure that the branch and all
objects are deleted?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
