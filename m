From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 23:01:13 +0100
Message-ID: <20060302220113.GD6183@steel.home>
References: <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <81b0412b0603020610q41d0ec98x80d112b7daa179fa@mail.gmail.com> <20060302150016.GC2781@trixie.casa.cgf.cx> <81b0412b0603020810l57f9ee5p270f9c288770d1a7@mail.gmail.com> <44072DEF.1070906@op5.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Faylor <me@cgf.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 23:01:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEvrQ-0005sN-8G
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 23:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWCBWBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 17:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWCBWBV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 17:01:21 -0500
Received: from devrace.com ([198.63.210.113]:39433 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751689AbWCBWBU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 17:01:20 -0500
Received: from tigra.home (p54A05596.dip.t-dialin.net [84.160.85.150])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k22M1FxJ017750;
	Thu, 2 Mar 2006 16:01:16 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FEvrF-0005oN-00; Thu, 02 Mar 2006 23:01:13 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FEvrF-0002Dw-MS; Thu, 02 Mar 2006 23:01:13 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <44072DEF.1070906@op5.se>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17111>

Andreas Ericsson, Thu, Mar 02, 2006 18:39:59 +0100:
> Ye gawds, Alex. If you complained this much to your employer you'd get 
> to run whatever OS you want.

I never stopped. I usually manage to convince them, it just hasn't
happened here yet.
