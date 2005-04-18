From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add + Status patches
Date: Mon, 18 Apr 2005 14:00:44 -0700
Message-ID: <7v64yju7er.fsf@assigned-by-dhcp.cox.net>
References: <42641AE4.9050700@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:58:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNdIi-0006RK-40
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDRVAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 17:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVDRVAx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 17:00:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58801 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261179AbVDRVAq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 17:00:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418210043.XKFM1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 17:00:43 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <42641AE4.9050700@dgreaves.com> (David Greaves's message of
 "Mon, 18 Apr 2005 21:39:00 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

DG> Hi Petr
DG> Thankyou for the help earlier - problem resolved.

DG> I have a trivial patch (attached).

DG> It allows:
DG>  find src -type f | git add -

I am slow today, but have you considered using xargs?


