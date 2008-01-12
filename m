From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config
 variable
Date: Sat, 12 Jan 2008 17:50:19 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801121748290.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:50:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDjZK-00046t-9F
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 17:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbYALQuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 11:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbYALQuW
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 11:50:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:54448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753060AbYALQuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 11:50:21 -0500
Received: (qmail invoked by alias); 12 Jan 2008 16:50:20 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp012) with SMTP; 12 Jan 2008 17:50:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LfWkiG4OL4aQNlN9VEHV869yJjerS/spisbVyh1
	v7LwZLuCBmrObj
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <478855B5.9070600@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70331>

Hi,

On Sat, 12 Jan 2008, Mark Levedahl wrote:

> The argument against my approach of explicitly naming the server rests 
> upon the premise that hiding a half-dozen servers, all different and 
> with those differences being important, under the single universal name 
> "origin", makes things easier.

No, that was not _at all_ my argument.

I said that hiding it under a different name _that you have to look up, 
too_ does _not_ make things easier.

I might even add that it makes misconfigurations even worse.

Ciao,
Dscho
