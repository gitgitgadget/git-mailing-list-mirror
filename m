From: David Newall <davidn@davidnewall.com>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 18:36:33 +0930
Message-ID: <4805C199.2090702@davidnewall.com>
References: <47FEADCB.7070104@rtr.ca> <517f3f820804150254w491cdf85s28f1d15696db8d96@mail.gmail.com> <4804B5D5.4090404@davidnewall.com> <200804152251.51308.rjw@sisk.pl> <480565D3.6000100@davidnewall.com> <alpine.DEB.1.10.0804152042320.15483@asgard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Tilman Schmidt <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	Mark Lord <lkml@rtr.ca>, David Miller <davem@davemloft.net>,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Apr 16 11:08:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm3cR-0005lC-Cw
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 11:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbYDPJGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 05:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbYDPJGj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 05:06:39 -0400
Received: from eth7959.sa.adsl.internode.on.net ([150.101.82.22]:33289 "EHLO
	hawking.rebel.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754336AbYDPJGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 05:06:37 -0400
Received: from [192.168.0.9] (ppp121-45-78-167.lns10.adl6.internode.on.net [::ffff:121.45.78.167])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by hawking.rebel.net.au with esmtp; Wed, 16 Apr 2008 18:36:33 +0930
  id 00394473.4805C199.000054D2
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <alpine.DEB.1.10.0804152042320.15483@asgard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79687>

david@lang.hm wrote:
> I'd rather have a developer/maintainer who introduces and fixed 100
> bug, but fixes them promptly,

And I'd rather be able to see that that person introduced 100 bugs than
to have no idea.  As has been said before, the current situation rewards
people for sloppy work.
