From: Junio C Hamano <junkio@cox.net>
Subject: Re: new file leaked onto release branch
Date: Wed, 14 Dec 2005 14:16:13 -0800
Message-ID: <7vwti7wcia.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056B86DD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 23:19:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emev6-0005Wg-Qr
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 23:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVLNWQP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 17:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVLNWQP
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 17:16:15 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7856 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965016AbVLNWQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 17:16:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214221538.TOIU3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 17:15:38 -0500
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30056B86DD@hdsmsx401.amr.corp.intel.com>
	(Len Brown's message of "Wed, 14 Dec 2005 17:06:54 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13650>

"Brown, Len" <len.brown@intel.com> writes:

> I'm not stuck by this problem, since I created a new release
> branch based before the funny merge and it seems to be
> working properly.  I'm sorry I can't re-create the problem
> again.  Next time something like this happens and I notice it
> I'll be sure to keep the ingredients for the failure on hand.

Thanks.

BTW, are 5165, 3410, 5452, 5571... topic branch names?
