From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to
   UTF8
Date: Mon, 21 Jan 2008 19:14:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211913030.5731@racer.site>
References: <fn1nl6$ek5$1@ger.gmane.org> <alpine.LSU.1.00.0801211121440.5731@racer.site> <fn20ra$c4e$2@ger.gmane.org> <alpine.LSU.1.00.0801211209060.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:14:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH26X-00048n-Hx
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbYAUTOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbYAUTOO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:14:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:46925 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752806AbYAUTON (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 14:14:13 -0500
Received: (qmail invoked by alias); 21 Jan 2008 19:14:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 21 Jan 2008 20:14:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Of+Yo/lhO1/wajN+ywetoidFAOry9MH9pvCi8u8
	1P4Ir/uECequkI
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0801211209060.5731@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71313>

Hi,

On Mon, 21 Jan 2008, Johannes Schindelin wrote:

> On Mon, 21 Jan 2008, Mark Junker wrote:
> 
> > Johannes Schindelin schrieb:
> > 
> > > - it is too specific to the MacOSX filesystem issues (and better 
> > > alternatives have _already_ been proposed),
> > 
> > I know that there were proposed alternatives but I like to use git on 
> > MacOSX now and not in XY months.
> > 
> > > - it is a new feature and not a bug fix, very, _very_ late in the rc 
> > > cycle,
> > 
> > It was never meant for inclusion now. I know that this is post-1.5.4 
> > stuff.
> 
> In this case, I am going to work on my suggestion myself.
> 
> Now.

I retract that.  Although I put some work into it, I agree that it is post 
1.5.4.

Plus, I do not want anybody to think that shouting and being a PITA buys 
him anything.

Ciao,
Dscho
