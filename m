From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-push: New long option --verbose
Date: Mon, 27 Aug 2007 14:45:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271443300.28586@racer.site>
References: <y7fxeal4.fsf@cante.net> <Pine.LNX.4.64.0708270940130.28586@racer.site>
 <ps19drzl.fsf@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:43:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPesS-0000TV-T8
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 15:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbXH0Nne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 09:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbXH0Nne
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 09:43:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:55613 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753519AbXH0Nnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 09:43:33 -0400
Received: (qmail invoked by alias); 27 Aug 2007 13:43:30 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp048) with SMTP; 27 Aug 2007 15:43:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1988H5jSTp8kOD4M6oDcXe6K3Tjh6rFTE7lOoD3St
	ZJbSaCG31BOonV
X-X-Sender: gene099@racer.site
In-Reply-To: <ps19drzl.fsf@cante.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56836>

Hi,

[please, if you reply to my message, do not kill me from the address list]

On Mon, 27 Aug 2007, Jari Aalto wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 27 Aug 2007, Jari Aalto wrote:
> >
> >> Implemented and documented new option.
> >
> > It is not "new".  It is just a long form for the already existing "-v".
> 
> Perception is in the eye. "new long option"
>                                ===========

More appropriate: "Add long option --verbose".

Even as a long option, it is not new.  There have been plenty "--verbose"s 
in git before.

It might appear to you as a minor nit, but reading commit logs it is 
pretty disruptive to read about the "new" option and wondering "why the 
heck was it not there before?  Ah, it was.  The committer just added the 
long version of the option".

Ciao,
Dscho
