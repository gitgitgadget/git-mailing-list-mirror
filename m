From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Pruning objects from history?
Date: Fri, 30 Mar 2007 22:08:06 -0400
Message-ID: <20070331020806.GB15922@spearce.org>
References: <460DC0F7.1070607@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 04:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXT13-0006eR-8i
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 04:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305AbXCaCIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 22:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933310AbXCaCIM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 22:08:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60845 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933305AbXCaCIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 22:08:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HXT0X-0006Em-GQ; Fri, 30 Mar 2007 22:07:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8CDD820FBAE; Fri, 30 Mar 2007 22:08:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <460DC0F7.1070607@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43528>

Steven Grimm <koreth@midwinter.com> wrote:
> Is there any way to excise those files? They are of no interest to us 
> now -- they were data files for a third-party application we ended up 
> not using -- and they're making git look bad in the disk usage department.

Try cg-admin-rewritehistory (in Cogito)?

-- 
Shawn.
