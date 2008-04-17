From: Adrian Bunk <bunk@kernel.org>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 18:26:33 +0300
Message-ID: <20080417152633.GA12951@cs181133002.pp.htv.fi>
References: <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au> <4804765B.2070300@davidnewall.com> <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com> <20080416132634.GA545@cs181133002.pp.htv.fi> <20080416120247.c665859c.akpm@linux-foundation.org> <20080416195503.GR1677@cs181133002.pp.htv.fi> <20080417135013.GA2017@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Morton <akpm@linux-foundation.org>, sverre@rabbelier.nl,
	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	jmorris@namei.org, viro@zeniv.linux.org.uk, w@1wt.eu,
	david@lang.hm, sclark46@earthlink.net, johnpol@2ka.mipt.ru,
	rjw@sisk.pl, tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	davem@davemloft.net, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	davidn@davidnewall.com
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 17:45:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmW1R-0005hy-8Y
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 17:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762619AbYDQP0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 11:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761018AbYDQP0p
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 11:26:45 -0400
Received: from smtp4.pp.htv.fi ([213.243.153.38]:37276 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760255AbYDQP0o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 11:26:44 -0400
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id B075F5BC05F;
	Thu, 17 Apr 2008 18:26:42 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080417135013.GA2017@fieldses.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79795>

On Thu, Apr 17, 2008 at 09:50:13AM -0400, J. Bruce Fields wrote:
> On Wed, Apr 16, 2008 at 10:55:03PM +0300, Adrian Bunk wrote:
>...
> > Sure, you will get some numbers, but if anyone would e.g. wrongly accuse 
> > me that 2% of my commits last year introduced bugs I would get 
> > ***really*** angry.
> 
> It's just an experiment; reasonable people won't take it as the final
> word.

Take e.g. [1] as an example how git statistics about the Linux kernel 
are already used to "prove" things that aren't true.

> --b.

cu
Adrian

[1] http://digitalvampire.org/blog/index.php/2008/04/11/lies-d-oh-forget-it/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
