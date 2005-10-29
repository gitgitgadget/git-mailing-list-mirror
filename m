From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] git-push.sh: Retain cuteness, add helpfulness.
Date: Sat, 29 Oct 2005 01:03:26 -0400
Message-ID: <20051029050326.GA14060@pe.Belkin>
References: <E1EVi9d-0002U0-0k@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 29 07:06:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVisi-0001fQ-PL
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 07:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVJ2FD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 01:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVJ2FD3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 01:03:29 -0400
Received: from eastrmmtao06.cox.net ([68.230.240.33]:61884 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751202AbVJ2FD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 01:03:27 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029050238.PLOT21663.eastrmmtao06.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 01:02:38 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVisI-0003f5-RK
	for git@vger.kernel.org; Sat, 29 Oct 2005 01:03:26 -0400
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E1EVi9d-0002U0-0k@localhost>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10794>

I'm sorry that the patch-set I just sent didn't contain an ordering.
The order is:

0002-Minor-clarifications-in-diffcore-documentation.txt
0003-Remove-r-from-common-diff-options-documentation-in-one-more-place.txt
0004-update-usage-string-for-git-commit.sh.txt
0005-Add-usage-statement-for-git-reset.sh.txt
0006-Add-usage-statement-to-git-push.sh.txt
0007-Actually-git-reset-arguments-are-mutually-exclusive.txt
0008-git-push.sh-Factor-out-usage-statement-to-function-explain-why-rsync-can-t-push.txt
0009-git-push.sh-Retain-cuteness-add-helpfulness.txt

I tried and failed to get git-send-email to work, so I tried to roll
my own and it didn't work that well.  I'll try harder.

-chris
