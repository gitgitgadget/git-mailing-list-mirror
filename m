From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Thu, 1 Feb 2007 15:05:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702011503230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
 <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C14563.8060707@verizon.net> <Pine.LNX.4.63.0702011016430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <epsrj3$gh8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 15:05:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCcYp-00005v-RF
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 15:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbXBAOFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 09:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbXBAOFH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 09:05:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:43533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422901AbXBAOFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 09:05:06 -0500
Received: (qmail invoked by alias); 01 Feb 2007 14:05:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 01 Feb 2007 15:05:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <epsrj3$gh8$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38356>

Hi,

On Thu, 1 Feb 2007, Mark Levedahl wrote:

> "Johannes Schindelin" <Johannes.Schindelin@gmx.de> wrote in message 
> news:Pine.LNX.4.63.0702011016430.22628@wbgn013.biozentrum.uni-wuerzburg.de...
> >
> > And then I find that you also fixed whitespace breakage, which does not
> > belong in this patch.
>
> My editor simply will not write out trailing whitespace so I do not 
> notice when such breakage is fixed.

Fair enough.

> In the attached, I split out the four whitespace fixes in a separate 
> patch.
> 
> Mark 
> 
> 
> begin 666 0002-Make-gitk-work-reasonably-well-on-Cygwin.patch
> [lots of uuencoded lines]

;-)

Thanks a lot. It's way easier to review now, except for the lines 
beginning with "M" ;-)

Ciao,
Dscho
