From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: Importing svn branch
Date: Thu, 01 Nov 2007 23:39:43 +0100
Message-ID: <472A55AF.6010801@gmx.net>
References: <4729F58C.3090706@gmx.net> <BAYC1-PASMTP1474D8094F6C5F2CCF2B6CAE8C0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:40:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inihk-0003aD-LS
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbXKAWjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbXKAWjq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:39:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:59013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753290AbXKAWjq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:39:46 -0400
Received: (qmail invoked by alias); 01 Nov 2007 22:39:44 -0000
Received: from p5B0C7CBF.dip.t-dialin.net (EHLO [192.168.13.20]) [91.12.124.191]
  by mail.gmx.net (mp052) with SMTP; 01 Nov 2007 23:39:44 +0100
X-Authenticated: #9354587
X-Provags-ID: V01U2FsdGVkX1/PlSQUT/3P5ZU98adKvsXCuWMv/YEkWSILbqjEUE
	k7xzcOomZjaZf2
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <BAYC1-PASMTP1474D8094F6C5F2CCF2B6CAE8C0@CEZ.ICE>
X-Enigmail-Version: 0.95.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63027>

Sean wrote:
> git-svnimport should probably be officially deprecated; you're not the
> first person to struggle with it.  Fortunately there's another option
> provided with Git which will likely give you what you're looking for:
> 
>    git svn clone http://svn.gnome.org/svn/banshee/branches/banshee/stable
Okay, I tried git-svn after I was stuck with svnimport. Although I still
couldn't figure out how to clone a single branch (due to some confusing
complaints) I just cloned the whole repro, which was working fine.
Thanks.
