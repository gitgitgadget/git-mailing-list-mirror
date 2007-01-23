From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 10:29:04 -0500
Message-ID: <20070123152904.GA23549@spearce.org>
References: <200701192148.20206.johannes.sixt@telecom.at> <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com> <200701222127.09601.johannes.sixt@telecom.at> <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <ep4tmd$ut8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 16:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9NaD-0005dn-1w
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXAWP3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbXAWP3K
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:29:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39766 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbXAWP3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:29:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H9Na1-0004KM-6x; Tue, 23 Jan 2007 10:29:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 69C7B20FBAE; Tue, 23 Jan 2007 10:29:04 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ep4tmd$ut8$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37532>

Jakub Narebski <jnareb@gmail.com> wrote:
> Johannes Schindelin wrote:
> 
> > Since Tcl/Tk is available for MinGW, git-gui seems to be a way to go 
> > there.
> 
> Since Qt4 is to work in Windows natively, perhaps QGit is a way to go...

Choice is good.  ;-)

git-gui has slightly different goals/focus than QGit.  I think
its a better commit creation tool.

-- 
Shawn.
