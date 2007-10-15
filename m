From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 23:08:56 +0200
Message-ID: <uwstohyqf.fsf@gnu.org>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home> <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site> <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home> <4713C81F.A75FEFC2@dessent.net>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: raa.lkml@gmail.com, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org, ae@op5.se, tsuna@lrde.epita.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 00:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhXCV-0002xS-CV
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 23:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbXJOVJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 17:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbXJOVJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 17:09:58 -0400
Received: from nitzan.inter.net.il ([213.8.233.22]:29660 "EHLO
	nitzan.inter.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbXJOVJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 17:09:57 -0400
Received: from HOME-C4E4A596F7 (IGLD-80-230-6-147.inter.net.il [80.230.6.147])
	by nitzan.inter.net.il (MOS 3.7.3a-GA)
	with ESMTP id IAW31781 (AUTH halo1);
	Mon, 15 Oct 2007 23:06:21 +0200 (IST)
In-reply-to: <4713C81F.A75FEFC2@dessent.net> (message from Brian Dessent on
	Mon, 15 Oct 2007 13:05:51 -0700)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61046>

> Date: Mon, 15 Oct 2007 13:05:51 -0700
> From: Brian Dessent <brian@dessent.net>
> CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
>  	git@vger.kernel.org, Eli Zaretskii <eliz@gnu.org>, ae@op5.se,
>  	tsuna@lrde.epita.fr
> 
> I don't know of
> any ports of bash that aren't MSYS or Cygwin based.  However I do think
> there's a native port of zsh out there by the GnuWin32 project, which
> when renamed as just "/bin/sh" might be suitable, but only if these
> scripts don't use bash-isms.  I have not tried this zsh myself and
> speed/compatibility wise I'm not sure it's up to snuff.

I think you mean Amol's zsh (there's no GnuWin32 port of zsh AFAIK).
Amol's zsh is what I use, but it has a few annoying bugs, even after I
fixed some, that prevent it from running a typical configure script,
for example.
