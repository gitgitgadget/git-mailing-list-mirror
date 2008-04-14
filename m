From: David Miller <davem@davemloft.net>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 15:01:05 -0700 (PDT)
Message-ID: <20080414.150105.101568769.davem@davemloft.net>
References: <20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: viro@ZenIV.linux.org.uk, akpm@linux-foundation.org, w@1wt.eu,
	david@lang.hm, sclark46@earthlink.net, johnpol@2ka.mipt.ru,
	rjw@sisk.pl, tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: jmorris@namei.org
X-From: netdev-owner@vger.kernel.org Tue Apr 15 00:02:03 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlWkS-0001FQ-H2
	for linux-netdev-2@gmane.org; Tue, 15 Apr 2008 00:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760839AbYDNWBI (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 18:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760400AbYDNWBH
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 18:01:07 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36103
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1760177AbYDNWBE (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 18:01:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id DF621C8D062;
	Mon, 14 Apr 2008 15:01:05 -0700 (PDT)
In-Reply-To: <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79536>

From: James Morris <jmorris@namei.org>
Date: Tue, 15 Apr 2008 01:54:00 +1000 (EST)

> - Things like "who made the kernel" statistics and related articles ignore 
>   code review.

Note the apparent irony in that the person who ends up often on the
top of those lists, Al Viro, is also someone who also does a
significant amount of code review.

I think this is no accident.
