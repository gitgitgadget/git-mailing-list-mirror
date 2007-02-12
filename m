From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui blametool
Date: Mon, 12 Feb 2007 12:32:18 -0500
Message-ID: <20070212173218.GD29621@spearce.org>
References: <45D07A76.1070009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 18:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGf2a-0000lI-ON
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 18:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbXBLRc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 12:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbXBLRc0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 12:32:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59175 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965023AbXBLRcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 12:32:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGf2H-0007m4-BM; Mon, 12 Feb 2007 12:32:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EFB6220FBAE; Mon, 12 Feb 2007 12:32:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45D07A76.1070009@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39420>

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> wrote:
> I found the git-gui blame tool interface quiet confusing with the all 
> those color code. What does the color code actually mean ?

Can you try the version of git-gui that Junio pushed out to `master`
last night?

> A simple 
> interface would be
> 
> [ commit ] [ line number ] [ code ]
> 
> ....
> ...
> --------------------------------------
> commit details of the selected commit

Because it uses this interface.  Almost.  It doesn't show the
[commit] column.

-- 
Shawn.
