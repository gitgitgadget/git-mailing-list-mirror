From: David Newall <davidn@davidnewall.com>
Subject: Re: Reporting bugs and bisection
Date: Fri, 18 Apr 2008 02:34:35 +0930
Message-ID: <48078323.4010109@davidnewall.com>
References: <47FEADCB.7070104@rtr.ca> <48028830.6020703@earthlink.net>	 <alpine.DEB.1.10.0804131546370.9318@asgard>	 <20080414043939.GA6862@1wt.eu>	 <20080414053943.GU9785@ZenIV.linux.org.uk>	 <20080413232441.e216a02c.akpm@linux-foundation.org>	 <20080414072328.GW9785@ZenIV.linux.org.uk>	 <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>	 <4804765B.2070300@davidnewall.com>	 <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com> <9a8748490804161417n4ad6c1den54ccd302831a66c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, git@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, yoshfuji@linux-ipv6.org,
	jeff@garzik.org, netdev@vger.kernel.org
To: Jesper Juhl <jesper.juhl@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934897AbYDQRE7@vger.kernel.org Thu Apr 17 19:21:01 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934897AbYDQRE7@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmXYd-0006bw-IO
	for glk-linux-kernel-3@gmane.org; Thu, 17 Apr 2008 19:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934897AbYDQRE7 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 17 Apr 2008 13:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933720AbYDQREd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2008 13:04:33 -0400
Received: from eth7959.sa.adsl.internode.on.net ([150.101.82.22]:33522 "EHLO
	hawking.rebel.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933614AbYDQREb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2008 13:04:31 -0400
Received: from [192.168.0.9] (ppp121-45-41-178.lns10.adl2.internode.on.net [::ffff:121.45.41.178])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by hawking.rebel.net.au with esmtp; Fri, 18 Apr 2008 02:34:27 +0930
  id 0039448E.4807831C.000063E3
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <9a8748490804161417n4ad6c1den54ccd302831a66c6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79804>

Jesper Juhl wrote:
> Interresting. Just be careful results are produced for the big picture
> and not used to point fingers at individuals.
>   

If there are individuals at whom a finger needs to be pointed, this
system will highlight them, and fingers will (and should) be pointed. 
Contributors of poor-quality code need to be weeded-out. 
Finger-pointing, in these extreme cases, gives incentive to improve
quality.  It's a positive thing.
