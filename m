From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Sat, 20 Dec 2008 14:18:38 +0100
Message-ID: <200812201418.38707.markus.heidelberg@web.de>
References: <200812191314.19302.markus.heidelberg@web.de> <7v3agj1gvp.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 14:20:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE1kL-00035Y-Iw
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 14:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYLTNSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 08:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYLTNSj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 08:18:39 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:57476 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYLTNSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 08:18:38 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4BEE6F7EBA13;
	Sat, 20 Dec 2008 14:18:37 +0100 (CET)
Received: from [91.19.0.168] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LE1j2-0001xv-00; Sat, 20 Dec 2008 14:18:36 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7v3agj1gvp.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18Ctf6eM/aMh9vdzoAQM9Kmsm5X1eZVeiohMVQX
	TmRqH9pTWm8G6hmilkOWHHg4VV11C+ZYKISo1Q4PKD+VzIv782
	fBQ7WnH3iVsHoqBUmS1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103648>

Junio C Hamano, 20.12.2008:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > @@ -172,7 +172,7 @@ only the primary branches.  In addition, if you happen to be on
> >  your topic branch, it is shown as well.
> >  
> >  ------------
> > -$ git show-branch --reflog='10,1 hour ago' --list master
> > +$ git show-branch --reflog="10,1 hour ago" --list master
> >  ------------
> 
> Is this just a personal taste, or a correction to typography?

When using single quotes, the manpage displayed backticks. I don't know
how to obtain single quotes in the manpage, if this is preferred. The
HTML page worked though: single quotes were translated to single quotes,
double quotes to double quotes.

> Other than this one, I did not find anything else in your patch that
> looked iffy.  Thanks for lending a good set of eyeballs.

Thanks, this happens when reading a lot of documentation :)
