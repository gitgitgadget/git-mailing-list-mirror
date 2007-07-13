From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git fetch inside a bare repo does nothing
Date: Fri, 13 Jul 2007 19:16:48 +0200
Message-ID: <20070713171648.GA6883@xp.machine.xx>
References: <20070713103303.GD18199@xp.machine.xx> <81b0412b0707130548s709709a2nf621b19d10e238a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 19:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9OlD-0001Px-7l
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 19:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbXGMRQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 13:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbXGMRQw
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 13:16:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:58365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751843AbXGMRQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 13:16:51 -0400
Received: (qmail invoked by alias); 13 Jul 2007 17:16:49 -0000
Received: from p54AABFCB.dip0.t-ipconnect.de (EHLO localhost) [84.170.191.203]
  by mail.gmx.net (mp042) with SMTP; 13 Jul 2007 19:16:49 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18Vyu5gFM4VHvDe1paoNyWZxC6+oPRuADpiXrothU
	oO4iKyXNOCliHV
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0707130548s709709a2nf621b19d10e238a0@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52401>

On Fri, Jul 13, 2007 at 02:48:19PM +0200, Alex Riesen wrote:
> On 7/13/07, Peter Baumann <waste.manager@gmx.de> wrote:
>> I suggested to use "git fetch --bare" inside the bare repo, but this
>
> "git --bare fetch".
>
> You swapped "fetch" and "--bare".

Sorry, this was only a typo in the mail.
But the problem got fixed, anyway.

-Peter
