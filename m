From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 10:35:21 -0700
Message-ID: <1208194521.25663.12.camel@work.sfbay.sun.com>
References: <20080414010412.c42dc560.akpm@linux-foundation.org>
 <20080414.013058.149905948.davem@davemloft.net>
 <20080414031530.2507660d.akpm@linux-foundation.org>
 <20080414.034116.24468363.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: akpm@linux-foundation.org, viro@ZenIV.linux.org.uk, w@1wt.eu,
	david@lang.hm, sclark46@earthlink.net, johnpol@2ka.mipt.ru,
	rjw@sisk.pl, tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Mon Apr 14 20:39:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlTVx-0006IT-GX
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 20:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763040AbYDNScO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 14:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762209AbYDNScN
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 14:32:13 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:55921 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761729AbYDNScL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 14:32:11 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3EIW7Wi001658;
	Mon, 14 Apr 2008 11:32:07 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZB00201V94P400@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 ; Mon, 14 Apr 2008 11:32:07 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JZB00JALVH81O70@fe-sfbay-09.sun.com>; Mon,
 14 Apr 2008 11:31:56 -0700 (PDT)
In-reply-to: <20080414.034116.24468363.davem@davemloft.net>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79525>

On Mon, 2008-04-14 at 03:41 -0700, David Miller wrote:
> I'm getting more and more sensitive to issues on this level over time,
> because I realize that the fundamental issue in all human group issues
> is getting people to "want" to do things.  And "force", in any form,
> tends to be incompatible with "want".  And in particular, people will
> often even shun things they "want" when it is "forced" to them.

Just wanted to add my 2c by mentioning my favorite example of 
"virtual Tom Sawyering" as far as a tedious review process goes:
   http://en.wikipedia.org/wiki/Knuth_reward_check

Which is also quite cheap too -- AFAIK very few of those have ever
been cashed.

Thanks,
Roman.
