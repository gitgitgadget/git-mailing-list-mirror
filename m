Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56C72055E
	for <e@80x24.org>; Sat, 28 Oct 2017 16:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbdJ1Qku (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 12:40:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:55614 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751385AbdJ1Qkr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 12:40:47 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtZfc-1d7gwX0OEW-010sI8; Sat, 28
 Oct 2017 18:40:41 +0200
Date:   Sat, 28 Oct 2017 18:40:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [git-for-windows] Git for Windows v2.15.0-rc prerelease, was
 Re: [ANNOUNCE] Git v2.15.0-rc2
In-Reply-To: <DC84FB2E-A26E-4957-B5FA-BE6DDEC3411B@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710281838230.6482@virtualbox>
References: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710210020290.40514@virtualbox> <18E24F0C-D518-46B6-A8D5-71B0E1B05DE0@gmail.com> <DC84FB2E-A26E-4957-B5FA-BE6DDEC3411B@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vwv23BNUIMHsEffVf3BdqAiuEQqCTwuUtnLKKn23/Zlj/IJNML4
 OIkGG1cFETUPt6hPy8FCMdxGuzi7Sr8jIlefx7CBmW0UW9lqY5a2nMJ3pCGProqngd2KMRm
 oHdW27sRn0os+f4ypLraMOk4wG6nks1V/BCVLUJ20w/D2Y7BkNJ++lajZXn+tdJaYGiMOBo
 zaxVTnPt7h0iM9Ueflf2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rqE9xKCsQkA=:CFXOXHnijPc9Iww8WZDnbj
 vgiGWsFumeVyJCflQ27mApFisaNHzg8cVt5hl/NF3mdLbZe5id1R8m+eIUTNP5xNDrAL/G4lf
 JAOX91QrA7V8b26ki6ahKr+llb80qTkOtT1DiSUcpGxJRDLdOw3UOVJqzzp7FiECuINqAKJU5
 DZwqgsXRuHBFryDKCn7yI9OiH5BJBfHirhwLU4yoLzgQtvEwLrW2CA8+dzoAY2bEKoHmZv1+s
 Klw6SRh72f4+oUO6hGBaonz9iwFS+xCml8UCcPsAuWx/HD01R5BxMC61piPaMUoqKBKzfjLbo
 ywXhWDjL0mA8pgIg0PXUyA8v6SVluKEu+mK1I/qGKVjIV2ulkvFGKk99isXqGUsRVyqp9ZVEz
 LWapFJW/mOgm8lIFHBuW7WG7fSpqqDW2IwHPF+kXWc8+GI4WuSoBLW01RpqbdhFyhjaxq3eeH
 USgLtGBrWButuzTbXSdw6V5LTfZ5PizRM+cch/chpNuiSsHFoAMi3rRj82MW8GHdxKfS53Cll
 ngX588gUNI9Hs8nqwMKL8vhMOzvWXJX6TDCyEhbQ/bSkyZ5ah+aooheUZIXqv5KxFkh4M2DhW
 vC0jXTp/+pNlc4d3olFfD4hWF6QkQ+k2wdeWuG0jic3fPcMKee6M10bINmibTcHPSeirhfagu
 ZVu6p0+roluEqatgC+KKzzSGFROXYCotf/i3f7f0EqxajdAfR/dfbaRal9PVFTG1fS7S/LBZ/
 jv2XivTqaHUh6XySiSjK9Z8YM2RR/YzsczHOxWO2eakyt9r3/s7kgo7DGee+taXC4TGOTwS2d
 ZwOLV1NGp8za56SBD1u/a5DgbneCokLzd/LuYs2XR2w9eAwaZBd032NsJWSvc/WyvXzSkp/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Fri, 27 Oct 2017, Lars Schneider wrote:

> > On 27 Oct 2017, at 14:11, Lars Schneider <larsxschneider@gmail.com> wrote:
> > 
> >> On 21 Oct 2017, at 00:22, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> >> 
> >> [cutting linux-kernel]
> >> 
> >> On Fri, 20 Oct 2017, Junio C Hamano wrote:
> >> 
> >>> A release candidate Git v2.15.0-rc2 is now available for testing
> >>> at the usual places.
> >> 
> >> The Git for Windows equivalent is now available from
> >> 
> >>   https://github.com/git-for-windows/git/releases/tag/v2.15.0-rc2.windows.1
> > 
> > I just tested RC2 on Windows and I don't see my "Filtering content:"
> > output if I clone a Git repository with Git LFS files (and Git LFS
> > 2.3.3+ installed).
> > 
> > The feature was introduced in the following commit which is be part of
> > your RC2 build commit (b7f8941):
> > https://github.com/git/git/commit/52f1d62eb44faf569edca360ec9af9ddd4045fe0
> > 
> > On macOS everything works as expcted with RC2:
> >    ...
> >    remote: Total 15012 (delta 0), reused 0 (delta 0), pack-reused 15012
> >    Receiving objects: 100% (15012/15012), 2.02 MiB | 753.00 KiB/s, done.
> >    Filtering content:  43% (6468/15000), 33.30 KiB | 0 bytes/s
> >    ...
> > 
> > Do you, or other Windows experts, spot something in the commit linked
> > above that could cause trouble on Windows?
> 
> Well, it turns out the output works for my real life repos but not for
> my Git LFS testing repo.
> 
>     git clone https://github.com/larsxschneider/lfstest-manyfiles
> 
> ... prints the filtering content output on macOS but not on Windows.
> The progress function has some delay feature that suppresses the output
> if it is only shown for a second or something. However, in this test case
> the output should be visible for several seconds at least...
> I am still puzzled.

Nothing really strikes me as obvious.

Do you do this in Git Bash? If so, maybe you can also test in Git CMD? I
do remember having issues with stderr only showing up in time if it was
fflush()ed explicitly, but only in Git Bash (i.e. a MinTTY problem).

Ciao,
Dscho
