From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 23:49:15 -0500
Message-ID: <20070212044914.GA699@spearce.org>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com> <20070211225326.GC31488@spearce.org> <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com> <Pine.LNX.4.64.0702112022430.1757@xanadu.home> <9e4733910702111815g5a42989fr8042e84b291ab576@mail.gmail.com> <Pine.LNX.4.64.0702112251580.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 05:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGT80-0003ee-RH
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 05:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbXBLEtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 23:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932946AbXBLEtV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 23:49:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60944 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821AbXBLEtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 23:49:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGT7h-0003x0-4m; Sun, 11 Feb 2007 23:49:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BE73E20FBAE; Sun, 11 Feb 2007 23:49:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702112251580.1757@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39362>

Nicolas Pitre <nico@cam.org> wrote:
> Try with git2.kernel.org then.  It seems that git.kernel.org too often 
> resolves to git1.kernel.org not sharing the load with git2.kernel.org 
> appropriately.

Hey!  You are giving out my secret!

(I use git2.kernel.org to fetch git.git.)

-- 
Shawn.
