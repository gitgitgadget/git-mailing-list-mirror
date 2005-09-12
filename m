From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Apply N -> A status change in diff-helper
Date: Sun, 11 Sep 2005 18:28:01 -0700
Message-ID: <7vd5nfoz1a.fsf@assigned-by-dhcp.cox.net>
References: <20050912010343.GA32376@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 03:29:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEd79-0001C2-2l
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 03:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVILB2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 21:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVILB2E
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 21:28:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:7879 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751121AbVILB2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 21:28:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912012801.ZHAS24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 21:28:01 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20050912010343.GA32376@gondor.apana.org.au> (Herbert Xu's
	message of "Mon, 12 Sep 2005 11:03:43 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8359>

Herbert Xu <herbert@gondor.apana.org.au> writes:

> When the git diff status 'N' was changed to 'A', diff-helper.c was
> not updated accordingly.

*BLUSH*  Thanks.
