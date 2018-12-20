Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDFAF1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbeLTMiK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:38:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:45381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbeLTMiK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:38:10 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86Cn-1hM1wC31Bx-00vdVp; Thu, 20
 Dec 2018 13:38:05 +0100
Date:   Thu, 20 Dec 2018 13:37:49 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/7] Turn git add-i into built-in
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812201336250.41@tvgsbejvaqbjf.bet>
References: <pull.103.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2065103519-1545309485=:41"
X-Provags-ID: V03:K1:A2tQ9OsDpcK4QW6QIx8fg5eMTIVgtpZ/Nj8cBupEVS0gFC8KbMH
 NM5z1PrVI8FtPXV8eCiCbuad0GdNWGH9ZRy+FH6YL8KAQf3ag0U8evMNw3FfU4o/fV7tvqQ
 eGmpKcfZHtn4VZDTOzU0rtXL+WjIZ3Fh11S0S/koha8HKzXO5Lp0BLqsQFxRBjtu8gnh1a2
 qLNnT0vEiCEQqMWHx6qjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gem31mfUk7A=:f1qS/+YMyRzG4xr0a0KZzh
 aSDiPIgwaElBrVARLcZPTaxDpjr8tEd1ZJwCRmA5vk7yZKD7tb0ogieWgeXqx7lQBBiKE7kRA
 3ppeJWVRkMZ3ZomsLNUED1ig0ls9mp2GCoucJufcWNwIUcwL+lUDrT0WwZcRNR4Hz3/yKdvU8
 ANc3WaI2rwpIehcYQGfHm3zfFrvG7y50uE4aaf7GLl4DIzzd/5TajDAE8w6ctbFIm2I+b/o3O
 x8cmVeMpPkq2V1l+NelJ8yBG5BLQqdF2YhbARMyfMZM1kXSpTcdlqvsDwX/OYf25F72Di2+it
 aj448lW8XBhExZuhPxuXq7WbGAbdL5l3HtI/FYh054UZQl64biU3Umj2QMMfLdzu+H4rROJ3J
 sk2go7wVMa/a3jPu71d2uhw0qa4iuZGlBNxQ145TTG+x/QCUqt9Yps2BY5kla8qQLYck8pmAq
 816YQ0jYOSKhXKJFOw8A4C8WKA12ULDs11Mz0cgMl7W68X2eX1aypOJctBqOsK3qze51WOUFm
 TboXnyMT/T6RWg1MFYZaGrNhfGwGaJjC2CKbbdpaafjZvBXvEra5qHQUalgAsrPoIn/A8YpkU
 4LxnCTVtjEeN7WYe59vcdCmIuBYldfnIc400jO39UW+mKS0gi7lXp913vDqxCd9Z1fCgEZVvK
 zGGETiLt4wrAXGZ28/bZhWcuh8YZ9CxjkwOicL+do/11jpyVMuu+0dui/WhYhY9WGskEwH0Sx
 mk8yCET89Adyc9z9GJjFp/WDQGbo3Q4GVCHgavx3eYo/ICLHn26uiqUejvn6dUMG3p7Tlo/0k
 eDXAeUtwcnwDrAdYw7Mxyy5kGoRX2jhM41mUuNQPbPKxiYH4eCtXOwRoxqCRgnqYNE8kC32fB
 iei0y17j4rXyq2ykAlfWtDFGO2X9NC2MZp7I1ydNutJvHHxj3gmVuY9fJyMLJa34tGv/RJypb
 RHiZI6Ps7Hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2065103519-1545309485=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

just a note: this mail had not been sent by GitGitGadget (and hence has me
as sender, even if the email address is GitGitGadget's) because it still
has problems with From: and To: and Cc: headers that contain non-ASCII
characters. I hope to find the time soon to work on this.

Ciao,
Johannes

On Thu, 20 Dec 2018, Johannes Schindelin wrote:

> From: "Slavica Đukić via GitGitGadget" <gitgitgadget@gmail.com>
> 
> This is the first version of a patch series to start porting
> git-add--interactive from Perl to C. Daniel Ferreira's patch series used as
> a head start:
> https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u
> 
> Daniel Ferreira (4):
>   diff: export diffstat interface
>   add--helper: create builtin helper for interactive add
>   add-interactive.c: implement status command
>   add--interactive.perl: use add--helper --status for status_cmd
> 
> Slavica Djukic (3):
>   add-interactive.c: implement show-help command
>   Git.pm: introduce environment variable GIT_TEST_PRETEND_TTY
>   add--interactive.perl: use add--helper --show-help for help_cmd
> 
>  .gitignore                 |   1 +
>  Makefile                   |   2 +
>  add-interactive.c          | 265 +++++++++++++++++++++++++++++++++++++
>  add-interactive.h          |  10 ++
>  builtin.h                  |   1 +
>  builtin/add--helper.c      |  43 ++++++
>  color.c                    |   4 +
>  diff.c                     |  36 ++---
>  diff.h                     |  18 +++
>  git-add--interactive.perl  |  15 +--
>  git.c                      |   1 +
>  perl/Git.pm                |   2 +-
>  t/t3701-add-interactive.sh |  25 ++++
>  13 files changed, 387 insertions(+), 36 deletions(-)
>  create mode 100644 add-interactive.c
>  create mode 100644 add-interactive.h
>  create mode 100644 builtin/add--helper.c
> 
> 
> base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-103%2FslavicaDj%2Fadd-i-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-103/slavicaDj/add-i-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/103
> -- 
> gitgitgadget
> 
--8323328-2065103519-1545309485=:41--
