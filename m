From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Thu, 8 Feb 2007 14:10:24 -0500
Message-ID: <20070208191024.GA537@spearce.org>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com> <20070206061817.GB10508@spearce.org> <Pine.LNX.4.64.0702062347060.20138@iabervon.org> <20070207091351.GA1632@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0702071216330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070207225532.GA1970@spearce.org> <Pine.LNX.4.63.0702080054180.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702080851140.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 20:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFEfv-0005SE-5h
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423254AbXBHTKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423257AbXBHTKh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:10:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57346 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423254AbXBHTKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:10:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFEex-0004HD-Pg; Thu, 08 Feb 2007 14:10:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1F42520FBAE; Thu,  8 Feb 2007 14:10:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702080851140.8424@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39073>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 8 Feb 2007, Johannes Schindelin wrote:
> > 
> > Ah! I overlooked that feature. Certainly, this makes gfi (could we please 
> > call it "fast-import", please?) very useful for history rewriting 
> > purposed.
> 
> Yeah, I think fast-import is great. And I'd also like to echo that call to 
> not call it "gfi". Maybe it's just me, and maybe it's just because I'm a 
> home-owner who does things like add in-wall ethernet cables, but to me, 
> gfi is about an electrical outlet.

OK.  There happen to be 78 uses of `gfi` in the manpage.
I'll correct the spelling to fast-import.  :-)

-- 
Shawn.
