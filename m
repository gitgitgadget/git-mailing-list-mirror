From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 01:18:17 -0500
Message-ID: <20070206061817.GB10508@spearce.org>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 07:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEJew-0006Ge-9C
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 07:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965370AbXBFGSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 01:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965374AbXBFGSX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 01:18:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51657 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965370AbXBFGSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 01:18:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEJel-0007ju-BV; Tue, 06 Feb 2007 01:18:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3C08B20FBAE; Tue,  6 Feb 2007 01:18:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45C81C33.6010704@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38812>

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> wrote:
> >SYNOPSIS
> >--------
> >frontend | 'git-fast-import' [options]
> >
> 
> Do we have example frontend  that can be added along with gfi ?

Not yet.  Some frontends are available here on repo.or.cz:

  gitweb: http://repo.or.cz/w/fast-export.git
  clone:  git://repo.or.cz/fast-export.git

But both lack branch support, for example, so they probably aren't
nearly as complete as the existing non-gfi based importers.

-- 
Shawn.
