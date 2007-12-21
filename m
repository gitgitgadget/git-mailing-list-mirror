From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: Linux 2.6.24-rc6
Date: Thu, 20 Dec 2007 23:50:05 -0500
Message-ID: <20071221045005.GF8535@fattire.cabal.ca>
References: <alpine.LFD.0.9999.0712201731010.21557@woody.linux-foundation.org> <20071221024805.GB8535@fattire.cabal.ca> <20071221030152.GC8535@fattire.cabal.ca> <alpine.LFD.0.9999.0712201937470.21557@woody.linux-foundation.org> <alpine.LFD.0.9999.0712202009290.21557@woody.linux-foundation.org> <alpine.LFD.0.9999.0712202026040.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Raphael Assenat <raph@8d.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756715AbXLUEuc@vger.kernel.org Fri Dec 21 05:51:13 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756715AbXLUEuc@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Zqo-0006Fw-7w
	for glk-linux-kernel-3@gmane.org; Fri, 21 Dec 2007 05:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715AbXLUEuc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 20 Dec 2007 23:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759250AbXLUEuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Dec 2007 23:50:08 -0500
Received: from there.is.no.cabal.ca ([134.117.69.58]:56669 "EHLO
	fattire.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbXLUEuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Dec 2007 23:50:06 -0500
Received: by fattire.cabal.ca (Postfix, from userid 1000)
	id 2B45C23E08; Thu, 20 Dec 2007 23:50:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712202026040.21557@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69040>

On Thu, Dec 20, 2007 at 08:40:54PM -0800, Linus Torvalds wrote:
> That was a rather long-winded explanation of what happened, mainly because 
> it was all very unexpected to me, and I had personally mistakenly thought 
> the git optimization was perfectly valid and actually had to go through 
> the end result to see what was going on.
> 
> Anyway, the diff on kernel.org should be all ok now, and mirrored out too.
> 

Thanks again for being so quick to track this down, applies fine and is
out for building in rawhide now.

cheers, Kyle
