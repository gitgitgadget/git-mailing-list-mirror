From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined
 at config time
Date: Sun, 17 Feb 2008 00:46:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802170045210.30505@racer.site>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de> <20080217002029.GA504@hashpling.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 01:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQXgM-0004t4-4p
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 01:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbYBQAq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 19:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbYBQAq1
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 19:46:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:41980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752325AbYBQAq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 19:46:26 -0500
Received: (qmail invoked by alias); 17 Feb 2008 00:46:24 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.76]) [86.138.198.40]
  by mail.gmx.net (mp016) with SMTP; 17 Feb 2008 01:46:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/81BwpP+X8hBiu6iq/l7XcH5oNe2GHEvWVuZjtxj
	R5LA/13sDTg/MI
X-X-Sender: gene099@racer.site
In-Reply-To: <20080217002029.GA504@hashpling.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74086>

Hi,

On Sun, 17 Feb 2008, Charles Bailey wrote:

> On Sat, Feb 16, 2008 at 11:37:31PM +0100, Steffen Prohaska wrote:
> 
> > Why not just add the tools you have in mind to git mergetool?  If 
> > everyone did that eventually we would have direct support for a rather 
> > long list of tools.  This would be the easiest solution for the end 
> > user: He could just choose the preferred tool and use it.  The 
> > invocation of each merge tool would be coded in mergetool.  The exact 
> > command line could be fine tuned and would be reviewed by other git 
> > developers.
> > 
> 
> I have to disagree with this approach.

So you'd rather have the end users do the same work for the same tool over 
and over again?

Ciao,
Dscho
