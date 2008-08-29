From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Fri, 29 Aug 2008 11:33:58 +0200
Message-ID: <06844986-44BF-4B82-A45F-0781B3513409@wincent.com>
References: <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Perry Wagle <wagle@cs.indiana.edu>,
	Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:37:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ0QM-0003lC-Sy
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbYH2Jgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2008 05:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYH2Jgk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:36:40 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:53030 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbYH2Jgk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2008 05:36:40 -0400
Received: from cuzco.lan (98.pool85-53-1.dynamic.orange.es [85.53.1.98])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m7T9XxHr005283
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 29 Aug 2008 05:34:01 -0400
In-Reply-To: <20080828212346.GA27867@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El 28/8/2008, a las 23:23, Jeff King escribi=F3:

> I don't think Junio is declaring success. In fact, I think he has sen=
t
> several messages saying (paraphrasing of course):
>
>  - this was obviously not done in the best manner possible, because o=
f
>    the number of people complaining

One thing we mustn't lose sight of is that the number of people =20
complaining is that it is utterly insignificant compared to the =20
seething hordes that have complained about the number of git- commands =
=20
in /usr/bin over the years. We're talking about a dozen or so compared =
=20
to hundreds. And the change is likely to save us from hundreds more in =
=20
the future.

Cheers,
Wincent
