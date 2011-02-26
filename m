From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: cross-compiling msys-1.0.dll, was Re: What's cooking in git.git (Feb
 2011, #05; Wed, 23)
Date: Sat, 26 Feb 2011 20:58:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1102262056030.1561@bonsai2>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2>
 <20110225192455.GA7130@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de> <20110226110740.GA3096@tugrik.mns.mnsspb.ru> <20110226190741.GA24914@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Sat Feb 26 20:58:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtQHa-0002xk-G4
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 20:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab1BZT6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 14:58:21 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:37207 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752377Ab1BZT6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 14:58:20 -0500
Received: (qmail invoked by alias); 26 Feb 2011 19:58:18 -0000
Received: from pD9EB0CDB.dip0.t-ipconnect.de (EHLO noname) [217.235.12.219]
  by mail.gmx.net (mp023) with SMTP; 26 Feb 2011 20:58:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+J6N8UgdaJXMlHPt2Y2yiH9OPYegefv7qy2whHQc
	NHdvSkpGdTVSIk
X-X-Sender: gene099@bonsai2
In-Reply-To: <20110226190741.GA24914@tugrik.mns.mnsspb.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167991>

Hi,

On Sat, 26 Feb 2011, Kirill Smelkov wrote:

> On Sat, Feb 26, 2011 at 02:07:40PM +0300, Kirill Smelkov wrote:
> 
> > On Fri, Feb 25, 2011 at 10:54:40PM +0100, Johannes Schindelin wrote:
> > > > > And lastly, in [2] you claim that you cross-built msys-1.0.dll. 
> > > > > I would like to have a script doing that in msysgit.git.
> > > > 
> > > > This is in progress. Preliminary stuff (cross-built msys.dll no 
> > > > longer needs mingwm10.dll), is here:
> > > > 
> > > > http://repo.or.cz/w/msys/kirr.git/shortlog/refs/heads/x/kirr
> > > > http://repo.or.cz/w/msysgit/kirr.git/shortlog/refs/heads/ks/crossmsys
> > > 
> > > Thanks, I will try to find some time to test this next week.
> > 
> > Please don't - it does not build out of the box from msysgit yet. I 
> > just wanted to show it is not staying stale. When it is finished, I'll 
> > let you know.
> 
> Done. Please do
> 
>     git pull git://repo.or.cz/msysgit/kirr.git ks/crossmsys     # into msys

This is beautiful work. I will keep this as my candy tomorrow, because I 
still have to finish something else (after which I want to provide myself 
with some reward).

Ciao,
Dscho
