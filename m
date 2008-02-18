From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Which module contains SVN/Core.pm in CPAN
Date: Mon, 18 Feb 2008 11:52:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181151360.30505@racer.site>
References: <389581.75818.qm@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 12:53:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR4Yu-0007R0-Lp
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 12:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758320AbYBRLwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 06:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758148AbYBRLwx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 06:52:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:35475 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758105AbYBRLww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 06:52:52 -0500
Received: (qmail invoked by alias); 18 Feb 2008 11:52:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp054) with SMTP; 18 Feb 2008 12:52:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QESlUzmhQgf/FsmvBqbE2B+PoW59sugv+DCyT4y
	B7Jici2GAnS22d
X-X-Sender: gene099@racer.site
In-Reply-To: <389581.75818.qm@web31805.mail.mud.yahoo.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74269>

Hi,

On Mon, 18 Feb 2008, Luben Tuikov wrote:

> Which module(s) in CPAN gives the minimal set to run "git-svn"?

AFAICT none.  It is in subversion's source code.

Hth,
Dscho

P.S.: If you're trying to get it to run on Windows (msysGit), you might be 
interested in this:

http://msysgit.googlecode.com/files/Git-preview20080203-with-git-svn.exe
