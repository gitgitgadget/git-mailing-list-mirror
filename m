From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] some doc updates
Date: Sun, 14 Jan 2007 22:47:05 -0500
Message-ID: <20070115034705.GB11240@spearce.org>
References: <Pine.LNX.4.64.0701142210520.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:32:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWF-0000g7-VA
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:15 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8u-0003eK-38
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbXAODrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 22:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbXAODrP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 22:47:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36134 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbXAODrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 22:47:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6IoE-0005sx-Kp; Sun, 14 Jan 2007 22:46:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 227E920FBAE; Sun, 14 Jan 2007 22:47:06 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701142210520.2577@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36834>

Nicolas Pitre <nico@cam.org> wrote:
> 3) echo "URL: blah" > .git/remotes/foo is obsolete and should be
>    "git repo-config remote.foo.url blah"

or "git remote add foo blah".
 
-- 
Shawn.
