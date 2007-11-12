From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cogito remote branch
Date: Mon, 12 Nov 2007 09:55:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711120954460.4362@racer.site>
References: <Pine.LNX.4.64.0711111359590.9401@castor.milkiway.cos>
 <Pine.LNX.4.64.0711111520260.4362@racer.site> <1IrUDz-01jF4a0@fwd29.aul.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:56:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrW1d-0003U7-NJ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbXKLJz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756449AbXKLJz6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:55:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:45501 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755633AbXKLJz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:55:57 -0500
Received: (qmail invoked by alias); 12 Nov 2007 09:55:55 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp043) with SMTP; 12 Nov 2007 10:55:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HAwk+RpmH5yj0Q/hAfHKH6j8Em6/Q0DzMt1fl3i
	q9rz+1RBLFFyFr
X-X-Sender: gene099@racer.site
In-Reply-To: <1IrUDz-01jF4a0@fwd29.aul.t-online.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64587>

Hi,

On Mon, 12 Nov 2007, MichaelTiloDressel@t-online.de wrote:

> So just a line like
>              push = master

Exactly.

> A push is needed somewhere in order to prevent every remote to be pushed 
> by default, right?

You mean a "push" config variable?  No.  I think I mentioned in my first 
reply that

	git push <remote> <branch>...

works quite wonderfully.

Hth,
Dscho
