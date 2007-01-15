From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sun, 14 Jan 2007 20:12:18 -0500
Message-ID: <20070115011217.GA11240@spearce.org>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx> <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com> <200701131815.27481.alan@chandlerfamily.org.uk> <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com> <20070113203456.GA17648@spearce.org> <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070114224204.GA10888@spearce.org> <7v4pqtf699.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:07:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2G-0000Lk-98
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:20 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8i-0003eK-H6
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbXAOBM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 20:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXAOBM0
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 20:12:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60075 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbXAOBMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 20:12:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6GOP-0001rh-JJ; Sun, 14 Jan 2007 20:12:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6F1FA20FBAE; Sun, 14 Jan 2007 20:12:18 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pqtf699.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36864>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> You mean, you _ignored_ the text "git commit -a" gives you? It really 
> >> shows you the output of "git status", exactly so you know what you 
> >> committed, and sometimes more importantly, what you didn't.
> >
> > Because I'm a moron and forgot what files I had created recently.
> > Consequently I don't see them missing from the output of git commit.
> > Consequently I think the commit is OK.  :-)
> 
> I think Johannes is refering you to the "Untracked files"
> section.

I commit often directly from the command line.

But yes, you're right.  If I actually started my editor its right
there in the commit message template.  Easy enough to quit without
writing the file, add the new files, and restart the commit.

-- 
Shawn.
