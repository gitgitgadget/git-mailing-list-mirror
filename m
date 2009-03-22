From: Jeff King <peff@peff.net>
Subject: Re: Git for Windows 1.6.2.1-preview20090322
Date: Sun, 22 Mar 2009 18:53:15 -0400
Message-ID: <20090322225315.GC22428@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:54:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWZ4-0000DF-CE
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbZCVWxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 18:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756084AbZCVWxQ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 18:53:16 -0400
Received: from peff.net ([208.65.91.99]:39201 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756009AbZCVWxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 18:53:16 -0400
Received: (qmail 16809 invoked by uid 107); 22 Mar 2009 22:53:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 22 Mar 2009 18:53:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 18:53:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114193>

On Sun, Mar 22, 2009 at 10:17:23PM +0100, Johannes Schindelin wrote:

> - Some commands are not yet supported on Windows and excluded from the 
>   installation; namely: git archimport, git cvsexportcommit, git 
>   cvsimport, git cvsserver, git filter-branch, git instaweb, git 
>   send-email, git shell.

A few people have asked about filter-branch on Windows recently; JSixt
indicated that it works from his built version:

  http://article.gmane.org/gmane.comp.version-control.git/112103

Is it time to include it?

-Peff
