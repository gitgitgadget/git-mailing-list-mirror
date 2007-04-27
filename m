From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [PATCH] git-mirror - exactly mirror another repository
Date: Fri, 27 Apr 2007 10:56:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704271055140.12006@racer.site>
References: <20070427021505.1740.58136.stgit@rover>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMGH-0006fS-IW
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 10:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbXD0I5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 04:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbXD0I5B
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 04:57:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:43838 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754140AbXD0I5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 04:57:00 -0400
Received: (qmail invoked by alias); 27 Apr 2007 08:56:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 27 Apr 2007 10:56:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XcXoLAVzXCT1UPS7FydUQY0swoEHnbrLRuuZaXr
	dcAxJCzUuhWe+1
X-X-Sender: gene099@racer.site
In-Reply-To: <20070427021505.1740.58136.stgit@rover>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45705>

Hi,

On Fri, 27 Apr 2007, Petr Baudis wrote:

> I actually still would kind of prefer this to be a git-fetch's feature 
> but the general mood seems to be to have this as a separate command and 
> I can't say I care at all.

I have to admit that I share your preference. And I really would like to 
be able to say "git fetch --all <remote>", because I use Git for backup 
operations, too.

Ciao,
Dscho
