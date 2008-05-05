From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/6] fn_out_diff_words_aux: Use short variable name
Date: Mon, 5 May 2008 13:05:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051305280.30431@racer>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>  <1209874815-14411-1-git-send-email-pkufranky@gmail.com>  <1209874815-14411-2-git-send-email-pkufranky@gmail.com>  <1209874815-14411-3-git-send-email-pkufranky@gmail.com> 
 <alpine.DEB.1.00.0805041047220.30431@racer> <46dff0320805040939t6290ed1dsad79d8de99c7cdde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 14:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JszSs-0000jb-J6
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 14:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbYEEMFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 08:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbYEEMFy
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 08:05:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:59105 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751554AbYEEMFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 08:05:54 -0400
Received: (qmail invoked by alias); 05 May 2008 12:05:52 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp020) with SMTP; 05 May 2008 14:05:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BTphYfxbBiturnakPBe0pS2min9P6U2BRTRWy/K
	cka43kYU48gL+g
X-X-Sender: gene099@racer
In-Reply-To: <46dff0320805040939t6290ed1dsad79d8de99c7cdde@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81272>

Hi,

On Mon, 5 May 2008, Ping Yin wrote:

> On Sun, May 4, 2008 at 5:47 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> >  the use of this patch evades me.  Care to defend why it is necessary?
> >  Preferably in the commit message?
> >
> 
> In fn_out_diff_words_aux, we use diff_words->plus in so many places.
> So just use shorter name to save typing and avoid typo.

Me, on the other hand, I find "diff_words->plus" so much better to read.

Ciao,
Dscho
