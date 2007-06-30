From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 22:37:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706302236210.4438@racer.site>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
 <f66eog$qe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 23:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4kd1-0000xi-V9
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 23:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbXF3VhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 17:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbXF3VhN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 17:37:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:48816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752491AbXF3VhM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 17:37:12 -0400
Received: (qmail invoked by alias); 30 Jun 2007 21:37:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 30 Jun 2007 23:37:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RHhkoHYXRngkOmOfhoXBqVeZ4TuT09zPZHIjZDF
	5kZAn1LdOrwm+T
X-X-Sender: gene099@racer.site
In-Reply-To: <f66eog$qe$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51258>

Hi,

On Sat, 30 Jun 2007, walt wrote:

> Linus Torvalds wrote:
> > I realize that a lot of people use the "git-xyzzy" format, and we have
> > various historical reasons for it...
> 
> One of the historical reasons was to allow users of gnu interactive
> tools to delete the git wrapper script, as outlined in 'INSTALL'.
> 
> Seems unlikely that 'git' could still be deleted if your proposed
> changes are implemented.  I recall that a few people cared a lot
> about this, and not too long ago.

All this would be less of a problem if Git consisted only of builtins, 
since you could easily do "mv git gitscm" then. *sigh*

Ciao,
Dscho
