Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A721F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 07:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeGIHwb (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 03:52:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:36783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeGIHwb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 03:52:31 -0400
Received: from [10.49.91.56] ([95.208.59.25]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVns-1fKu7H3JT6-00Hf7C; Mon, 09
 Jul 2018 09:52:20 +0200
Date:   Mon, 9 Jul 2018 09:52:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Daniel Harding <dharding@living180.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
In-Reply-To: <20180708210200.GA4573@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1807090944400.75@tvgsbejvaqbjf.bet>
References: <20180708184110.14792-1-dharding@living180.net> <20180708184110.14792-3-dharding@living180.net> <20180708210200.GA4573@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:82srAyLX6vF4a57ehA4jwqxtP/q7PWna3EGHdmKSIFFJX40qXFl
 57YrvPF8d1OvnvqvG/SQtQUDwygzL2GXhe+0+Z92/vg3sG2sWV2sQprtNTfxJbUHSZEmPjY
 X7ymlCmJEWDtPr/7dzxQHrhoPMRYEpiSYGqQUuPw389OSpM6iW2CLtLquuFPl46SzNZvja6
 T/h3Z27gSKFriLURaWUbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2fcmT7uVxUk=:JscxkbEWzbUTZShr/Nsbe8
 SZURctlBc3yIuB75O/IMCuHvLvDiU7Ag0dIldculjtDT3YaEppV8jrOBZjyZStAYrXcMA8CqS
 ULp4ztdt1guurcRQzTNPib4tAWd2bfuiNVW2rrO2WMHI9NUIjGO6LaVA+0zSF19aiJ7SA9cvY
 tPxOOfnqnBNWv+ju+nlLKj0xlBiv7ukDx/GLpcBYhAmBaH/YLZ6BXj3n+ikD0JztfMyt8W0VQ
 XCYvZpuNMdFPtE/3S2os7UWrM85q8psP4IaDkA9ShiDSaxnL4rQH/wAWVwvYld2oLPLvF2Mww
 2yyHEvHUkIqVArrA8QVAX3PY4zqYgXnSLgWQ0EpHx3L6lusrpIeGR2xcsuXepJIUMDSkLezOf
 aVe0AInE/n0Gj7mFlx+mB9IDfgbsl7oJnMMFUe11y0mXq5UKhfDe7o2L8TkKdn7+83Mc1KhNW
 8sUfnwWGO2w0BZCMoLgbhZINoADPjD1TDtN3SGga//a1f+1aYLDEZATml3EJx2H5WRU7OIepe
 AQ82ursI01d6PjuOBggCi2CJbl7bIAxLQH3z547h3NhogXQKV+P8KnS6MqU2Vq1zMBMKstIo/
 V+N94N0+m496E0RXLOU8rH8Zt9PLjwcgvECN3H4qrMa/3zXtK6wL/A5ZThnCcapdrESp/qHCi
 RpvBsohN5YED0/SftKJW0KFMDqeROXIiWqEqpKW/yP4LL3FMo3E1yi/jEYkSfAZU80Ez5Hedd
 7xLoxnZdFrZhEiEbEIM6Pd1Vgq0HfGoOUe5xhxL7TGq++AtCtl35tuMv6P/wsmPdxRo9hUwGV
 jQwMtvz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sun, 8 Jul 2018, brian m. carlson wrote:

> On Sun, Jul 08, 2018 at 09:41:11PM +0300, Daniel Harding wrote:
> > Signed-off-by: Daniel Harding <dharding@living180.net>
> 
> I think maybe, as you suggested, a separate test for this would be
> beneficial.  It might be as simple as modifying 'script-from-scratch' by
> doing "sed 's/#/>/'".

It might be even simpler if you come up with a new "fake editor" to merely
copy the todo list, then run a rebase without overridden
commentChar, then one with overridden commentChar, then pipe the todo list
of the first through that `sed` call:


        write_script copy-todo-list.sh <<-\EOF &&
        cp "$1" todo-list.copy
        EOF
	test_config sequence.editor \""$PWD"/copy-todo-list.sh\" &&
	git rebase -r <base> &&
	sed "s/#/%/" <todo-list.copy >expect &&
	test_config core.commentChar % &&
	git rebase -r <base> &&
	test_cmp expect todo-list.copy

Ciao,
Johannes
