From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Mon, 6 Aug 2007 17:56:22 +0200
Message-ID: <20070806155622.GA21448@moooo.ath.cx>
References: <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708031121000.14781@racer.site> <7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 17:56:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II4wZ-0003Mc-10
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 17:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXHFP40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 11:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbXHFP40
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 11:56:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:52780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751209AbXHFP4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 11:56:25 -0400
Received: (qmail invoked by alias); 06 Aug 2007 15:56:23 -0000
Received: from pD9EBB594.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.148]
  by mail.gmx.net (mp055) with SMTP; 06 Aug 2007 17:56:23 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+NBtAx8lWNQs1zTRm8frEPA7w//oc7ODo3lNyH/5
	/ld1cvQBgVcTyC
Content-Disposition: inline
In-Reply-To: <7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55155>

Junio C Hamano <gitster@pobox.com> wrote:
> In any case, enough discussion.  Here is an updated patch, which
> I _could_ be pursuaded to consider for inclusion after v1.5.3
> happens, if there are enough agreements and Acks.

I like this new behaviour but I don't see the old one too often
either.
