From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Working on Git on MS Windows
Date: Tue, 4 Aug 2009 00:07:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908040005170.8306@pacific.mpi-cbg.de>
References: <d411cc4a0908030753r7bbe4038lf05c416530db46ed@mail.gmail.com> <m38wi0rine.fsf_-_@localhost.localdomain> <742707500908030906h12f29050hd792911e9c74e635@mail.gmail.com> <200908031828.42426.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-111941174-1249337222=:8306"
Cc: Thiago Farina <thiago.farina@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5g9-00059f-Mp
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 00:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbZHCWGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 18:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbZHCWGl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 18:06:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:56634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbZHCWGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 18:06:40 -0400
Received: (qmail invoked by alias); 03 Aug 2009 22:06:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 04 Aug 2009 00:06:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wbXxID+IwkVk8cX/slcWUtDu6WkdR3yIKJ0vS/C
	vUKfoFC4pYa9SX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200908031828.42426.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124727>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-111941174-1249337222=:8306
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 3 Aug 2009, Jakub Narebski wrote:

> On Mon, 3 Aug 2009, Thiago Farina wrote:
> > On Mon, Aug 3, 2009 at 1:02 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> >> Thiago Farina <thiago.farina@gmail.com> writes:
> >>>
> >>> I'm new to git, I already downloaded the msysgit. I'm working with 
> >>> git a couples weeks now. But I want to start debugging the git 
> >>> source code in Windows. How can I do that? Can I do that using 
> >>> Visual Studio, or there are other methods to debug git?
> >>
> >> Git uses GNU make as a build tool, so I am not sure if you can 
> >> develop Git with MS Visual Studio.  You should have GNU make 
> >> installed if you have chosen appropriate version of msysGit (the one 
> >> with developer tools).
> >
> > I can build the git with make which was installed by msysGit. But I 
> > want to debug, not only build.
> 
> I don't know if you can debug msysGit with MS Visual Studio.

I have no idea if that is possible, and I have no inclination to 
install/buy MS Visual Studio to find out.

However, I think I can assist anybody trying to do it.  You'll have to 
know how to operate Visual Studio, though, and come back with specific 
things that do not work.

> I think you should be able to, as msysGit is native Windows application. 
> But I do not program on MS Windows myself.
> 
> Perhaps this question should be better asked on msysGit Google Group?
> http://groups.google.com/group/msysgit

Almost definitely.

Ciao,
Dscho

--8323328-111941174-1249337222=:8306--
