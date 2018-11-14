Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C0C1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 15:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbeKOBkw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 20:40:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:60003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733039AbeKOBkv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 20:40:51 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoE4f-1fqOUD2zmL-00gG8s; Wed, 14
 Nov 2018 16:36:56 +0100
Date:   Wed, 14 Nov 2018 16:36:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stephen & Linda Smith <ischis2@cox.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 0/3] range-diff fixes
In-Reply-To: <20181113185558.23438-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811141636350.39@tvgsbejvaqbjf.bet>
References: <xmqqftw73r9a.fsf@gitster-ct.c.googlers.com> <20181113185558.23438-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2105854692-1542209816=:39"
X-Provags-ID: V03:K1:h1oNnk1y39SKwrAcW/tVmcQkJqQF96KLwa/2dqtqmrccn2uzlr8
 +Wrzg8eUlwyTOl6Ikg7YQzSGqJGQp8gmT8GWVqqizkMvBFh0sBIfQQfC7Le3O0/n05sR8dl
 57MwWVBst8/ocKV9d2v2la2Pf9djcHv4HJtVOnUD3zEO8F2CcZJT8nsvWyWmWhcYdYB6ZoE
 D+5skrbxF7eZ4ZQgKd3Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ws5HzKZE0SI=:xD/Ndzg5biCuASBGRi/kFw
 ONnmswyWgO+NjPSpyVHjJuPAQS7pq1zOH/BMszyMjWBEkTdqAP92Nnc2IZ0KKY5HIYTwy3aG1
 k4N1+q0f1LY07bo9sDHb1fS9Dv2ELKNsqrbyGJZT/yl5m1QfQ8MHxX+rWCrr2eFsYER4ajyFw
 5RT6amRtJaB+R0ImDHYd9bbW7O8c0loLbsE9JeHEw3x6oCOF7f6kXvdwOKPEpm3Gxp2nW9ltJ
 s1x6CtKXLfKBBOTmNxFX44KxA/8B/7qHZnVgRFaaZbqjiyxK6U4T/mPesLDRkNFiq4KSKmzbX
 oKmrHT0oBSFMGLXR6QcTkptp65acaSo3+Z6BHiWOx9MQCjJSUsoRw7+1rkdH5UYy06M29ppEm
 OG/w8bi5OBDB6CyQC2UybIc0zo3u/4eAX6sHE+meCCKQxbdAX+5Lqqk+V+/jenqdnh/Q+6Vtu
 FiYwdREjmhQerIEqn43L3yIl/Wt6lliThS6yIBwviIOr8eKgdrjF6FIIa5FIgxwZRyTLJK5rY
 0E4pkpyiuCy31BUwumE3xXJ3EjP7F3lH69qwVIi2qkslLxeLnedS6bfPx+H8hpFyIYxCFpki+
 9vimaO7pUcbSXKRFww81EN5KNcLRJ9rc3r6Xz0+4ctAAnJPGIGeb9AkDTR9uWmPIll9UJDSaG
 c/06MFfoMuhwPgd0cw4kNgXfCtFg6sGnFrqW6UkL7mplJnbwhQI4kQBJaeOrfFYEnRc2gFt8O
 +0K5sgBrJ8/Z6/OnBFxh27/h3XG0Lw+iLBoy5xEox9kj1FD08dndY/WuLjkLQyjiZGdGj0dpa
 l3eVHlGDiDYDSfxb+5v1a3BiwCgMdA9+g7FplFVq8qk3J24JCBQcumV9ve1Sq+n7wKsUkqmnQ
 DKfBpVSsilFh5BZVHk8b1ZCt/3bSyB6Oa826i+9bJmoehgCNAnahZ11jMoyWjxXb+QG/C5TF6
 UgJDzkdDgyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2105854692-1542209816=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Tue, 13 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> Trivial updates since v4 addressing the feedback on that
> iteration. Hopefully this is the last one, range-diff with the last
> version:

This range-diff looks good to me.

Thanks,
Dscho

> 
> 1:  5399e57513 = 1:  f225173f43 range-diff doc: add a section about output stability
> 2:  e56975df6c = 2:  77804ac641 range-diff: fix regression in passing along diff options
> 3:  edfef733c7 ! 3:  ed67dba073 range-diff: make diff option behavior (e.g. --stat) consistent
>     @@ -17,8 +17,8 @@
>      
>          But we should behave consistently with "diff" in anticipation of such
>          output being useful in the future, because it would make for confusing
>     -    UI if two "diff" and "range-diff" behaved differently when it came to
>     -    how they interpret diff options.
>     +    UI if "diff" and "range-diff" behaved differently when it came to how
>     +    they interpret diff options.
>      
>          The new behavior is also consistent with the existing documentation
>          added in ba931edd28 ("range-diff: populate the man page",
>     @@ -36,7 +36,7 @@
>       		memcpy(&opts, diffopt, sizeof(opts));
>      -		opts.output_format |= DIFF_FORMAT_PATCH;
>      +		if (!opts.output_format)
>     -+			opts.output_format |= DIFF_FORMAT_PATCH;
>     ++			opts.output_format = DIFF_FORMAT_PATCH;
>       		opts.flags.suppress_diff_headers = 1;
>       		opts.flags.dual_color_diffed_diffs = dual_color;
>       		opts.output_prefix = output_prefix_cb;
>     @@ -45,6 +45,12 @@
>       --- a/t/t3206-range-diff.sh
>       +++ b/t/t3206-range-diff.sh
>      @@
>     + '
>     + 
>     + test_expect_success 'changed commit with --stat diff option' '
>     +-	four_spaces="    " &&
>     + 	git range-diff --no-color --stat topic...changed >actual &&
>     + 	cat >expected <<-EOF &&
>       	1:  4de457d = 1:  a4b3333 s/5/A/
>       	     a => b | 0
>       	     1 file changed, 0 insertions(+), 0 deletions(-)
> 
> Ævar Arnfjörð Bjarmason (3):
>   range-diff doc: add a section about output stability
>   range-diff: fix regression in passing along diff options
>   range-diff: make diff option behavior (e.g. --stat) consistent
> 
>  Documentation/git-range-diff.txt | 17 +++++++++++++++++
>  range-diff.c                     |  3 ++-
>  t/t3206-range-diff.sh            | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> -- 
> 2.19.1.1182.g4ecb1133ce
> 
> 
--8323328-2105854692-1542209816=:39--
