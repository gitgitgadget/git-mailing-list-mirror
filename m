From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Mon, 23 Jul 2007 00:50:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707230048570.14781@racer.site>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com> 
 <Pine.LNX.4.64.0707221959100.14781@racer.site> 
 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com> 
 <Pine.LNX.4.64.0707222013200.14781@racer.site> 
 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com> 
 <Pine.LNX.4.64.0707222238180.14781@racer.site>
 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IClCS-00022S-CB
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbXGVXux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXGVXuw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:50:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:44790 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765471AbXGVXuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:50:51 -0400
Received: (qmail invoked by alias); 22 Jul 2007 23:50:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 23 Jul 2007 01:50:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+txzgfzFOtX1ZNAYJCKcdXhzUl37uuCcp0OCRZHz
	CNSnDpF8Mr/RxP
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53371>

Hi,

On Sun, 22 Jul 2007, Jon Smirl wrote:

> On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > As you already did, this is my attempt at a perl script...  Feel free to
> > bash my Perl capabilities, or to correct it...
> 
> I don't really know Perl but Perl is probably a better language for
> this. I was doing it in C.

Yes, Perl is much much better for an application like this.  You do not 
have to cater for newbies, but can keep it to the technical level.

> This doesn't run on the two full kernel samples I sent you.

You mean my script?  Or your C program?

> That's the problem I was having, I can catch 95% of the expanded 
> keywords with my program but I have to touch up 5% by hand. I'll stare 
> at this and see if I can increase my understanding of Perl.

If it is my script, please tell me what is not working.  I'll fix it.  In 
the process, I could even add some comments...

Ciao,
Dscho
