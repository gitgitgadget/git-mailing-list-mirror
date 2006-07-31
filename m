From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Mon, 31 Jul 2006 00:22:00 -0400
Message-ID: <20060731042200.GA27648@spearce.org>
References: <20060728063620.GD30783@spearce.org> <Pine.LNX.4.64.0607301047150.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 06:22:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7PID-0006O5-OC
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 06:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWGaEWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 00:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWGaEWK
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 00:22:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48595 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751460AbWGaEWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 00:22:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G7PI3-00027A-78; Mon, 31 Jul 2006 00:22:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E44B420E433; Mon, 31 Jul 2006 00:22:00 -0400 (EDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607301047150.9789@iabervon.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24490>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 28 Jul 2006, Shawn Pearce wrote:
> 
> > I would appreciate any and all input, feedback, etc. that anyone
> > might have on this library or plugin.  Patches are of course
> > certainly welcome.  :-)
> 
> I'm going to try to do a Servlet (+ my stuff) implementation of essentiall 
> gitweb, with the idea that it could integrate with project management 
> software (i.e., link completed tasks to the commit which completed them, 
> regressions to the commit that broke things, fixes to the commit that 
> fixed them, etc, with the UI for choosing values letting you browse the 
> actual content and validating that the hash you give exists).
> 
> I don't think I need anything you don't already have, but I'll write 
> documentation as I figure out what's going on, if you want that.

Sure.  Any improvements would be welcome.  :-)

Please keep in mind that when I post the next update to the
repository I'm going to switch the license to the LGPL.

Apparently the Apache License has issues with GPL (I didn't know
this until just recently) and the GPL is definately incompatible
with the Eclipse license (also just found this out).

-- 
Shawn.
