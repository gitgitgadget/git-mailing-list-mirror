Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D9E2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdHGTf1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:35:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:64218 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbdHGTf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:35:26 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBFBB-1dp14g3Rif-00AFrW; Mon, 07
 Aug 2017 21:35:23 +0200
Date:   Mon, 7 Aug 2017 21:35:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.0
In-Reply-To: <f92fcfeb-75b9-6ee2-0bc0-a42d1dc01ebd@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1708072127480.4271@virtualbox>
References: <20170805230001.3232-1-johannes.schindelin@gmx.de> <c532df98-b020-810a-c378-04c7dd5b0fa7@kdbg.org> <alpine.DEB.2.21.1.1708071147430.4271@virtualbox> <f92fcfeb-75b9-6ee2-0bc0-a42d1dc01ebd@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lC+4leiaUEDrMybHNfc4zpsYGI42VsWmA9f4BJ4mu8164JKqaKF
 hk1CLkAqWPICkmwKhjX/dXGI/2Zd/1bnjdUtpIY0aJWY++KgNi66g+SJ/JNBw/L3peJi0oQ
 kkfqIrT0WG49JlC7yepcJCAElm1oiOxF5PzLj8e54IRk90kg7cJY3YoBKzIXtFoSk53DBz9
 um8/Rhizg/VkghDMix3TQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WWuuA8pygvw=:9aQmcFJ08N/xo1xbgy9pRE
 pnAkKjBB3KvQ1/jUggLkSTJy0r9ZqZhmYvqpCB4qXSdx6F/7YB1eM29bVfIPXY4GT8ruU6AK8
 7KHYZfEGHbSfxfQQLETt8OJImtqyuj2/RnmT9tEHIs1x07fMzjL4W2pnUNCdQ+oSjLRYes9lg
 c8MhfHdmvd7+AZekk+ESHOuWrx3iKVXLRriHiw3zEjTFcjzR5v/MWjftVLTau7BhU+ckgEJBf
 JFB9uHYQHYgy04eJIp8hBQtfqFR5qLZJc376olFineeumO4MCKHnZz/2HjSINpRvOTmdacyby
 5bcYEX/uGbZwrYlH9YZFeNnMUeOaSwQnTi8Qafld6y1No8t2suL78LzHTHVedloyXSoqFWn8J
 WoweRJJYhqozIDz9qwnvjBUAvgZywDgb6nw9Wr9EyA+PFCS/KMwiiRIhuiO5pRw1OG5Y6XqJI
 efvHJXuPFF6IBOiQa6I9aHFOov1T3TySNfj2/X+bUawDcAQmmPxObjJtnwXaEP7vBu7c/JHjN
 HXtNV6y3eEPxA58U1zVTA8pTXWaDsC3TpHUR5RgVAGfPgIWFAAhE983nbzZTdrHUu/WPztubq
 p/CEWm34rF3MmOrKn/WWFTEyTNS9f8OUxgncZza/hCKLUhQz27PthDJeIRcEXl3/UF7wJylIj
 5UKrtpgate3/I0Q8ARQCllhipS6OHK//SqldGsZXi2Gzf2ZWw2OnsuHnAbzokti7aLEPCp257
 CuZM1otFVfGxV334IrXDlBPQZX4YYdC7oJA6aUSQVWz7K0h8gMl+41m724PJ45qffeeZ84fSz
 R1ezJTs2NWvl2fcAl8L6firXAWAL7bz2ioWaDL+m5qXqr77Ykw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 7 Aug 2017, Johannes Sixt wrote:

> Am 07.08.2017 um 12:02 schrieb Johannes Schindelin:
> > On Sun, 6 Aug 2017, Johannes Sixt wrote:
> > > Am 06.08.2017 um 01:00 schrieb Johannes Schindelin:
> > > >     * Comes with [BusyBox
> > > >     v1.28.0pre.15857.9480dca7c](https://github.com/
> > > >       git-for-windows/busybox-w32/commit/9480dca7c].
> > >
> > > What is the implication of this addition? I guess it is not just for the
> > > fun of it. Does it mean that all POSIX command line tools invoked by Git
> > > including a POSIX shell are now routed through busybox instead of the
> > > MSYS2 variant?
> > 
> > As I wrote a little later:
> > 
> > * Git for Windows releases now also include an experimental [BusyBox-based
> >    MinGit](https://github.com/git-for-windows/git/wiki/MinGit#experimental-busybox-based-mingit).
> 
> Thanks for the clue. It's an interesting concept. I would be interested in
> replacing my old MSYS environment by BusyBox. At best, it would be just a
> matter of replacing sh.exe.

OpenSSH and GPG are also required for Git for Windows to function well.
You may not need them, but others do. Also, you may be content with
running the shell in your Windows Console, but most users use MinTTY (and
would have used rxvt if we ever had gotten that to work).

Given your circumstances, I would estimate that you could already use
a BusyBox-based system. You have been traditionally very comfortable with
running your own setup, and putting it together yourself, so you could
cherry-pick the bits and pieces.

The only exception may be `vi`. While BusyBox comes with a `vi` applet, I
disabled it because it does not work in MinTTY, and it also offers a far
cry from the vim.exe functionality I am used to. So you may want to revert
https://github.com/git-for-windows/busybox-w32/commit/4dccf1500f4 and
rebuild BusyBox-w32 yourself.

Ciao,
Dscho
