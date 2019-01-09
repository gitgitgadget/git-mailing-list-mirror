Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDEA11F803
	for <e@80x24.org>; Wed,  9 Jan 2019 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfAISZF (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 13:25:05 -0500
Received: from mout.gmx.net ([212.227.15.18]:55067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfAISZF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 13:25:05 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZhoi-1h8t2k46JQ-00lS2v; Wed, 09
 Jan 2019 19:24:59 +0100
Date:   Wed, 9 Jan 2019 19:24:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anthony Sottile <asottile@umich.edu>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git add --intent-to-add + git stash "Cannot save the current
 worktree state"
In-Reply-To: <CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80PgR5NTQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901091922300.41@tvgsbejvaqbjf.bet>
References: <CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80PgR5NTQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sqlYwpauNR7gHjwQ54dbpoZBlNExJryr5MIMn4RHAIyuwlZc5/c
 JObRzC+loo7gncxdbiLAJbfn2AVG3I5Xr4p1xKrpUE5XOsAdkLA1I72Xx30DhCHvkaiNgL0
 Yj+dJulkTIsR8Szpl8TPdGj56qFRMfdsVqoL4idYtlf+1AyLAYrtvugX5xgfUiocBClmO67
 6KpG649ERXFLXAEZ7F6Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9Q5hZRTNCE=:cevGJNePy6s4flnzeC94kb
 7okbhNF5C1wLXgRm1+GAUajkmBLj9bAnpB9zVQNzI0EZvsMjcwuOnMdfqV8UIPgQm9wVnTXKK
 tbSLSpHGyNP3KUEI2WKLGT43W2dzi0UaRabrwsEvL4+dZlAULHXFiPNEnaY0yEjbx3SE2cRO5
 ab1kUMrd+TRHOMH/QXOcnHglNVg3oDa7Emn1NhnZe/jXyEAXnDUjbCisnO8Btm6sLMiiGp4yk
 VaLje06z1sRSDW8O46uxIy1jrT4vKthD5ljnhldWXTtdZuhhw+2mJ0AU+pLesCcOcKHWGf6mL
 bjxBVacrA3YZmtjSNLSAUdcWq0xRcDyyohYJwluDCBUA1jdh+KgPK41mGxWO6rwhhcJ82R9VI
 uYfKQrPC+tXaun4bdXS3Wav5LyRW7l7TKOkQPfhcJmrYyjqpcwvNFNpz6V+qeAV7P1/7nfSHB
 /qZw8KdUolL7CzXIoHsMvF7vrOLdKxjEf96e+Nzr/bJ4A1lFUMlzz1spxr2ug1MelMkkl2MZN
 i5/PBX99PsX7zbUu5+0XawyKFCWeX2ms6t3mgv0ojJ+us0fxO3OFlSm7/K1PYqBrQxCUYnWfx
 zoWppXeoCbTqIfersaFi6mbK7+w9dsxO5vYua0gIfQDc57gb3/UpG6qidPVoA3gbS/ttOMFTd
 eFEuKHbGg6LjfGqGssGBnfdHXqXlF/e+l9+0LsUQPIXHPp3HGKauFfL0VG2deOZGUCbzUATHZ
 kDXzyPJBgUDRzuUyQjcKo/RXdDTdTUjvoS9DS0x9Rc3EDZrYgB423S9TibV/UtDPh5p87sRt3
 VAhtjgL6ezRWqOu9LxeJPu3ro8jCF+BkmWY1ryCvDNas6zp+Jv0rDIdYAeaz+pbVtUuPa3Tqu
 qozI0vrZ8Dn/hpc6xMFIDe4uBaoqUF5APrwlD301+kWROZXycvICaY78pvLy5fbqCWVoZs/Ze
 49wMXrVjabQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Anthony,

On Thu, 3 Jan 2019, Anthony Sottile wrote:

> Minimal reproduction
> 
> ```
> git init t
> git -C t commit --allow-empty -m 'initial commit'
> touch t/a
> git -C t add --intent-to-add a
> git -C t stash
> ```
> 
> ```
> + git init t
> Initialized empty Git repository in /private/tmp/t/t/.git/
> + git -C t commit --allow-empty -m 'initial commit'
> [master (root-commit) 858132e] initial commit
> + touch t/a
> + git -C t add --intent-to-add a
> + git -C t stash
> error: Entry 'a' not uptodate. Cannot merge.
> Cannot save the current worktree state
> ```

Apparently it is even worse. On Windows, this reportedly resulted in a
segmentation fault:

https://github.com/git-for-windows/git/issues/2006

Could you cherry-pick the fix of
https://github.com/git-for-windows/git/pull/2008 and see whether it fixes
your use case, too?

Ciao,
Johannes

P.S.: Obviously, if this PR fixes the issue, the corresponding change
should be squashed into the appropriate commit in ps/stash-in-c.
