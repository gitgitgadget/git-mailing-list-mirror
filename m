From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 23 Jul 2008 13:57:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231356540.8986@racer>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807231852.10206.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 14:58:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLdvi-0003aA-A6
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 14:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbYGWM5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 08:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbYGWM5z
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 08:57:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:35338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751266AbYGWM5y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 08:57:54 -0400
Received: (qmail invoked by alias); 23 Jul 2008 12:57:52 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp026) with SMTP; 23 Jul 2008 14:57:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WtYpX7yyWGW6rSNcOUimGIgA7oZuh3uwyRpw34H
	v8N5DRlipVpXrZ
X-X-Sender: gene099@racer
In-Reply-To: <200807231852.10206.litvinov2004@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89643>

Hi,

On Wed, 23 Jul 2008, Alexander Litvinov wrote:

> > On Wed, 23 Jul 2008, Alexander Litvinov wrote:
> > > In short: I can't clone svn repo into git when crlf convertion is 
> > > activated.
> >
> > This is a known issue, but since nobody with that itch seems to care 
> > enough to fix it, I doubt it will ever be fixed.
> 
> That is a bad news for me. Anyway I will spend some time at holidays 
> during digging this bug.

Note that you will have to do your digging using msysGit (i.e. the 
developer's pack, not the installer for plain Git), since git-svn will be 
removed from the next official "Windows Git" release, due to lack of 
fixers.

Ciao,
Dscho
