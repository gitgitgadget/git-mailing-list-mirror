From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Thu, 15 Dec 2005 23:24:24 +0100
Message-ID: <20051215222424.GA3094@steel.home>
References: <11344712912199-git-send-email-matlads@dsmagic.com> <7vy82p9rnb.fsf@assigned-by-dhcp.cox.net> <20051213170015.GD22159@pasky.or.cz> <7vu0dcalgo.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 23:27:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En1XM-00063L-GU
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 23:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVLOWZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 17:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVLOWZP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 17:25:15 -0500
Received: from devrace.com ([198.63.210.113]:58891 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751151AbVLOWZO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 17:25:14 -0500
Received: from tigra.home (p54A0F888.dip.t-dialin.net [84.160.248.136])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jBFMOR7V023686;
	Thu, 15 Dec 2005 16:24:29 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1En1WU-0000Kl-00; Thu, 15 Dec 2005 23:24:26 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1En1WT-0002xe-3a; Thu, 15 Dec 2005 23:24:25 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0dcalgo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13712>

Junio C Hamano, Tue, Dec 13, 2005 19:41:27 +0100:
> 
> > Thank you both for the patch, but I'd be much more comfortable if at
> > least quotes (both ' and "), backslashes, ? and * would be prohibited in
> > the names as well.
> 
> I second that, and thanks for pointing it out.  Any objections?

Just as a warning, perhaps? It's not like git is anywhere limited in
this respect...
