From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-push: New long option --verbose
Date: Mon, 27 Aug 2007 14:48:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271447120.28586@racer.site>
References: <y7fxeal4.fsf@cante.net> <7vtzqll7hf.fsf@gitster.siamese.dyndns.org>
 <lkbxdrwg.fsf@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPevN-0001f9-JB
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 15:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbXH0Nqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 09:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbXH0Nqe
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 09:46:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:46935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750988AbXH0Nqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 09:46:34 -0400
Received: (qmail invoked by alias); 27 Aug 2007 13:46:32 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp017) with SMTP; 27 Aug 2007 15:46:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gWT0T92Lg6fX8OuNQXRMLwEvtgmiTNTlK3RIgZF
	UJGeTqWHvlCXRI
X-X-Sender: gene099@racer.site
In-Reply-To: <lkbxdrwg.fsf@cante.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56837>

Hi,

On Mon, 27 Aug 2007, Jari Aalto wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Why?
> 
> It complements the command set. -v was the only lonely that did not
> have long option choice.

Of course, the _proper_ solution would be to introduce a complete option 
parser component a la getopt.  For me, it is not _half_ as annoying that 
some short/long options are missing than being unable to abbreviate the 
short options into something like "-nls".

Ciao,
Dscho
