From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 15:15:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231514080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at> 
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com> 
 <200701222127.09601.johannes.sixt@telecom.at> 
 <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0701230536p536f3326w36f2b272c869c5cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 15:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9MR3-0007Oh-Ji
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 15:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbXAWOPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 09:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932899AbXAWOPb
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 09:15:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:46791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932920AbXAWOPa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 09:15:30 -0500
Received: (qmail invoked by alias); 23 Jan 2007 14:15:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 23 Jan 2007 15:15:29 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0701230536p536f3326w36f2b272c869c5cf@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37520>

Hi,

On Tue, 23 Jan 2007, Nguyen Thai Ngoc Duy wrote:

> On 1/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On the third hand, I fully expect git on Windows to be used only by GUI
> > wieners who cannot handle the command line, let alone a pager! ("WTF! How
> > do I go back to that dollar thingie? You know, where I type git-blabla?")
> 
> If I have to use git on Windows (very likely now that this port seems
> to work), I'd much prefer command line interface. cmd.exe may be not
> good enough so I think we should include bash in git-win32 package.
> Many git commands are still bash scripts and new commands are often
> coded as bash scripts. So we need bash in Windows anyway unless
> Windows Git users accept a limited git version. (no-perl git is
> acceptable to me).

Actually, you cannot work _at all_ with git when you don't have a proper 
shell.

Ciao,
Dscho
