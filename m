From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: hg2git error
Date: Sun, 24 May 2009 20:16:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905242013080.26154@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de> <fabb9a1e0905241038x7ea22622k930f50b9c7598c6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rocco Rutte <pdmef@gmx.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 20:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8IF7-0007Mq-8I
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 20:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbZEXSPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 14:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbZEXSPf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 14:15:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:33793 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753056AbZEXSPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 14:15:35 -0400
Received: (qmail invoked by alias); 24 May 2009 18:15:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 24 May 2009 20:15:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bp8A0kj4bBwZISoVzWN59xM8MR/JLf6k+BtmTk5
	9x/6TJUKc+1lu5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0905241038x7ea22622k930f50b9c7598c6e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119848>

Hi,

On Sun, 24 May 2009, Sverre Rabbelier wrote:

> On Sun, May 24, 2009 at 19:33, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > How to cope with that?
> 
> I've been working on making hg-git [0] usable as a two-way bridge
> (that is, use it to interact with a hg repository using git). It is
> coping just fine with unnamed heads so far :).
> 
> </shameless plug>

It says "Achtung! Alpha!".  How alpha is it?

Also, there is the issue that it is a Hg extension.  My experience with 
such extensions and their dependency on certain Hg versions make me ask: 
what version of Hg must I install before I can use Hg-git?

Ciao,
Dscho
