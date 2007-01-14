From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sun, 14 Jan 2007 17:42:04 -0500
Message-ID: <20070114224204.GA10888@spearce.org>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx> <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com> <200701131815.27481.alan@chandlerfamily.org.uk> <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com> <20070113203456.GA17648@spearce.org> <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vhm-0006R3-0Z
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:10 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8I-0003eK-Ic
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbXANWmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbXANWmN
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 17:42:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55494 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbXANWmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 17:42:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6E33-0000jx-6Z; Sun, 14 Jan 2007 17:41:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D2F1920FBAE; Sun, 14 Jan 2007 17:42:04 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36814>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> You mean, you _ignored_ the text "git commit -a" gives you? It really 
> shows you the output of "git status", exactly so you know what you 
> committed, and sometimes more importantly, what you didn't.

Because I'm a moron and forgot what files I had created recently.
Consequently I don't see them missing from the output of git commit.
Consequently I think the commit is OK.  :-)

-- 
Shawn.
