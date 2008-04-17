From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 21:09:33 +0200
Message-ID: <200804172109.35027.rjw@sisk.pl>
References: <47FEADCB.7070104@rtr.ca> <9a8748490804161417n4ad6c1den54ccd302831a66c6@mail.gmail.com> <48078323.4010109@davidnewall.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jesper Juhl <jesper.juhl@gmail.com>, sverre@rabbelier.nl,
	git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Tilman Schmidt <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	Mark Lord <lkml@rtr.ca>, David Miller <davem@davemloft.net>,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org
To: David Newall <davidn@davidnewall.com>
X-From: netdev-owner@vger.kernel.org Thu Apr 17 21:32:08 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmZUx-0002BD-Ph
	for linux-netdev-2@gmane.org; Thu, 17 Apr 2008 21:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbYDQTJ3 (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Thu, 17 Apr 2008 15:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbYDQTJ3
	(ORCPT <rfc822;netdev-outgoing>); Thu, 17 Apr 2008 15:09:29 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38531 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbYDQTJ2 (ORCPT <rfc822;netdev@vger.kernel.org>);
	Thu, 17 Apr 2008 15:09:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id 8C0D3A446E;
	Thu, 17 Apr 2008 20:20:10 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24000-03; Thu, 17 Apr 2008 20:20:01 +0200 (CEST)
Received: from [192.168.100.119] (nat-be3.aster.pl [212.76.37.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 0FED49BBA6;
	Thu, 17 Apr 2008 20:20:01 +0200 (CEST)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <48078323.4010109@davidnewall.com>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79811>

On Thursday, 17 of April 2008, David Newall wrote:
> Jesper Juhl wrote:
> > Interresting. Just be careful results are produced for the big picture
> > and not used to point fingers at individuals.
> >   
> 
> If there are individuals at whom a finger needs to be pointed, this
> system will highlight them, and fingers will (and should) be pointed. 
> Contributors of poor-quality code need to be weeded-out.

Define poor quality.
 
> Finger-pointing, in these extreme cases, gives incentive to improve
> quality.  It's a positive thing.

Sorry, but I have to disagree.  Negative finger-pointing is never a good thing.
Also, it doesn't give any incentive to anyone.  It only makes people feel bad
and finally discourages them from contributing anything.

If you want to give poeple incentives, reward them for doing things you'd like
them to do.

Thanks,
Rafael
