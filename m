From: Shawn Pearce <spearce@spearce.org>
Subject: Re: warning merge message
Date: Thu, 21 Dec 2006 19:43:11 -0500
Message-ID: <20061222004311.GC14636@spearce.org>
References: <Pine.LNX.4.63.0612211022280.19693@wbgn013.biozentrum.uni-wuerzburg.de> <121430.93915.qm@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYVL-0002LU-GV
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423158AbWLVAnQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423162AbWLVAnQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:43:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57460 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423158AbWLVAnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:43:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxYV5-00058d-Re; Thu, 21 Dec 2006 19:43:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 106BD20FB65; Thu, 21 Dec 2006 19:43:11 -0500 (EST)
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <121430.93915.qm@web31808.mail.mud.yahoo.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35097>

Luben Tuikov <ltuikov@yahoo.com> wrote:
> I'm swamped.  Did you say you have no 64 bit machines you can try it on?
> Also, I don't mind giving you my dev tree, but currently I don't export
> it anywhere.  BTW, I've seen this bug on 64 bit machines.  I've not tried
> it on 32.

I have an amd64 here that I need to finish configuring.  Its running
well enough however that I could debug this issue on that machine
if I could get the branches in question.

merge-recursive and the xdl_merge() routine aren't exactly my area
of expertise, but if Johannes can't do it I'll step up and see what
I can do.

-- 
Shawn.
