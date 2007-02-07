From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Wed, 7 Feb 2007 00:46:14 -0500
Message-ID: <20070207054614.GA7138@spearce.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com> <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org> <20070206164441.GA4949@spearce.org> <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Feb 07 06:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEfdT-00070K-54
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 06:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbXBGFqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 00:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965500AbXBGFqY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 00:46:24 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42611 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbXBGFqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 00:46:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEfdH-0003Xw-TS; Wed, 07 Feb 2007 00:46:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8264E20FBAE; Wed,  7 Feb 2007 00:46:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38890>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> Shawn O. Pearce <spearce@spearce.org> wrote:
> > 	written in base-10 notation using US-ASCII digits.  The committer's
> > 	timezone is specified by `<tz>` as a positive or negative offset
> > 	from UTC.  For example EST (which is typically 5 hours behind GMT)
> > 	would be expressed in `<tz>` by ``-0500'' while GMT is ``+0000''.
> 
> That is /not/ a timezone! Maybe an offset from UTC.

Indeed.  Thank you for the correction.  I'll push out fixed docs
shortly.

-- 
Shawn.
