From: Jeff Garzik <jeff@garzik.org>
Subject: Re: why does git perpetually complain about include/asm-blackfin/macros.h?
Date: Mon, 02 Jul 2007 08:29:15 -0400
Message-ID: <4688EF9B.8020405@garzik.org>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 14:29:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5L1u-0007hw-1m
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 14:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbXGBM3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 08:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbXGBM3T
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 08:29:19 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:51009 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbXGBM3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 08:29:18 -0400
Received: from cpe-065-190-165-210.nc.res.rr.com ([65.190.165.210] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I5L1o-00023I-SO; Mon, 02 Jul 2007 12:29:17 +0000
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
In-Reply-To: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.9 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51360>

Robert P. J. Day wrote:
>   for the umpteenth time, after doing a pull, i see this:
> 
> $ git diff
> diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
> deleted file mode 100644
> index e69de29..0000000
> $

I have the same problem.  git 1.5.0.6 on Fedora Core 5 or 6.

I even tried a completely fresh clone, but the problem still appears.

	Jeff
