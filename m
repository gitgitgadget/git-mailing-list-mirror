From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 11:05:33 +0100
Message-ID: <1113559533.12012.296.camel@baythorne.infradead.org>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	 <20050414121624.GZ25711@pasky.ji.cz>
	 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	 <1113556448.12012.269.camel@baythorne.infradead.org>
	 <20050415093649.GA28077@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 12:02:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMNeV-0007nM-Ls
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 12:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVDOKFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 06:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVDOKFn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 06:05:43 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:50320 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261792AbVDOKFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 06:05:39 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMNhe-0002Bn-9e; Fri, 15 Apr 2005 11:05:34 +0100
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050415093649.GA28077@elte.hu>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-15 at 11:36 +0200, Ingo Molnar wrote:
> do such cases occur frequently? In the kernel at least it's not too 
> typical. 

Isn't it? I thought it was a fairly accurate representation of the
process "I make a whole bunch of changes to files I maintain, pulling
from Linus while occasionally asking him to pull from my tree. Sometimes
my files are changed by someone else in Linus' tree, and sometimes I
change files that I don't actually own.".

-- 
dwmw2


