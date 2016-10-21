Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4542120229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933350AbcJUMlD (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:41:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:57871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932428AbcJUMk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:40:59 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LjvV7-1cUy4P0keX-00buRs; Fri, 21 Oct 2016 14:40:56
 +0200
Date:   Fri, 21 Oct 2016 14:40:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Monov <logixoul@gmail.com>
cc:     git@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_Git_context_menu_in_Windows_Exporer_has_a_=E2=80=9Cgit_bash=E2=80=9D_option_but_it_doesn't_work?=
In-Reply-To: <CAJtFkWur0NfvvV-QT2XmEW=MSJ7Ye=hX7HujEQhTFGiah2_yBQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610211437510.3264@virtualbox>
References: <CAJtFkWur0NfvvV-QT2XmEW=MSJ7Ye=hX7HujEQhTFGiah2_yBQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9xsUQAfMFcnYRKEQltHrX4iqjKfFIrYL8iR3JWJl3EZ+2LxRBMG
 6Ps1Z1gtyd0oFgaUKwI7rRqUyt+/G78WLUOt3S6/hpDAkd04PjQqieu1yOIEJYi2Sq8COPj
 l2iJ4qrxGk7hYUh6Wd/RHWrVoV2qZRf0o9xweaqw2nBINI21QlbsR45MdLAEY4eAxt2kgAC
 JtnhAXOnM8SyDuycldHag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G40eqQGDJPQ=:SAIfIbnNjMb4AxdvVXjN9O
 V3Hz637qnLZRdMofSodXO8ySlmJh+gvcDcVanhcOaezhHGw2Vks1bLkmqbRr/xbO2pBdWWQlw
 86ZQR4BF9MwlWik5K/Xe4STB7Cc0Oawug+pFePAnBQutJuUpeJZ6EhDv3bCPZ/UOo6HNT3yEg
 /oCNNhamVla41IcnlmJx2Xy44xZ59qnCQq+FHE8cM7aUQkE/74PiyZRf3lddYcBP0Q+diV9tP
 li8Zx5s1kQj0tbR/a7OLboc8wBLKNkV+3XSk/Osoo5oA1S6QKoJOQI713A1qTlMjG9WJMOa3b
 B7ZWCs80Kf2XmFZVvfb3OuzcuALXkykrD/qvzO58QpS8ipbzY488lYGPLQaf0mZWA1PlI9im2
 vf8yIMB98d4qAINFlbZAK6e6V5o563nB/FmRQ6nROjo3bOmgS9uFEdOXV6Oy8M2P/yLtiEgQm
 SL2LjZNHhHrmJgxu2tAYn2yORt4IKi4xfKJVLmmFcDpYNWPwMXEEkl7nR+H6kM/soJCqoI2K+
 BTr2bBM7MhAvElOFQLoE6IETvSa3DuZYzU91L43kZC7KwzF1XnXei3K88sXNJB4wtZ4yAVF0m
 9QtJofTA3s6evuQmIJu0Y+m0PF8nY+mHLFsRGafFIFapO55t6A2Uveslw1pEqbhOBJ4OtOCzu
 tZ8E5+qTU9R5JMe5pPGXJDxWWHRseP345Vt34c2G2516VwXw/HCPD0rhFc6tBarK9dqTpAn6O
 2x8xgjK1WCsv4XhvASJ2u79IGiWSAFqqH1GsZ9xwgsSp6yi6XxJmXz88BF2+q4pYcWI3akDcU
 cy85zRO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 21 Oct 2016, Stefan Monov wrote:

> The default git distribution for windows

Are you referring to Git for Windows? Which version? From where did you
obtain it?

> contains, besides the CLI tools, a shell integration, i.e. a context
> menu for Windows Explorer.  This context menu has a "Git bash" option
> which I suppose should open a Git bash prompt cd'd to the current
> directory.

I guess you mean either "Git Bash Here" or "Git Bash" (not "Git bash")?

> But instead, the git bash window opens and immediately closes, giving me
> no chance to even see what it says inside it. Any fix?

Sorry, there is not enough information to go on here. In Git for Windows'
bug tracker, we were careful to provide you with a template that helps
with providing relevant information:
https://github.com/git-for-windows/git/issues/new

> Note: Opening Git Bash from the Windows Start Menu works fine, but if
> I open it that way, then I need to manually cd to the needed dir.

For me, both work fine. For the record, I use Git for Windows (64-bit)
v2.10.1, as downloaded from https://git-for-windows.github.io/:

	$ git version
	git version 2.10.1.windows.1

Ciao,
Johannes

