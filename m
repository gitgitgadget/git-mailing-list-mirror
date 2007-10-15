From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 04:20:22 -0400
Message-ID: <E1IhLBW-0006uw-19@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>  <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>  <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <Pine.LNX.4.64.0710150223230.25221@racer.site> <E1IhJ4K-00086x-5U@fencepost.gnu.org> <AD60F584-7AAD-4083-9BA6-21F0D00D6D1D@zib.de>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr,
	make-w32@gnu.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 10:20:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhLBh-00082l-OS
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 10:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbXJOIUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 04:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbXJOIUX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 04:20:23 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:57217 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbXJOIUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 04:20:23 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhLBW-0006uw-19; Mon, 15 Oct 2007 04:20:22 -0400
In-reply-to: <AD60F584-7AAD-4083-9BA6-21F0D00D6D1D@zib.de> (message from
	Steffen Prohaska on Mon, 15 Oct 2007 09:56:40 +0200)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60960>

> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
>         raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr, make-w32@gnu.org
> From: Steffen Prohaska <prohaska@zib.de>
> Date: Mon, 15 Oct 2007 09:56:40 +0200
> 
> > While we are at that: can you (or someone else) point me to
> > instructions on how to build the MinGW port of GIT?  I found a tarball
> > of the MinGW-ported GIT (v1.5.3, I think), but what I don't seem to be
> > able to find is some kind of HOWTO: what tools I need to have
> > installed, how to configure them (if there are any special issues
> > there), what command(s) to type, etc.  Is there anything like that out
> > there, or can someone post such instructions?
> 
> If you want to have a full working development environment, such that
> you can start contributing to msysgit right away, and have no firewall
> issues, go to
> 
> 	http://code.google.com/p/msysgit/
> 
> and install GitMe, currently
> 
> 	http://msysgit.googlecode.com/files/GitMe-0.4.2.exe
> 
> If you only care about an end-user setup, which contains only the git
> binaries on your system, but no tools to compile them, stay tuned for
> one or two days. We'll release an updated installer soon.

Sorry I wasn't clear: I want neither.  I don't think I will have
enough free time to become an active contributor to GIT any time
soon.  OTOH, since binaries are not available (and I'd prefer a
tarball as opposed to an installer, to be more in control of what's
being installed and where), I asked about the development tools
(compiler and Binutils, obviously, but what else?) required to build
the source tarball with MinGW tools.

Do I understand correctly that building GIT currently requires MSYS?
That'd be unfortunate, at least for me.

Anyway, thanks for replying.
