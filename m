From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 23:06:11 +0200
Message-ID: <uy7e4hyv0.fsf@gnu.org>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
 <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
 <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site>
 <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home>
 <u1wbwjh10.fsf@gnu.org> <Pine.LNX.4.64.0710152057580.25221@racer.site>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: raa.lkml@gmail.com, brian@dessent.net, git@vger.kernel.org,
	ae@op5.se, tsuna@lrde.epita.fr
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 00:02:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhX9S-0002FA-QN
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 23:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608AbXJOVGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 17:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbXJOVGv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 17:06:51 -0400
Received: from nitzan.inter.net.il ([213.8.233.22]:19016 "EHLO
	nitzan.inter.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbXJOVGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 17:06:50 -0400
Received: from HOME-C4E4A596F7 (IGLD-80-230-6-147.inter.net.il [80.230.6.147])
	by nitzan.inter.net.il (MOS 3.7.3a-GA)
	with ESMTP id IAW30343 (AUTH halo1);
	Mon, 15 Oct 2007 23:03:34 +0200 (IST)
In-reply-to: <Pine.LNX.4.64.0710152057580.25221@racer.site> (message from
	Johannes Schindelin on Mon, 15 Oct 2007 20:58:26 +0100 (BST))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61045>

> Date: Mon, 15 Oct 2007 20:58:26 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: Alex Riesen <raa.lkml@gmail.com>, brian@dessent.net, git@vger.kernel.org, 
>     ae@op5.se, tsuna@lrde.epita.fr
> 
> On Mon, 15 Oct 2007, Eli Zaretskii wrote:
> 
> > > From: Alex Riesen <raa.lkml@gmail.com>
> > 
> > > For instance, I avoid starting the test suite on my XP workstation at 
> > > work: it locks up hard every time.
> > 
> > Sounds like a bug to me.
> 
> To me, too.  Alas, it works on W2k, so where is the bug?

I'm not smart enough to know without debugging it.  W2K and WXP have
different system libraries and somewhat different memory layouts.  A
bug can get away on one, but not on the other.
