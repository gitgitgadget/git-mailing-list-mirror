From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git
 repository
Date: Fri, 11 Jul 2008 22:55:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112252250.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com> <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com> <alpine.DEB.1.00.0807112215050.8950@racer> <alpine.DEB.1.00.0807112238350.8950@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:56:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQbY-00028E-56
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369AbYGKVzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbYGKVzm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:55:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:54307 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754246AbYGKVzm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:55:42 -0400
Received: (qmail invoked by alias); 11 Jul 2008 21:55:40 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp005) with SMTP; 11 Jul 2008 23:55:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/07l0Ka6H0zqxdeFG0eDbHqKWbJtPFkSNeEglDRw
	8q7Kbx5uyygamp
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807112238350.8950@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88184>

Hi,

On Fri, 11 Jul 2008, Johannes Schindelin wrote:

> something else I just realized: you might want to use .mailmap, e.g. to 
> coalesce the changes of Shawn "O." Pearce correctly.

Yet another thing: while it is true that git-gui is usually pulled in 
(with the subtree strategy), some parts were changed in git.git directly, 
so you will need to cope with the wholesale rename with every merge.

Besides, it is slightly distracting to see the file names differently from 
what they are in HEAD^{tree}.  But that may be just me.

Ciao,
Dscho
