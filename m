From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use "" instead of "<unknown>" for placeholders
Date: Tue, 25 Sep 2007 13:46:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251345490.28395@racer.site>
References: <20070921101420.GD22869@mageo.cz> <Pine.LNX.4.64.0709211146090.28395@racer.site>
 <20070921110646.GA9072@mageo.cz> <Pine.LNX.4.64.0709211207070.28395@racer.site>
 <20070921140500.GB9072@mageo.cz> <7vk5qjixqy.fsf@gitster.siamese.dyndns.org>
 <46F4D815.5050602@mageo.cz> <20070925094320.GN22869@mageo.cz>
 <Pine.LNX.4.64.0709251120120.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Tue Sep 25 14:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia9pW-00055s-0g
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 14:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbXIYMrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 08:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXIYMrw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 08:47:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:38577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750734AbXIYMrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 08:47:51 -0400
Received: (qmail invoked by alias); 25 Sep 2007 12:47:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 25 Sep 2007 14:47:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188/IIlTUI8ZHV9DeDNA96IRUVyWFOJr2TMQNlwde
	RHeTaeqzwiM6kh
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709251120120.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59118>

Hi,

On Tue, 25 Sep 2007, Johannes Schindelin wrote:

> On Tue, 25 Sep 2007, Michal Vitecek wrote:
> 
> > [lots of quoted mails]
> > 
> >  Here comes the patch. I hope it will be ok this time :) Thanks.
> > 
> >  Don't use "<unknown>" for unknown values of placeholders and suppress
> >  printing of empty user formats.
> > 
> > ---
> 
> Please move the discussion which should not be in the commit message 
> _after_ the "---".

What about this comment?

Ciao,
Dscho
