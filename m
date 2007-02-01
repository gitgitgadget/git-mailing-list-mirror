From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git docs on kernel.org too new?
Date: Thu, 1 Feb 2007 14:20:57 -0500
Message-ID: <20070201192057.GC18608@spearce.org>
References: <Pine.LNX.4.62.0702011051300.31498@torch.nrlssc.navy.mil> <906f26060702011014r254ffd5frd75296c8443078ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Spinucci <virgo977virgo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 20:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HChUa-0000EK-6E
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 20:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422947AbXBATVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 14:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422957AbXBATVE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 14:21:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39528 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422947AbXBATVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 14:21:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HChUL-0008K0-7F; Thu, 01 Feb 2007 14:20:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0A0F620FBAE; Thu,  1 Feb 2007 14:20:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <906f26060702011014r254ffd5frd75296c8443078ab@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38390>

Stefano Spinucci <virgo977virgo@gmail.com> wrote:
> this isn't the first time someone is confused by git docs, and I guess
> why we can't have a documentation page as
> http://www.python.org/doc/versions/

Indeed.  Or at least only post docs which correspond to a
downloadable tar file?

Perhaps we could embed in at least the HTML version of the docs the
output of `GIT-VERSION-GEN` ?  Then users at least have a chance
at knowing the docs are referring to 1.5.0-rc3 and not to 1.4.4.4?

-- 
Shawn.
