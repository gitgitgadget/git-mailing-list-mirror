From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Functions for managing the set of packs the library is using
Date: Sun, 31 Jul 2005 16:45:12 -0700
Message-ID: <7vvf2qbkvr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0507311600040.23721@iabervon.org>
	<Pine.LNX.4.62.0507311609420.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 01:46:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzNVZ-0006Hd-1W
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 01:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVGaXph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 19:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVGaXph
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 19:45:37 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1506 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262056AbVGaXpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 19:45:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731234514.TYMR3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 19:45:14 -0400
To: barkalow@iabervon.org
In-Reply-To: <Pine.LNX.4.62.0507311609420.23721@iabervon.org> (barkalow@iabervon.org's message of "Sun, 31 Jul 2005 16:10:22 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel, I would really have liked to merge this immediately, but
somehow the patch is whitespace damaged.  Depressingly enough,
almost all patches I got from various people today had different
whitespace damages, and I started to suspect if there is
something wrong on my end, but it does not appear to be the
case.  The copies found in the usual archive I check show the
same problems as the copies I got directly in my mailbox have.

Could you resend these two if it is not too much trouble for
you?  

Thanks for fixing the curl_easy_setopt() screwup.  I should have
been more careful.  I've already hand-merged it and will be
pushing it out shortly, so there is no need to resend that one.
