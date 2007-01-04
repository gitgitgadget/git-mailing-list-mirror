From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 21:57:00 -0500
Message-ID: <20070104025659.GE18206@spearce.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <20070104020652.GB18206@spearce.org> <20070104023510.GC18206@spearce.org> <204011cb0701031836w7d33ca8dh5de08984eec9730d@mail.gmail.com> <20070104024523.GD18206@spearce.org> <204011cb0701031853xd226683g85f376c206aacf3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 03:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2In0-000762-W5
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 03:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbXADC5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 21:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbXADC5H
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 21:57:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60830 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbXADC5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 21:57:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2Imx-0003XU-7J; Wed, 03 Jan 2007 21:57:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 755E320FB65; Wed,  3 Jan 2007 21:57:00 -0500 (EST)
To: Chris Lee <chris133@gmail.com>
Content-Disposition: inline
In-Reply-To: <204011cb0701031853xd226683g85f376c206aacf3e@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35910>

[cc: list modified to remove folks who probably aren't immediately
 interested in git-fastimport]

Chris Lee <chris133@gmail.com> wrote:
> On 1/3/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >the clone url is:
> >
> >  git://repo.or.cz/git/fastimport.git
> >  http://repo.or.cz/r/git/fastimport.git
> >
> >The entire code is in fast-import.c.  The input stream it consumes
> >comes in on STDIN and is documented in a large comment at the top
> >of the file.
> 
> Neat. How do I do that?

I'm not sure I understand the question...

-- 
Shawn.
