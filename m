From: Junio C Hamano <junkio@cox.net>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sun, 14 Jan 2007 17:06:26 -0800
Message-ID: <7v4pqtf699.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
	<slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx>
	<E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com>
	<200701131815.27481.alan@chandlerfamily.org.uk>
	<8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com>
	<20070113203456.GA17648@spearce.org>
	<Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070114224204.GA10888@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWH-0000hV-Vr
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:18 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8h-0003eK-VB
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbXAOBG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 20:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbXAOBG3
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 20:06:29 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64626 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbXAOBG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 20:06:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070115010627.IGLE29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 14 Jan 2007 20:06:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BD5a1W0101kojtg0000000; Sun, 14 Jan 2007 20:05:35 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070114224204.GA10888@spearce.org> (Shawn O. Pearce's message
	of "Sun, 14 Jan 2007 17:42:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36832>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> You mean, you _ignored_ the text "git commit -a" gives you? It really 
>> shows you the output of "git status", exactly so you know what you 
>> committed, and sometimes more importantly, what you didn't.
>
> Because I'm a moron and forgot what files I had created recently.
> Consequently I don't see them missing from the output of git commit.
> Consequently I think the commit is OK.  :-)

I think Johannes is refering you to the "Untracked files"
section.
