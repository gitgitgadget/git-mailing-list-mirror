Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FE31F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfAQUK4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:10:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:57893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbfAQUK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:10:56 -0500
Received: from [10.49.182.9] ([95.208.59.83]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5a9E-1h8F8Q29No-00xZir; Thu, 17
 Jan 2019 21:10:54 +0100
Date:   Thu, 17 Jan 2019 21:10:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 76/76] am: avoid diff_opt_parse()
In-Reply-To: <20190117130615.18732-77-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901172104380.41@tvgsbejvaqbjf.bet>
References: <20190117130615.18732-1-pclouds@gmail.com> <20190117130615.18732-77-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-407093310-1547755854=:41"
X-Provags-ID: V03:K1:2i3VkGfxv+/on3jFIswGRcCR+V7YDUGeRPPrswrU2DH4FqAcUoD
 NHmAHMR8t/i221JdLCe90OybSSFz+FG54qVnjdQe/f4oSdt368+VJoCzboZEelF2BQJgtzO
 tHRAt3YTvL4bopg9gzjl4ParrEL+xLXQg20ETKXvigyeSsH4EtieEQEbtetmJxIr/VtKLbZ
 z/QT0iFm5x9i7MKCzpDPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bhNtDNd4Or4=:0y364qoPBBQ5K5BHtD+KPL
 r6GR0neZEodlWaE3G0XZy53lqtS+qRT2T8Hu6BF4H8CMOoJghWWWF+YgZjRwXS9C+aFCvTP43
 6Fi9y0AxT9eIHcj2mjmD53cLIYlrEyONGEsJFKAzXVAuO5hLjTxcOjq0RB3TBbwnJt6yIWXEA
 /WGmaKpOP0UcB/mVEiIo4S0vQwGM/Kn4Y4aXJEGRUYXXU+8ccjPosId5nRiC7aBE71mFiPnWi
 KLlCo+qd3mw+/cqtEauBTFxz4UFQ23mRpj7b46+wWD+hTTu2cRYOo5Sw0EHTuygyfJERrCg/V
 CXt24GZdoFunraDkuLxti5ewgw67UxL9exuozuMfQ4rCKHh56ugRdUlixEf4N0scuqzCuk7L/
 I6eIUv3NFnycxZeja1OlUG/7ccLUSdqkCaDpBQB9oyPj14okNISW0hyedbRvEmm5Vnd7yDYCC
 ADYvHLLUcDQBGpatdK40/jmDAqFJK5FMLYgd57XbF8a58236/GWus4B6RAAuIAz/rqxLkPHLY
 3qa5D99/IE0nYEvpgI1dO+u/OuTW2TnlwC45SK6vlX9hBFEZ4wOmKMVUf2ZOWUxQ7JKi+0rZj
 w1KVKN68p8SPhP7GB2J1YykXZbTL8QcxP4JClpFTFoUoXMMyc/hVfnzLrw+RdYfCTCmSSEo+t
 R3j4VVGabaaNbgoZZB33NldR/qtVEQEogRTa1w9+eiyjcO5zsj+I6ujheYC5/G5/kJPGogsWc
 AuXLBakfnKXDep7nkDl8X6awYykzaVORrzvr9xLk7tHTZfbtlHIxReli7ZoguGUdhhLlbfgJx
 2DMMmoC4LYk9W4fze3/61WVqbg7838vNY/ja0mkzDE9AIQTz4sHEiI08o/UTMxoRONumYv8ai
 wVgfXCIjvQx/+UAVWolYYhQ9Sj1z1VN04ttbMVoUwIBoQgGZfisYGgpFz1ejtU9Xaf418s8eY
 aUVyEqNA2LQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-407093310-1547755854=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

the change itself looks good, but...

On Thu, 17 Jan 2019, Nguyễn Thái Ngọc Duy wrote:

> diff_opt_parse() is a heavy hammer to just set diff filter. But it's
> the only way because of the diff_status_letters[] mapping. Add a new
> API to set diff filter and use it in git-am. diff_opt_parse()'s only
> remaining call site in revision.c will be gone soon and having it here

... "will be gone soon"? Does that mean that you mail-bomb another mega
patch series iteration once you did that, now sending 77 or 78 patches?

I don't know about others, but I can only afford to spend a fraction of my
waking hours on reviews, and even back when Christian sent the built-in am
as a loooong patch series it was *already* a big problem. Thankfully he
seems to have decided to never do that again.

It would probably make sense to break your 76-strong patch series down
into at least four separate patch series, they would still be as long as
my Azure Pipelines one (which is longer than I am actually comfortable
with, but in my case, it was necessary, while your patch series consists
of many, mostly independent patches that could even be wrapped into
individual patch series of 1 or 2). It's just way too much to review if
you present it in the current manner.

Ciao,
Johannes

> just because of git-am does not make sense.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/am.c | 4 ++--
>  diff.c       | 6 ++++++
>  diff.h       | 2 ++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index 95370313b6..0cbf285459 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1515,11 +1515,11 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
>  		 * review them with extra care to spot mismerges.
>  		 */
>  		struct rev_info rev_info;
> -		const char *diff_filter_str = "--diff-filter=AM";
>  
>  		repo_init_revisions(the_repository, &rev_info, NULL);
>  		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
> -		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
> +		rev_info.diffopt.filter |= diff_filter_bit('A');
> +		rev_info.diffopt.filter |= diff_filter_bit('M');
>  		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
>  		diff_setup_done(&rev_info.diffopt);
>  		run_diff_index(&rev_info, 1);
> diff --git a/diff.c b/diff.c
> index daccc8226f..b8e58e817b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4756,6 +4756,12 @@ static unsigned filter_bit_tst(char status, const struct diff_options *opt)
>  	return opt->filter & filter_bit[(int) status];
>  }
>  
> +unsigned diff_filter_bit(char status)
> +{
> +	prepare_filter_bits();
> +	return filter_bit[(int) status];
> +}
> +
>  static int diff_opt_diff_filter(const struct option *option,
>  				const char *optarg, int unset)
>  {
> diff --git a/diff.h b/diff.h
> index 03c6afda22..f88482705c 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -233,6 +233,8 @@ struct diff_options {
>  	struct option *parseopts;
>  };
>  
> +unsigned diff_filter_bit(char status);
> +
>  void diff_emit_submodule_del(struct diff_options *o, const char *line);
>  void diff_emit_submodule_add(struct diff_options *o, const char *line);
>  void diff_emit_submodule_untracked(struct diff_options *o, const char *path);
> -- 
> 2.20.0.482.g66447595a7
> 
> 
--8323328-407093310-1547755854=:41--
