From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: suppress warnings
Date: Tue, 25 Jul 2006 13:56:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607251355360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <44C5FB3E.9020301@catalyst.net.nz>  <Pine.LNX.4.63.0607251308380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90607250450l643f97e4sbece300fa5b2d509@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 13:57:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5LWq-0000m0-8J
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 13:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWGYL4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 07:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWGYL4o
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 07:56:44 -0400
Received: from mail.gmx.de ([213.165.64.21]:50583 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932340AbWGYL4o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 07:56:44 -0400
Received: (qmail invoked by alias); 25 Jul 2006 11:56:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 25 Jul 2006 13:56:42 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90607250450l643f97e4sbece300fa5b2d509@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24169>

Hi,

On Tue, 25 Jul 2006, Martin Langhoff wrote:

> On 7/25/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > > Ack to that too. Perhaps an END block would help?
> > 
> > Since my BASIC days on a VC-20 (no, not the airplane), I hardly used an
> > END statement ;-) Well, maybe in that Pascal course, but not in Perl,
> > anyway. So, I do not understand...
> 
> Oh, it's a code block you can declare that gets called when the
> program is exiting. More info at
> http://search.cpan.org/dist/perl/pod/perlmod.pod#BEGIN%2C_CHECK%2C_INIT_and_END____

Ah! Something like "atexit()".

> No relation to BASIC's END ;-)

;-)

BTW I will send out a proper patch for that warning shortly.

Ciao,
Dscho
