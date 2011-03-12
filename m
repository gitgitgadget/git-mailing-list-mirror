From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cross-compiling msys-1.0.dll, was Re: What's cooking in git.git
 (Feb 2011, #05; Wed, 23)
Date: Sat, 12 Mar 2011 16:38:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1103121610280.1561@bonsai2>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2>
 <20110225192455.GA7130@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de> <20110226110740.GA3096@tugrik.mns.mnsspb.ru> <20110226190741.GA24914@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102262056030.1561@bonsai2>
 <20110312131831.GB14621@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Sat Mar 12 16:38:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyQu4-00046V-1C
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 16:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab1CLPip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 10:38:45 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:60000 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752147Ab1CLPio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 10:38:44 -0500
Received: (qmail invoked by alias); 12 Mar 2011 15:38:42 -0000
Received: from pD9EB17A0.dip0.t-ipconnect.de (EHLO noname) [217.235.23.160]
  by mail.gmx.net (mp064) with SMTP; 12 Mar 2011 16:38:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wLrpRyeowNn0ysAVmu415NB24NEt79324BjQISZ
	rp8+uX0y7avYIc
X-X-Sender: gene099@bonsai2
In-Reply-To: <20110312131831.GB14621@tugrik.mns.mnsspb.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168945>

Hi,

On Sat, 12 Mar 2011, Kirill Smelkov wrote:

> On Sat, Feb 26, 2011 at 08:58:16PM +0100, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Sat, 26 Feb 2011, Kirill Smelkov wrote:
> > 
> > > On Sat, Feb 26, 2011 at 02:07:40PM +0300, Kirill Smelkov wrote:
> > > 
> > > > On Fri, Feb 25, 2011 at 10:54:40PM +0100, Johannes Schindelin wrote:
> > > > > > > And lastly, in [2] you claim that you cross-built msys-1.0.dll. 
> > > > > > > I would like to have a script doing that in msysgit.git.
> > > > > > 
> > > > > > This is in progress. Preliminary stuff (cross-built msys.dll no 
> > > > > > longer needs mingwm10.dll), is here:
> > > > > > 
> > > > > > http://repo.or.cz/w/msys/kirr.git/shortlog/refs/heads/x/kirr
> > > > > > http://repo.or.cz/w/msysgit/kirr.git/shortlog/refs/heads/ks/crossmsys
> > > > > 
> > > > > Thanks, I will try to find some time to test this next week.
> > > > 
> > > > Please don't - it does not build out of the box from msysgit yet. I 
> > > > just wanted to show it is not staying stale. When it is finished, I'll 
> > > > let you know.
> > > 
> > > Done. Please do
> > > 
> > >     git pull git://repo.or.cz/msysgit/kirr.git ks/crossmsys     # into msys
> > 
> > This is beautiful work. I will keep this as my candy tomorrow, because I 
> > still have to finish something else (after which I want to provide myself 
> > with some reward).
> 
> So how was it, tasteful? :)

Yep, but I got interrupted, and did not have time to come back yet. Please 
bear with me for a few more days!

Ciao,
Dscho
