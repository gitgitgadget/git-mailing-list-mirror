From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Tracability in git commits
Date: Tue, 29 Apr 2008 17:08:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804291707210.27457@eeepc-johanness>
References: <1209473739.5642.31.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:09:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqsOY-00060l-5b
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759136AbYD2QIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756862AbYD2QIO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:08:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756836AbYD2QIM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:08:12 -0400
Received: (qmail invoked by alias); 29 Apr 2008 16:08:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp027) with SMTP; 29 Apr 2008 18:08:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+L/fIsUdiL1SWIwx+U4vm0QvS4DhygdOHox2rOK4
	PCcLWZ/64w/pm6
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1209473739.5642.31.camel@dax.rpnet.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80698>

Hi,

On Tue, 29 Apr 2008, Richard Purdie wrote:

> I've been wondering about whether its possible to provide some degree of 
> traceability of commits to a shared git repository. The potential 
> nightmare scenario is one developer making a commit pretending to be 
> someone else.

You will probably not like my answer: if you do not trust your fellow 
developers, do not use a shared repository.  Use clones (such as Linux' 
many different repositories on kernel.org) instead.

Ciao,
Dscho
