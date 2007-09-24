From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-send-email is omitting author and date lines
Date: Mon, 24 Sep 2007 12:10:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709241209470.28395@racer.site>
References: <1190585633.29937.44.camel@localhost> <7v4phlc668.fsf@gitster.siamese.dyndns.org>
 <20070924110817.GA15797@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Hanspeter Kunz <hp@edelkunz.ch>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 13:11:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZlqc-0004xC-S4
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 13:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843AbXIXLLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 07:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755703AbXIXLLZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 07:11:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:41198 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755193AbXIXLLY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 07:11:24 -0400
Received: (qmail invoked by alias); 24 Sep 2007 11:11:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 24 Sep 2007 13:11:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dSeclgRYdhShRN3cQJZhiWUDBpX/N3+CO2hEO6A
	L09/UAb/RVdvPu
X-X-Sender: gene099@racer.site
In-Reply-To: <20070924110817.GA15797@lapse.madduck.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59039>

Hi,

On Mon, 24 Sep 2007, martin f krafft wrote:

> But information *does* get lost, namely the date. If I send a patch
> by email and it gets merged by the recipient, the date of the commit
> will be the date of the email, not the date of original commit, or
> when it was merged.

And that is perfectly okay, since as far as the public is concerned, this 
is the date of the patch.

Ciao,
Dscho
