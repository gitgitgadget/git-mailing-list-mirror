From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: history damage in linux.git
Date: Fri, 22 Apr 2016 15:38:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604221538060.6812@virtualbox>
References: <20160421113004.GA3140@aepfle.de> <87lh473xic.fsf@linux-m68k.org> <CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com> <xmqqzismsxsu.fsf@gitster.mtv.corp.google.com> <20160421170815.GA10783@sigill.intra.peff.net>
 <CA+55aFyadCxX_Ws5fUC0QXwYYyaAjC5TC=y+tVA+YUHX1o+-iQ@mail.gmail.com> <20160421180507.GA12950@sigill.intra.peff.net> <CA+55aFzEVy6BsVzTrYda3Nfo4o+QtqiqsX5xJqRt=se0eREDsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 15:39:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atbIj-0005i1-MA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbcDVNjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 09:39:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:60221 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbcDVNjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:39:12 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MIuSH-1arfLq0dh3-002VAz; Fri, 22 Apr 2016 15:38:55
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CA+55aFzEVy6BsVzTrYda3Nfo4o+QtqiqsX5xJqRt=se0eREDsA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:dtapRAdJKB77zlj8NyRXZ2mGMAJ7zbxlnPS9vzqkDkkzY1+uvKf
 3llx+E1O0XFIlx1uqHjYglvpQ5MDnhoUvg/8F28ECQk6DJw7xFg/adAP+A+DM5O+c1tSHz+
 v8aWm1MRXIjqp27w+THZlASbIuEB9dW1e80FQB4+LlsXUNhIoZRYb9LZO3nQCJb1wsBMxTu
 AH3OZrC7p19GcpaPcx/9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HkhdaagWvLU=:ENbogEIRnj2RuhB1n/1Qj/
 T7yO3WwODtItBYysdM3kephVkfgTyVncbH/G8c9jq6IZy6R+jfhdb7DBJ1ChNR/dIHxLdzPgd
 PAqXcz9E4hMrDrYRkokOmIcfvLCBmP8VPlYLwTHcMKQLtdE1SZbzuOME28kMdNaHyNm17BXfJ
 JDvRsZM7zaNdxOi6wOIXj5A6EQLt/tu72rhLSdWSbY5x08+LytZNOTaaYlUUWhAq4qXy4VPqF
 tiC+evzr5dZQlbhvn9GG7peceIshXI7uIrhpheyqOIrm0z9t695e93Tp3RDZX3zs7zqy7wp3m
 C8FpWg3rwAGrx6wAlBFTrEUoRWHZhnRP/Q9fMnKNoZ0jVTxIro/rsVc5d4QamImHAMDAnyQP2
 hTOoe2JQ5WOSpJsxW7xBvOs7bgfs1eixpyZzbUESQCXjdAF36YZRBfTLrVSCuXq5ghH7yG5p/
 x4ZsHIlPv/H19++HJ+i1soBDKnqti5WK9qprugGrV9KeBwW58+Csr69g84T/+rZILrxGGeIDx
 MpAqQjb2jVg7i0InqXEYinlOWw70r7xfu/E8uMr8kRkkRQECdg6/fGUprREJIb7Dzqh10QbKH
 kE76qdiGvhqavJy7NIpUFnHQzLyOYiN9ymxf/Fx0xZtePP9vvcKpZkkMy2CBd39NWGNFhfC0B
 fkFMEvm6ox2ZNjC9FzMQej6yRIkb9uLIxqBG5sA0ofI2F0YQBxG9gIslwTRQKKUCn/WCWLktN
 vw94qaxRTtlzcwuiucVihNsykWTnBFtCekkGanqUugeCS4ZBId5PIR7UmCb7PBLtR63bGHmN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292203>

Hi Linus,

On Thu, 21 Apr 2016, Linus Torvalds wrote:

> On Thu, Apr 21, 2016 at 11:05 AM, Jeff King <peff@peff.net> wrote:
> >
> > Sadly, neither git's internal version-sorting nor GNU's "sort -V"
> > knows that "v1.0-rc1" comes before "v1.0", so I had to rely on
> > "--sort=taggerdate".
> 
> I'm not seeing the "sadly".
> 
> I think "--sort=taggerdate" is pretty much the only sane sort there is
> for tags, unless you do a true and full topological one (ie sort based
> on by how many commits that tag encompasses, but also by how each tag
> contains another tag).

Turns out it is pretty easy to implement this in name-rev. Expect the
patch in your inbox in a minute.

Ciao,
Dscho
