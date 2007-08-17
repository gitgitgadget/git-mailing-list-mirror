From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitignore and shared worktrees (resend)
Date: Fri, 17 Aug 2007 23:21:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708172320380.20400@racer.site>
References: <20070816102225.GA5351@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 00:21:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMAC6-00065k-Vr
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 00:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbXHQWVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 18:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbXHQWVX
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 18:21:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:59516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbXHQWVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 18:21:21 -0400
Received: (qmail invoked by alias); 17 Aug 2007 22:21:20 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp056) with SMTP; 18 Aug 2007 00:21:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18C+qJCv9YCgtnhkRWjeEjRYJgL5yCsqzfg0Xl/3f
	G5nlr8U2LdMZvA
X-X-Sender: gene099@racer.site
In-Reply-To: <20070816102225.GA5351@piper.oerlikon.madduck.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56093>

Hi,

On Thu, 16 Aug 2007, martin f krafft wrote:

> Basically the issue is with using multiple git repos all sharing the 
> same worktree, and that I cannot come up with a sensible way to maintain 
> the .gitignore file such that it is part of the repo (and thus exists in 
> other clones as well).

I saw your message, but I could not come up with a reasonable solution.

Ciao,
Dscho
