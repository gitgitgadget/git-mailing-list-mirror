Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC171FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbdBIWMK (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:12:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:55465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754163AbdBIWLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:11:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEtba-1cegkP3xMI-00G3uM; Thu, 09
 Feb 2017 22:53:36 +0100
Date:   Thu, 9 Feb 2017 22:53:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their
 corresponding commits in `pu`
In-Reply-To: <3F7E4C9E-593E-4FC5-B820-E6A0CDEB7476@gmail.com>
Message-ID: <alpine.DEB.2.20.1702092242120.3496@virtualbox>
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox> <xmqqwpd316f7.fsf@gitster.mtv.corp.google.com> <3F7E4C9E-593E-4FC5-B820-E6A0CDEB7476@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e7/OBNUI6KrmxMx8Z9fSnpyH5XMXKzekO+0PiT+V6thgHURAMrQ
 9NdfZSIsIsA5HBFpvljeFilQSGxxXnkAn1fGF1WBfKSIustCprUJ4Pr7FlP1S5/+cTp95XM
 RkS6R749fgW+H0LP8ossBvGEJf0F9MY1/szzVy1LnQDZzBZZhnuWzNJmbb1TAtZWJSOcKiW
 Lpl/jgCSJl6sI88afKrcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tIJkjpEzi9E=:y5t5BU6t3dLvWgqOM20306
 wP8Is7zxX5cHheibhyx6azOTwSbce499W6hgROB1J1uTSgIg7+C6CoAcXJ4wKz3AACNCTIqYv
 UWbliI7lTTplDLX8mz4Jw1PyChhLWR/6gfCcgkzPh+mKK5yYVXP5UtmT0HtEb4ZM9Vlc1YYvY
 t1WA2wnQWiWYhXreUonzusy/UdjGhaJ4Gol6eEBvhQ8g2Dwf4WQMB8R+CRxOfNyVRlqyu8VcU
 aknkq6Vb8GLEsiX5wywhOvb8/xxBLF6BlkshhiLpDqeh+l8Fxkf/7C3ZQ0EwRaPg8IZJuMD2/
 Sp60Z/p0AyY8sj12zpsbGV3rwq8b3dEzyuH9GS15x0cffLhN8Z2F0pucHfnlbkRLajTicpFlN
 UwdwPKWNXOH9N2OhqYxa/czrleiDZTDxPnD/cRdS3Pd1ToPa63Hqi798TwTobG1VCaVTapBnw
 B/MgPFNLlcxwTuaDu8B2XgOYMyZChKia+8CJPsm3iVf5UPc+I2E+9UufK3ZH2f226fb1melhd
 PM2P4cltH9TOo8OzlITVy5g1e4A5mM84+vlsMWOmERDHbDKKoJzZYNeiGYQhLUN1z1c2I24BG
 09iDnREcWRR7K74mcIQUMoOsYnNnQCnuqrMGBCF/Rr6SKLBGzB5PO1wy63gDe88GEO/qITM2Z
 6MSJ8jlvDeWqMQT10+ohKPVBgmPUEHeQInX+MuXAuTPvzA1jR4FlEOIots8Ceol0bL+3ohGC9
 3rQGBMXNv0WIZnEft114+yLZmjaoYr3hH0VLFHhUxbb2ji4nhH2AfX1yYQpc6k0QYbqHMzlc+
 vw75qEM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Thu, 9 Feb 2017, Lars Schneider wrote:

> > On 06 Feb 2017, at 20:10, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> >> So I thought maybe the From: line (from the body, if available,
> >> otherwise from the header) in conjunction with the "Date:" header
> >> would work.
> > 
> > FYI, I use a post-applypatch hook to populate refs/notes/amlog notes
> > tree when I queue a new patch; I am not sure how well the notes in it
> > are preserved across rebases, but it could be a good starting point.
> > The notes tree is mirrored at git://github.com/git/gitster repository.
> > 
> > E.g.
> > 
> > $ git show --notes=amlog --stat
> 
> That's super useful! Thanks for the pointer!
> Wouldn't it make sense to push these notes to github.com/git/git ?

I am not quite sure about that. It is in a different namespace than what
is usually cloned, and it currently adds 8MB to the download (there are
"amlog" and "commits", the latter clearly being a sandbox).

While I am thankful that there is at least some information available for
patches integrated into `pu` since Nov 1 2016, the format is probably not
stable (we are talking about free-form notes, after all), and it still
does not help with catching the case where new patch series iterations (or
in some case, new patch series, period) are missed.

Make no mistake, it will be a huge undertaking to develop a tool that
helps with the management of patch series on top of the mailing list
driven patch review process. And even in the best case, it may be simply
too hard for an automated tool to figure things out e.g. when Peff or
Junio paste a tangentially related diff into a thread.

In the end, what I *really* would love to have is a system where you can
easily query "which reviewer comments on *any* of my patch series are new,
or still unaddressed?", and "in what way was my patch modified relative to
the latest version I submitted?". It may actually be impossible to create
such a tool, as it cannot invent information/cross-references that it does
not have nor can deduce from available data.

Ciao,
Johannes
