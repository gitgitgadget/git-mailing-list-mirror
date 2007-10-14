From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-svn and submodules, was Re: [PATCH] parse-options: Allow
 abbreviated options when unambiguous
Date: Sun, 14 Oct 2007 23:59:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710142359020.25221@racer.site>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
 <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp>
 <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site>
 <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma>
 <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 00:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhCRB-0002jM-TE
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 00:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759901AbXJNW7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 18:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759689AbXJNW7s
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 18:59:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:41299 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759281AbXJNW7r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 18:59:47 -0400
Received: (qmail invoked by alias); 14 Oct 2007 22:59:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 15 Oct 2007 00:59:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XBj9YdBOX5m6VLBi6FyumPxV0R/mYWkMj8DAy46
	pGaDV6bmKtz9J7
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014224959.GA17828@untitled>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60927>

Hi,

On Sun, 14 Oct 2007, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > While I have your attention: last weekend, I spoke to a guy from the 
> > ffmpeg project, and he said that the only thing preventing them from 
> > switching to git was the lack of svn:external support...
> > 
> > (Of course I know that it is more difficult than that: ffmpeg itself 
> > is an svn:external of MPlayer, but maybe we can get both of them to 
> > switch ;-)
> > 
> > Do you have any idea when/if you're coming around to add that to 
> > git-svn?
> 
> Soonish, possibly within a next week, even.  I have actually have 
> started a project (using git) that wants to use SVN-hosted repositories 
> directly submodules; so the fact that I'll actually need something like 
> it bodes well for getting it implemented :)

Hehe.  Thanks!

Ciao,
Dscho
