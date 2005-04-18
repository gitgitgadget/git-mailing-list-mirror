From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 10:51:59 +1000
Message-ID: <1113785521.11910.45.camel@localhost.localdomain>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	 <1113780698.11910.8.camel@localhost.localdomain>
	 <20050417233936.GV1461@pasky.ji.cz>
	 <1113782805.11910.36.camel@localhost.localdomain>
	 <20050418003526.GD1461@pasky.ji.cz>
	 <1113785123.11910.43.camel@localhost.localdomain>
	 <20050418005032.GE1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:48:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKRE-0002ce-Js
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVDRAwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVDRAwX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:52:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52169 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261364AbVDRAwV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 20:52:21 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNKUr-0003Vu-80; Mon, 18 Apr 2005 01:52:19 +0100
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418005032.GE1461@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 02:50 +0200, Petr Baudis wrote:
> I think I will make git-pasky's default behaviour (when we get
> http-pull, that is) to keep the complete commit history but only trees
> you need/want; togglable to both sides.

I think the default behaviour should probably be to fetch everything.

-- 
dwmw2

