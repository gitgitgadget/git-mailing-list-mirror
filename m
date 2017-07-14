Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E4020357
	for <e@80x24.org>; Fri, 14 Jul 2017 20:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdGNUdP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 16:33:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:58588 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdGNUdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 16:33:13 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsTjw-1dcsYs2BeS-01235p; Fri, 14
 Jul 2017 22:33:06 +0200
Date:   Fri, 14 Jul 2017 22:33:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Paul Smith <paul@mad-scientist.net>
cc:     Kavita Desai <kvdesai2@illinois.edu>, git@vger.kernel.org
Subject: Re: Git Bash Bug
In-Reply-To: <1500044588.25789.109.camel@mad-scientist.net>
Message-ID: <alpine.DEB.2.21.1.1707142227240.4193@virtualbox>
References: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>         <alpine.DEB.2.21.1.1707141625150.4193@virtualbox>         <CAAu0pLdmGc_kq_w0Fm6W4XDqOe=iKSyAyLct+yH6y+7FPUHtnA@mail.gmail.com>         <1500043024.25789.105.camel@mad-scientist.net>
         <CAAu0pLdjvcxda0rip8JOzt1q0HNuu4dBNHvEzJbeey6yRSyCCQ@mail.gmail.com> <1500044588.25789.109.camel@mad-scientist.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:svR7CY5hXcuV8DWOCAX6/i70p98Q/PiahbamzL3MIe+KY4GkivA
 NKrZbjF06cbKfc12UaYkt4iYNV405vIQzDUzEUnqdBXLvZCtOcMd4Z9UxTJjgF3UBlhHOvD
 QQO8CCy3J8Jwby3bhh69uG/GSOBodUA+aPZLsMcCBsSHhkUfpPjNBq3lVX2JpRwOvIc3W8B
 0efYMF+/3i0TExaIY9g+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vZw8j7DofWE=:UzhGf7NzSkkHcEFuepsGjY
 AwunJYr16eqqypIooNal3Q0IxDH54NlHC4M2Rij16G/GSLpgt91eP0GNKftLqZGQWqzTt1h22
 1v/SnUNvjpThCYLxlqw2AgJbtjRtCbHljwsJCRku1F+cP5hO/zbJ1LmcJICk1XOO0Sob8PS5k
 XcO6Y/rx7gqb63LTzCwW5WYiixseJ+DIPaARNIrpm4SMmfjU3N/dTY9BgKidK5oTIkuKeuDT7
 B0/6ptfGDW0no4SOqkqdXtP1SNh9HC4twmMUqLU3gd/5+bSGk8RvHk3GzW99WKFjh9c90uwpf
 JVBfdN9h6WRtCWVEDA3vpd/uZzHafxgxWc/wssZoN00/v5pvQPvv/fSTxvFqKBMCpo+/RhrzS
 cCEkc5iL962W4hK3fTRblxuGSoMmwa5uri5J+EV2kpFdOCpz5x5SaYptZV+1wAjuO5CTT0L/7
 GzK4A68RuOERK693u5FyIqshZlCEldL/rGCNsC9HAYMPofxRhm7VZQ+e2WCv4ibxlqFQNeyEz
 4kHHj7nz0KPqIY68baRXrcuo94KKdtFVrKwVKq53q/4Ul2oPJHTwW0W+pQxFAUFyEmO3BPyBf
 tQxF50lyzURULPhe5iVrwgV6rplY97B3p9qdUuC6zopSuS8zMT/dqRY3hRTFlAUFjCwiDWzGv
 F2xM0bmsFil0nb/BzTvxpU2RHo1tahyAeBM/nZATn8nBCWmAxPdepQ7TlY9vrM8W620/e4VCk
 FxjFp82bTGiwrNJQ/B3Oo4QwsNuUYaJSwsFMH60S0Ze8aLO51oMAK2Zn2GfGuRUtknpljUN9Q
 0pvXCg14oMhlYRL073yTW1mqDm6Fd9UoHNl8ttY2Ro5daQR/2s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 14 Jul 2017, Paul Smith wrote:

> On Fri, 2017-07-14 at 09:59 -0500, Kavita Desai wrote:
> > What does "echo $PATH" show?
> > /c/Users/Kavita/
> 
> Well, there you go.  That's clearly wrong.
> 
> You absolutely have to have /bin and /usr/bin on your PATH,

As Kavita talks about Git Bash, it is probably Git for Windows, for which
/bin should not be in the PATH but /mingw64/bin or /mingw32/bin (depending
on the architecture).

It may be messed up by some strange setting in the User Environment. Go to
the Windows Explorer, right-click on "This PC", select "Properties", in
the newly-opened window ("Control Panel>All Control Panel Items>System"),
next to the "Computer name, domain, and workgroup settings" select "Change
settings" which brings up the "System Properties" window, in whose
"Advanced" tab is an "Environment Variables" button.

(Or hit the Windows key, type "Edit the system environment variables")

You should find the "Path" variable at least in the System variables. It
is case-insensitive, so if your User variables contain, say, an empty
value for a key "paTH", then the riddle is solved.

Ciao,
Johannes
