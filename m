From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 01:49:34 +0100
Message-ID: <1184374174.2785.104.camel@shinybook.infradead.org>
References: <Pine.LNX.4.64.0707111940080.4516@racer.site>
	 <20070711202615.GE3069@efreet.light.src>
	 <200707120857.53090.andyparkins@gmail.com>
	 <1184261246.31598.139.camel@pmac.infradead.org>
	 <20070713003700.GA21304@thunk.org>
	 <1184367619.2785.58.camel@shinybook.infradead.org>
	 <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
	 <1184370414.2785.79.camel@shinybook.infradead.org>
	 <alpine.LFD.0.999.0707131704000.20061@woody.linux-foundation.org>
	 <1184373393.2785.99.camel@shinybook.infradead.org>
	 <20070714004433.GB10131@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 02:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9VoS-0005AW-8q
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 02:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759396AbXGNAsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 20:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759347AbXGNAsk
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 20:48:40 -0400
Received: from canuck.infradead.org ([209.217.80.40]:33101 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206AbXGNAsj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 20:48:39 -0400
Received: from shinybook-bcm.infradead.org ([2001:8b0:10b:1:20a:95ff:fef3:9992])
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I9VoH-0006ch-Re; Fri, 13 Jul 2007 20:48:34 -0400
In-Reply-To: <20070714004433.GB10131@fieldses.org>
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52430>

On Fri, 2007-07-13 at 20:44 -0400, J. Bruce Fields wrote:
> On Sat, Jul 14, 2007 at 01:36:33AM +0100, David Woodhouse wrote:
> > Yeah, much of it. Although I've also seen other people trying to get
> > to grips with git and tripping up over branches recently.
> 
> Could you give any details?  What specifically was it they were having
> trouble with? 

Just conversations on IRC where stuff had to be explained. People not
understanding that they'd actually cloned _multiple_ branches and they
needed to select the one they wanted, making the same kind of stupid
mistakes I did with committing to the wrong place, etc. Nothing specific
stands out as being fixable, certainly.

Branches have their place, and some people seem very happy with them as
part of their local workflow. I just wonder if we have to have them on
the servers too; that's all.

-- 
dwmw2
