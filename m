From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Another question about importing SVN with fast-import
Date: Mon, 6 Aug 2007 21:08:50 -0400
Message-ID: <20070807010850.GM9527@spearce.org>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk> <20070717033840.GK32566@spearce.org> <Pine.LNX.4.64.0708061408470.18641@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 07 03:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIDZS-0003Rr-0f
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 03:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764335AbXHGBI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 21:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764321AbXHGBI4
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 21:08:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57928 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759931AbXHGBIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 21:08:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IIDYw-0004g6-Cg; Mon, 06 Aug 2007 21:08:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6667920FBAE; Mon,  6 Aug 2007 21:08:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708061408470.18641@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55192>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Mon, 16 Jul 2007, Shawn O. Pearce wrote:
> 
> >Julian Phillips <julian@quantumfyre.co.uk> wrote:
> >>However, how do you copy a file from a
> >>particular revision?
> >
> >and sometimes not so much.  You can't do that right now.  I've wanted
> >to open up the data subcommand to allow another form that lets you
> >specify data from a branch and file path (thus selecting a blob
> >from another revision) but I haven't gotten around to it.  I also
> >don't have time to do it during the earlier part of this week.
> >Maybe I'll get to it later near the end of the week.
> 
> I was wondering if this was still a vague todo item, or if it was being 
> worked on?  It really is the biggest thing blocking my import at the 
> moment and I'm willing to have a bash at it myself, but I didn't want to 
> start messing around inside the fast-import code if someone else was 
> already there ...

No, its not vague.  I'm still working on it.  Actually its on
my to-do list for tonight, and if I don't finish it tonight then
Thursday.
 
-- 
Shawn.
