From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 22:43:06 +0200
Message-ID: <7287AD62-3274-4B20-881C-D02E08C4B2EF@zib.de>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home> <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site> <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home> <4713C81F.A75FEFC2@dessent.net> <Pine.LNX.4.64.0710152117290.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Eli Zaretskii <eliz@gnu.org>,
	Andreas Ericsson <ae@op5.se>, tsuna@lrde.epita.fr,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:35:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhWl8-0004nw-En
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 22:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbXJOUlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 16:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbXJOUlm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 16:41:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:46334 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407AbXJOUll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 16:41:41 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9FKfb8i029077;
	Mon, 15 Oct 2007 22:41:37 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db10700.pool.einsundeins.de [77.177.7.0])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9FKfZSn013041
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 15 Oct 2007 22:41:36 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710152117290.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61043>


On Oct 15, 2007, at 10:19 PM, Johannes Schindelin wrote:

>>  I think you may be stuck on the shell though -- I don't know of any
>> ports of bash that aren't MSYS or Cygwin based.  However I do think
>> there's a native port of zsh out there by the GnuWin32 project, which
>> when renamed as just "/bin/sh" might be suitable, but only if these
>> scripts don't use bash-isms.  I have not tried this zsh myself and
>> speed/compatibility wise I'm not sure it's up to snuff.

I can't find zsh on the GnuWin32 project page.


> There is a port of BusyBox' dash, which is nearing completion.  Once
> Nguyen says it is ready enough, we will try to integrate it into  
> msysGit.

Gnuarch [1] recommends zsh from the unxutils project [2].

	Steffen

[1] http://www.gnuarch.org/gnuarchwiki/Native_WIN32_Support
[2] http://unxutils.sourceforge.net/
