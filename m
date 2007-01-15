From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Mon, 15 Jan 2007 17:46:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701151727310.20138@iabervon.org>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
 <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx>
 <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com>
 <200701131815.27481.alan@chandlerfamily.org.uk>
 <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com>
 <20070113203456.GA17648@spearce.org> <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070114224204.GA10888@spearce.org> <7v4pqtf699.fsf@assigned-by-dhcp.cox.net>
 <20070115011217.GA11240@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 23:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6aax-0004Ae-B5
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXAOWqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 17:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbXAOWqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:46:09 -0500
Received: from iabervon.org ([66.92.72.58]:1642 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbXAOWqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:46:08 -0500
Received: (qmail 27549 invoked by uid 1000); 15 Jan 2007 17:46:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2007 17:46:05 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070115011217.GA11240@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36898>

On Sun, 14 Jan 2007, Shawn O. Pearce wrote:

> I commit often directly from the command line.
> 
> But yes, you're right.  If I actually started my editor its right
> there in the commit message template.  Easy enough to quit without
> writing the file, add the new files, and restart the commit.

An config option to prohibit committing with untracked files should be 
easy to add. If your workflow is such that incorrect commits are sometimes 
generated given either policy, the system should ask you which you mean.

	-Daniel
*This .sig left intentionally blank*
