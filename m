From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: More gitweb queries..
Date: Sat, 28 May 2005 12:56:22 +0200
Message-ID: <20050528105622.GB32614@vrfy.org>
References: <f0796bb705052718035cd5dbe2@mail.gmail.com> <Pine.LNX.4.62.0505271949480.15585@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Serpell <daniel.serpell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 12:54:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbyxQ-0005zG-1s
	for gcvg-git@gmane.org; Sat, 28 May 2005 12:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVE1K4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 28 May 2005 06:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVE1K4a
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 06:56:30 -0400
Received: from soundwarez.org ([217.160.171.123]:35295 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262689AbVE1K41 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2005 06:56:27 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id D7BDA50F5; Sat, 28 May 2005 12:56:22 +0200 (CEST)
To: David Lang <dlang@digitalinsight.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505271949480.15585@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 27, 2005 at 07:51:39PM -0700, David Lang wrote:
> >Hi!
> >
> >On 5/27/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> >>On Fri, May 27, 2005 at 12:24:20PM -0700, Linus Torvalds wrote:
> >>>  Combining some of the features of the two (that =C3=BCber-cool r=
evision
> >>>  history graph from gitk rules, for example) might be cool. I get=
 the
> >>>  urge to do octopus-merges in the kernel just because of how good=
 they
> >>>  look in gitk ;) ]
> >>
> >>I would like to show something like the graph too, but I don't real=
ly know
> >>how to do this in html. Seems slippery if not impossible.
> >>If anybody has a nice idea how to represent that, I will give it a =
try.
> >
> >Well, you could draw them in javascript, using
> >http://www.walterzorn.com/jsgraphics/jsgraphics_e.htm :-)
> >
> >Alternatively, you could use a fixed set of little images, a bar "|"=
, a
> >dot "o" and branches like "Y", "7" and "\". Obviously, octopus-merge=
s
> >are very difficult to draw using only those.
>=20
> you could look into SVG (scaleable vector graphics or some such thing=
)=20
> that are supposed to be in the newest browsers (or soon to be added, =
I'm=20
> not sure). this should let you do all the drawing nessasary reasonabl=
y=20
> easily (if you are willing to limit users to that, which is probably =
not=20
> that big of a problem for git)

Well, technology that is "soon to be added" since years is probably not
my favorite thing to base my work on. SVG could be nice, sure, but near=
ly
noone is able to see it today and I expect, I will need to wait wait fo=
r
another few years. :)

Kay
