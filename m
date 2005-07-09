From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: What broke snapshots now?
Date: Sun, 10 Jul 2005 00:38:11 +0100
Message-ID: <1120952292.23706.49.camel@baythorne.infradead.org>
References: <1120907336.8058.293.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507090908490.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 01:38:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrOtm-0007NA-0S
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 01:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVGIXiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 19:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGIXiO
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 19:38:14 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:53139 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261777AbVGIXiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 19:38:13 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DrOtg-0000mE-G7; Sun, 10 Jul 2005 00:38:12 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507090908490.17536@g5.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-07-09 at 09:15 -0700, Linus Torvalds wrote:
> Yes, looks that way. Except it's not "git on master.kernel.org", it's "git 
> in your home directory", I suspect. I expressly held off packing the 
> kernel repo until git had been updated on kernel.org.

Doh. I thought I'd already done that, but in fact that was for the
scripts which feed the mailing list, while the snapshot script kept
using my copy. I've moved it out of the way now; sorry for the noise.

-- 
dwmw2
