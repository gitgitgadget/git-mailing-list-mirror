Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F7E1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 07:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfBAHmn (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 02:42:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:56089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfBAHmn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 02:42:43 -0500
Received: from [10.10.1.35] ([195.130.156.138]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbOrg-1gYuWP3kqC-00ImdD; Fri, 01
 Feb 2019 08:42:37 +0100
Date:   Fri, 1 Feb 2019 08:42:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: align the longest command in the command listing
In-Reply-To: <20190131092349.11469-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902010842010.41@tvgsbejvaqbjf.bet>
References: <20190131092349.11469-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-660390214-1549006957=:41"
X-Provags-ID: V03:K1:Imt4eFmnWVhtfV8Fgxqdob5v5JUePDzE041UnYvTUF2x6L8mc42
 pzi6FZH3y6aGD/Kvl920sWxw4KPJeLa96VIkM2Z24/xeL6+W89/COMk6a5qdzGwjDfP2je+
 QE+RqVxitgur2w1CAgASEhpwHCsryESsihKh3Im3ECyVmSKHKGlf4etaFVW48gA40HTqpPy
 cvQEz/FbBMrDwjcHus5Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rovvL6Qnt1k=:449jjR3cvcQa9GXL7itpEm
 XGwQ9ZAbEy1FZEYHwVlUuxwAGV2yll5TxmdU/LiZg16EAX5GQrjpEV8BFzt4n3M0b3Wrw25Ao
 gPdlp1IBe0Glv1n5Pbk9XwjBgOkM3ihK0jhIUGGLpjRRzfZdIbHEnw2HnhXqokTq8AgrhwCcF
 4ufQtYs6wESY/FRS5CzXYZ4M5m/h/xq2+Qnzb0t+JW6oq7EAdBg7zd/NmfdOsofJyw6AJtilY
 2jkasU29rF+XjRZkQaFZCNN/wCu6YM55mDvNHtrzhn1yhIedRwiO7EDeVAl0B4NWk9BAGZpkx
 DPBmAz1NLuqx8LOWjn+qvNHwnLk+kXAH+UdW256tKB6NU9d+pTXzTx00BLGCajsPlgVGiFUgv
 Yyj8Hm/ip5uC1TfgLkkbdVNyHFi8REKuEpV6BuXEWxHCS91fmuKetv1ShKE9WY0/Rz0s8OWah
 XtDpPS7GH9k3/Bk0noVC/FFF014i8u2l2ZyjT0E2ugvwXMu5iXJAC26xWoxG9ePic1ju3SZG/
 xbc4JTNRTjSNjM9769bm+G1GDwXxwb9jupfz7jqQfDlcWkiAOj1fAfw2jFJIwMBSPgpttKkKo
 Umt4eKDlXVq04cD8fLRS3lIwt7e+ASo5irejBiUDuUJb9lRZKvkLOuVgUszCgUngymTDq3bk9
 FkxkFZgbVMoz7c9tXynNWzhSZbzg4ojEic6HvoOzdqD3YZrDzZXN/271/3V9g4Kn7H2tL1Nff
 bDyaXJ+V55AhmppPtyh4yMgWX8TPUOpaJOwkZtJhMCEyks+DxsSrqOpPbRNuVat0Dt2SOsgDA
 lk+RGexcUJ4LUCBPduNORkdhx0vsMwWNBxH0foBrdfVe0G3xnCc7caSpLf6f8utgxw+UX2N5i
 2RZkuNT5qQz57okItDBLgZJy8XVHVR43KlqNrsbIIss/LbCBku4qTqxm8cbJFJQlUS5LuVYYs
 n6tkd546MxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-660390214-1549006957=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

On Thu, 31 Jan 2019, Nguyễn Thái Ngọc Duy wrote:

> "longest" is used to determine how many extra spaces we need to print
> to keep the command description aligned. For the longest command, we
> should print no extra space instead of one, or we'll get unaligned
> output like this (notice the "checkout" line):
> 
>     grow, mark and tweak your common history
>        branch     List, create, or delete branches
>        checkout    Switch branches or restore working tree files
>        commit     Record changes to the repository
>        diff       Show changes between commits, commit and ...
>        merge      Join two or more development histories together
>        rebase     Reapply commits on top of another base tip
>        tag        Create, list, delete or verify a tag ...
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  help.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/help.c b/help.c
> index ff05fd22df..520c9080e8 100644
> --- a/help.c
> +++ b/help.c
> @@ -85,7 +85,8 @@ static void print_command_list(const struct cmdname_help *cmds,
>  		if (cmds[i].category & mask) {
>  			size_t len = strlen(cmds[i].name);
>  			printf("   %s   ", cmds[i].name);
> -			mput_char(' ', longest > len ? longest - len : 1);
> +			if (longest > len)
> +				mput_char(' ', longest - len);

Why not simply replace the `1` by `0`?

Ciao,
Dscho

>  			puts(_(cmds[i].help));
>  		}
>  	}
> -- 
> 2.20.1.682.gd5861c6d90
> 
> 
--8323328-660390214-1549006957=:41--
