From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 21:48:27 +0200
Message-ID: <u1wbwjh10.fsf@gnu.org>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home> <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site> <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: brian@dessent.net, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	ae@op5.se, tsuna@lrde.epita.fr
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 22:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhVwQ-0000Zz-Tj
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 21:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbXJOTtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 15:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbXJOTtV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 15:49:21 -0400
Received: from nitzan.inter.net.il ([213.8.233.22]:27792 "EHLO
	nitzan.inter.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbXJOTtU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 15:49:20 -0400
X-Greylist: delayed 76038 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2007 15:49:19 EDT
Received: from HOME-C4E4A596F7 (IGLD-80-230-6-147.inter.net.il [80.230.6.147])
	by nitzan.inter.net.il (MOS 3.7.3a-GA)
	with ESMTP id IAV87503 (AUTH halo1);
	Mon, 15 Oct 2007 21:45:51 +0200 (IST)
In-reply-to: <20071015194214.GC15541@steel.home> (message from Alex Riesen on
	Mon, 15 Oct 2007 21:42:14 +0200)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61035>

> Date: Mon, 15 Oct 2007 21:42:14 +0200
> From: Alex Riesen <raa.lkml@gmail.com>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
> 	Eli Zaretskii <eliz@gnu.org>, ae@op5.se, tsuna@lrde.epita.fr
> 
> Hmm... Could the allocation of large contiguous blocks also lock the
> system hard?

No, not on XP.

> For instance, I avoid starting the test suite on my XP
> workstation at work: it locks up hard every time.

Sounds like a bug to me.
