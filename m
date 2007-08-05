From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 06:10:53 -0400
Message-ID: <20070805101053.GH12507@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz> <20070804104851.162d7e00.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Aug 05 12:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHd4d-0003NV-0d
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 12:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbXHEKK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 06:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbXHEKK4
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 06:10:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2268 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbXHEKKz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 06:10:55 -0400
Received: (qmail 16592 invoked from network); 5 Aug 2007 10:10:58 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 10:10:58 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 06:10:53 -0400
Content-Disposition: inline
In-Reply-To: <20070804104851.162d7e00.seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54984>

On Sat, Aug 04, 2007 at 10:48:51AM -0400, Sean wrote:

> The config file does not record the remote-tracking-branch, instead
> it explicitly records the remote repository information.  So it sure
> appears that if you add the --track option, it _does_ make the local
> branch track a remote directly.  Thus it's hard to call it anything
> but what you labelled it,  a local tracking-branch.
> 
> While I thought i had a handle on this, i'm now officially more
> confused than you; hopefully someone with knowledge of the guts
> of Git will speak up.   Junio Help!

There is some discussion in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/35090/focus=35265

-Peff
