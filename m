From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Thu, 24 Jul 2008 15:40:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241539400.8986@racer>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807231852.10206.litvinov2004@gmail.com> <20080724142453.GV2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:42:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM215-0000mL-Ce
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYGXOk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYGXOk5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:40:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:57274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750799AbYGXOk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:40:57 -0400
Received: (qmail invoked by alias); 24 Jul 2008 14:40:55 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp014) with SMTP; 24 Jul 2008 16:40:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3+tkmAoS3OsyeufkMIxiiQffwaYV84kLKb9A3Dn
	54R7hpB9b+3gKH
X-X-Sender: gene099@racer
In-Reply-To: <20080724142453.GV2925@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89889>

Hi,

On Thu, 24 Jul 2008, Dmitry Potapov wrote:

> On Wed, Jul 23, 2008 at 06:52:09PM +0700, Alexander Litvinov wrote:
> > > On Wed, 23 Jul 2008, Alexander Litvinov wrote:
> > > > In short: I can't clone svn repo into git when crlf convertion is 
> > > > activated.
> > >
> > > This is a known issue, but since nobody with that itch seems to care 
> > > enough to fix it, I doubt it will ever be fixed.
> > 
> > That is a bad news for me. Anyway I will spend some time at holidays 
> > during digging this bug.
> 
> I don't want to discourage from digging into this problem

Great.  Thanks.  There is someone who is actually willing to work on the 
problem.

> Practically all Windows editors do not have problems to open and edit 
> files with LF endings, but some of them will write back using CRLF.

95.23% of all statistics are made up on the spot.  I would be surprised if 
that was not the case here.

Ciao,
Dscho
