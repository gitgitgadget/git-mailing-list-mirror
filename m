From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Symbolic link documentation
Date: Thu, 20 Sep 2007 18:52:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201851190.28395@racer.site>
References: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com>
 <Pine.LNX.4.64.0709201819340.28395@racer.site> <20070920172736.GU3099@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Matt Seitz (matseitz)" <matseitz@cisco.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYQDT-0003wu-H8
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 19:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759886AbXITRxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 13:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759881AbXITRxX
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 13:53:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:59033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759861AbXITRxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 13:53:21 -0400
Received: (qmail invoked by alias); 20 Sep 2007 17:53:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 20 Sep 2007 19:53:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KMcoWr9zKufnmBD0ZiHLFyhAANDDiJUWQQ/iCz3
	kjKivhSqVhfNG3
X-X-Sender: gene099@racer.site
In-Reply-To: <20070920172736.GU3099@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58792>

Hi,

On Thu, 20 Sep 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 20 Sep 2007, Matt Seitz (matseitz) wrote:
> > 
> > > Where does the git user documentation discuss how git handles 
> > > symbolic links?
> > 
> > $ git grep symbolic Documentation/ | grep link
> > [...]
> > Documentation/config.txt:	If false, symbolic links are checked out as small plain files that
> > Documentation/config.txt:	symbolic links. True by default.
> > Documentation/git-update-index.txt:to 'false' (see gitlink:git-config[1]), symbolic links are checked out
> > Documentation/git-update-index.txt:from symbolic link to regular file.
> > Documentation/technical/racy-git.txt:files vs symbolic links) and executable bits (only for regular
> 
> These are probably what Matt was looking for.

Well, he asked where the git user documentation talks about symbolic 
links, and I provided a pointer.

Ciao,
Dscho
