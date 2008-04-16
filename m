From: Adrian Bunk <bunk@kernel.org>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 23:53:33 +0300
Message-ID: <20080416205333.GT1677@cs181133002.pp.htv.fi>
References: <20080414043939.GA6862@1wt.eu> <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au> <4804765B.2070300@davidnewall.com> <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com> <20080416132634.GA545@cs181133002.pp.htv.fi> <bd6139dc0804161239h17e79c70ta5e938619e5743c9@mail.gmail.com> <20080416201606.GS1677@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	David Newall <davidn@davidnewall.com>
To: sverre@rabbelier.nl
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932437AbYDPUyB@vger.kernel.org Wed Apr 16 23:04:05 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932437AbYDPUyB@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmEeV-00088b-A5
	for glk-linux-kernel-3@gmane.org; Wed, 16 Apr 2008 22:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbYDPUyB (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 16 Apr 2008 16:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756531AbYDPUxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2008 16:53:41 -0400
Received: from smtp4.pp.htv.fi ([213.243.153.38]:35216 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbYDPUxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2008 16:53:39 -0400
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 6D2E85BC044;
	Wed, 16 Apr 2008 23:53:38 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080416201606.GS1677@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79748>

On Wed, Apr 16, 2008 at 11:16:06PM +0300, Adrian Bunk wrote:
>...
> E.g. I am proud that my commits do virtually never introduce bugs, so 
> any results someone publishes about what I do should better be right
> or my first thoughts are somewhere between "fist" and "lawyer". [1]
>...

To avoid any misunderstandings:

This is not in any way meant against you personally.

But saying things like " X% of your commits introduced bugs" is not a
friendly thing, and wrong data could be quite hurting.

Especially in the open source world where much motivation comes from
people being proud of their work.

Even correct data can do harm.

And bad data can have really bad effects.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
