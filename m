From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Thu, 18 Aug 2005 19:26:46 +0200
Message-ID: <20050818172646.GA18459@mars.ravnborg.org>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com> <7vek8t7bva.fsf@assigned-by-dhcp.cox.net> <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508170830050.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 19:27:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5o8R-0001FP-IO
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 19:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVHRRYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 13:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVHRRYj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 13:24:39 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:39942 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932312AbVHRRYj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 13:24:39 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 6C984262883;
	Thu, 18 Aug 2005 19:24:35 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id F3CD56AC01D; Thu, 18 Aug 2005 19:26:46 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508170830050.3553@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> (Also, with proper "Signed-off-by:" lines it's also always clear that 
> there were other people involved, and that the author of the patch is 
> different from the person who applied it).

I almost always handedit my mails and I find myself forgetting to add
"Signed-off-by" from time to time.
Is there a simple way to implment a trigger that can check that _I_
signed off the patch before applying it?

I prefer to add it myself rather than to have it added automatically -
but mayve thats you me being a bit mistrusting.

Btw. I'm a Cogito user if that makes a difference.
The only git- command I use today is git-applymbox.

	Sam
