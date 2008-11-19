From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 02:39:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811190238360.30769@pacific.mpi-cbg.de>
References: <20081118211237.234d8035@crow> <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow> <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de> <87tza41pf4.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Burton <markb@ordern.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:32:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2bw1-0003QU-JS
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbYKSBbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYKSBbe
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:31:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:34752 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751271AbYKSBbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 20:31:33 -0500
Received: (qmail invoked by alias); 19 Nov 2008 01:31:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 19 Nov 2008 02:31:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bmCUxLknb1OBExpWEJD9WT+Fnrmtr7Le/D05Mu1
	ET+XFdt/aGx412
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87tza41pf4.fsf@catnip.gol.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101300>

Hi,

On Wed, 19 Nov 2008, Miles Bader wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > It may be a traditional wart, but a helpful one.  Remember, you can 
> > also say:
> >
> > 	git commit that/directory/
> >
> > I do _not_ want Git to add all untracked (and unignored) files in that 
> > directory automatically.
> 
> I agree, but it would kinda handy to have an exception for files 
> explicitly named on the command line.

Only if you do not have a clear picture of what the staging area is about, 
IMHO.

Ciao,
Dscho
