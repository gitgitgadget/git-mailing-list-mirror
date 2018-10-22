Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1131E1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 12:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeJVUad (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 16:30:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:50101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeJVUad (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 16:30:33 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9sa0-1gL7a81o9w-00B24S; Mon, 22
 Oct 2018 14:12:12 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9sa0-1gL7a81o9w-00B24S; Mon, 22
 Oct 2018 14:12:12 +0200
Date:   Mon, 22 Oct 2018 14:12:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] completion: use __gitcomp_builtin for format-patch
In-Reply-To: <20181021084102.8318-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810221411220.4546@tvgsbejvaqbjf.bet>
References: <20181021084102.8318-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1800519408-1540210335=:4546"
X-Provags-ID: V03:K1:kSWwR6tyMh5iFSu2THLfSxsxMlnWygYjEXwUj+Gi4PWyRt7wNtW
 Rmn6WVOzvvt6Oe+XLEEaYbD5UgmOMBbeKfo3NwgatavjE0cEcs3PVNJtUJidcaFi+vevPpF
 AX2qsfwrJvWoP5kEnf76sDp/Cf3Vy+f2pG+2PI+JbV2N/1ZV2BjkXnb1AkOgmxXF2+QvaWO
 8yb14qV9Saf21qIp9EMQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SHbNchD+84Q=:KCfn5T+638BB6QVv52zMSe
 4O33LNoUO96qU2z9K6VXYL+xPR5rDQ2FI7bhoomfZSFq/VJVYpjs4eu1XwOyB9eDcVp2/MO7n
 tuxgWkACPiyr+e2B8M/dNGh2kfEO3XLTeltS7v4WW7x7u+novEs4YwniAU8Sldzh6SHaTPj9z
 UPMbdwSueYae05eJKwpiz6tca7dplRxTXx0m2aKvv/9ml4ZWnCEU+NZki5IR5wmurnpZc4Y4q
 aJyijR+oFHFGk4HvZ/kARlfrexE3rcNjzIWNiQwahTPgflUQikvvbxmmDYh6AidJfqkkZitfP
 ePW26edfwkcriqeD4+MgV8f6BLB1jVAkC56a24TFI3EaI8/6WuuucYwns6MORVRMAW89X6FLv
 jhSl1fEGSPRC83w5m19TPDbWz0fVVXB9IvaOkrrKtq7oNaMZvlUHqQxSu1nqfwi9e9l9A1lq4
 jlkZBpf1nsHp4F+DOGThXoVNHLGRH/GQMCEazKig6TMvuKXN0uItcv/4VWU3hSjhkpnC44u2n
 c6olR/lu67IehOvVaCKg2yMRDZbcwnFml/7WtV4FtWu9yVc5su4s+MDI1951CrNAAc3sLB0SR
 5wNOVXb/r72k1x0H5gbTxTRf9Bu+pUgsTSuSGxuXO4+YYzhdqqVCAKCcB1/ET530fnHABSya6
 K6DyKHfiQXMYMssHeiZH5zEs0gNxcO9CX5i7Mi8gw0kQUrltzx5vdKcwhhh9rb8n6leKhbuQ0
 7G1JdZoP4WTitdiezWlEN1TBSZS3NceU/+vHeHK2OpyLrfX6/jYOcGFDrH4+4r8NEkS5nANeI
 z+aFyFQ4WExRqCGpdftqE5dqRa2Yex/lsQP2MKm5sLMRXTou8o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1800519408-1540210335=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

On Sun, 21 Oct 2018, Nguyễn Thái Ngọc Duy wrote:

> This helps format-patch gain completion for a couple new options,
> notably --range-diff.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Of course it will be even better if I could complete the ref for
>  --range-diff=, but maybe another day.
> 
>  contrib/completion/git-completion.bash | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c8fdcf8644..065b922777 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1533,12 +1533,8 @@ _git_fetch ()
>  }
>  
>  __git_format_patch_options="
> -	--stdout --attach --no-attach --thread --thread= --no-thread
> -	--numbered --start-number --numbered-files --keep-subject --signoff
> -	--signature --no-signature --in-reply-to= --cc= --full-index --binary
> -	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
> -	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
> -	--output-directory --reroll-count --to= --quiet --notes
> +	--full-index --not --all --no-prefix --src-prefix=
> +	--dst-prefix= --notes
>  "
>  
>  _git_format_patch ()
> @@ -1551,7 +1547,7 @@ _git_format_patch ()
>  		return
>  		;;
>  	--*)
> -		__gitcomp "$__git_format_patch_options"
> +		__gitcomp_builtin format-patch "$__git_format_patch_options"

Is it just me, or does this fail t9902 for you, too, where it wants to
complete the --cover-letter option for *send-email* (not for
*format-patch*)?

See e.g.
https://git-for-windows.visualstudio.com/git/_build/results?buildId=22023&view=logs

Ciao,
Dscho

>  		return
>  		;;
>  	esac
> -- 
> 2.19.1.647.g708186aaf9
> 
> 
> 
--8323328-1800519408-1540210335=:4546--
