From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: BUG: "git stash apply <arg>" broken, "git-stash apply <arg>"
 works
Date: Thu, 5 Jun 2008 01:13:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050112550.21190@racer>
References: <279b37b20806041646jc29a695w685c3e01efc0dd0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, nanako3@bluebottle.com, gitster@pobox.com
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 02:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K439H-00045l-Bq
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 02:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbYFEAPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 20:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbYFEAPS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 20:15:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:35433 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752611AbYFEAPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 20:15:17 -0400
Received: (qmail invoked by alias); 05 Jun 2008 00:15:14 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 05 Jun 2008 02:15:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wdR1umVxwgWJmTKirNHHnmybaMP9nQ0hZfyyYbj
	arPmm8Co3Pvb9f
X-X-Sender: gene099@racer
In-Reply-To: <279b37b20806041646jc29a695w685c3e01efc0dd0b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83841>

Hi,

On Wed, 4 Jun 2008, Eric Raible wrote:

> Synopsis:
> "git stash apply stash@{1}" doesn't work, but
> "git-stash apply stash@{1}" does.
> 
> Platform:
> win xp (yeah, I know, I know)
> msys (Git-1.5.5-preview20080413.exe)

This is most likely an issue with MSys, not Git.  As far as I know, 
Steffen started to have a look at it, but I do not really know: I took my 
retreat from msysGit.

Ciao,
Dscho
