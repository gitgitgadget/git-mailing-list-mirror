From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: How do I...
Date: Fri, 06 May 2005 19:39:30 +0100
Message-ID: <1115404771.16187.343.camel@hades.cambridge.redhat.com>
References: <427B3DB3.4000507@tuxrocks.com>
	 <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
	 <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 20:34:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU7dh-0007oB-M1
	for gcvg-git@gmane.org; Fri, 06 May 2005 20:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVEFSjr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 14:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEFSjr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 14:39:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35467 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261260AbVEFSjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 14:39:39 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DU7jY-0001iz-Od; Fri, 06 May 2005 19:39:33 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 10:09 -0700, Linus Torvalds wrote:
> So now you can do
> 
>         git-rev-list HEAD --max-count=10 | git-diff-tree --stdin update-cache.c
> 
> to see which of the last 10 commits changed "update-cache.c".

Now show the graph of revision history which connects those commits.

-- 
dwmw2

