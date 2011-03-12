From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: cross-compiling msys-1.0.dll, was Re: What's cooking in
	git.git (Feb 2011, #05; Wed, 23)
Date: Sat, 12 Mar 2011 16:18:31 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20110312131831.GB14621@tugrik.mns.mnsspb.ru>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2> <20110225192455.GA7130@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de> <20110226110740.GA3096@tugrik.mns.mnsspb.ru> <20110226190741.GA24914@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102262056030.1561@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 12 14:18:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyOhw-0007I7-0j
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 14:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab1CLNSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 08:18:07 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:46646 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab1CLNSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 08:18:06 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1PyOhq-0000lE-8C; Sat, 12 Mar 2011 16:18:06 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1PyOiF-0003qL-N0; Sat, 12 Mar 2011 16:18:31 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1102262056030.1561@bonsai2>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168943>

On Sat, Feb 26, 2011 at 08:58:16PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 26 Feb 2011, Kirill Smelkov wrote:
> 
> > On Sat, Feb 26, 2011 at 02:07:40PM +0300, Kirill Smelkov wrote:
> > 
> > > On Fri, Feb 25, 2011 at 10:54:40PM +0100, Johannes Schindelin wrote:
> > > > > > And lastly, in [2] you claim that you cross-built msys-1.0.dll. 
> > > > > > I would like to have a script doing that in msysgit.git.
> > > > > 
> > > > > This is in progress. Preliminary stuff (cross-built msys.dll no 
> > > > > longer needs mingwm10.dll), is here:
> > > > > 
> > > > > http://repo.or.cz/w/msys/kirr.git/shortlog/refs/heads/x/kirr
> > > > > http://repo.or.cz/w/msysgit/kirr.git/shortlog/refs/heads/ks/crossmsys
> > > > 
> > > > Thanks, I will try to find some time to test this next week.
> > > 
> > > Please don't - it does not build out of the box from msysgit yet. I 
> > > just wanted to show it is not staying stale. When it is finished, I'll 
> > > let you know.
> > 
> > Done. Please do
> > 
> >     git pull git://repo.or.cz/msysgit/kirr.git ks/crossmsys     # into msys
> 
> This is beautiful work. I will keep this as my candy tomorrow, because I 
> still have to finish something else (after which I want to provide myself 
> with some reward).

So how was it, tasteful? :)

Thanks,
Kirill
