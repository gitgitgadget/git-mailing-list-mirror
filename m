From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Don't want to leave git for hg
Date: Wed, 18 Feb 2009 11:28:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181126210.6274@intel-tinevez-2-302>
References: <m27i3ou7fy.fsf@gmail.com>  <alpine.DEB.1.00.0902180030500.10279@pacific.mpi-cbg.de> <38b2ab8a0902180039n5080e55t809c1f6ff13cef71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 11:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZjh4-0007Rk-GX
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 11:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbZBRK2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 05:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZBRK2u
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 05:28:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:33512 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751543AbZBRK2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 05:28:49 -0500
Received: (qmail invoked by alias); 18 Feb 2009 10:28:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp056) with SMTP; 18 Feb 2009 11:28:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6k5lfilO6c7IEVDBK3fDIg4QiniK50snk457Ou7
	sgA/g/axuLtL7O
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <38b2ab8a0902180039n5080e55t809c1f6ff13cef71@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110524>

Hi,

On Wed, 18 Feb 2009, Francis Moreau wrote:

> On Wed, Feb 18, 2009 at 12:34 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 17 Feb 2009, Francis Moreau wrote:
> >
> >> I found hg2git which could have solve my issue but it seems pretty old
> >> and no more maintained.
> >
> > You did not say from where you have it, so I would never know if you mean
> > the same as I do.
> 
> I used the version hosted by github somehow:
> 
> git://github.com/vitaly/hg2git.git
> 
> > I use the hg2git from http://repo.or.cz/w/fast-export.git and it works
> > pretty well, most of the time.
> 
> Ok I missed this one.
> 
> Since you may have the same needs as mine, I'm asking another
> question: once you have finished your work in your git repo, how do
> you reintegrate them into the hg repo ? do you use patches or
> something else ?

Ah, I do not need to do that...  But yes, I would use patches (there must 
be a git-am lookalike in Hg).  Or maybe their fast-import equivalent I 
heard rumors of.

Ciao,
Dscho
