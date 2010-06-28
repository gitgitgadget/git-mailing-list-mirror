From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Add known breakage for 'git notes copy'
Date: Tue, 29 Jun 2010 00:48:51 +0200
Message-ID: <201006290048.51490.johan@herland.net>
References: <41768aafce7a581e8b601e70826ce77381458a23.1277708369.git.bert.wesarg@googlemail.com>
 <20100628085907.GA14014@coredump.intra.peff.net>
 <AANLkTimap7ziJ-NuAV6h7bGP3cX2cDY7rqEbgJ2unQSP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 00:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTN8N-0003Y7-TI
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 00:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab0F1Wsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 18:48:55 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58379 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083Ab0F1Wsy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 18:48:54 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4Q0033FY1G6CB0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 29 Jun 2010 00:48:52 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 267501EA57AC_C2926D4B	for <git@vger.kernel.org>; Mon,
 28 Jun 2010 22:48:52 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E22221EA366F_C2926D3F	for <git@vger.kernel.org>; Mon,
 28 Jun 2010 22:48:51 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4Q00AW7Y1FU600@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 29 Jun 2010 00:48:51 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <AANLkTimap7ziJ-NuAV6h7bGP3cX2cDY7rqEbgJ2unQSP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149870>

On Monday 28 June 2010, Bert Wesarg wrote:
> On Mon, Jun 28, 2010 at 10:59, Jeff King <peff@peff.net> wrote:
> > On Mon, Jun 28, 2010 at 09:01:57AM +0200, Bert Wesarg wrote:
> >> 'git notes copy' dumps core when no arguments are given.
> > 
> > How about:
> Thanks.
> 
> Tested-by: Bert Wesarg <Bert.Wesarg@googlemail.com>
> 
> FWIW, here is the correct and updated test for this:

ACK on both patches.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
