Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903611F453
	for <e@80x24.org>; Mon, 21 Jan 2019 12:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfAUMH0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 07:07:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:57583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfAUMH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 07:07:26 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMjgF-1grJeG3KrH-008Z07; Mon, 21
 Jan 2019 13:07:23 +0100
Date:   Mon, 21 Jan 2019 13:07:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 28/76] diff.c: convert -B|--break-rewrites
In-Reply-To: <20190117130615.18732-29-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901211259170.41@tvgsbejvaqbjf.bet>
References: <20190117130615.18732-1-pclouds@gmail.com> <20190117130615.18732-29-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-875426389-1548072443=:41"
X-Provags-ID: V03:K1:E3Ev10DdxXtvmt4dw9t+oaL0Q21dELD5z44mR5kXudf5NwLyBdH
 A8Ayv8+xul5EdMZuESDPkgny70EWgm/TSEe1ERYRMugOQKvfP5LtC/fgJitkNgdonY3y2oN
 xHjXEeB9aJUD6ZssxPMl1Q8ZCaGof+t+bqrTAvVoQ2f7CEFWE0AvEvNJYUusXy9nx0bnn0g
 DscoTF8aV87wBEuU2vuRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w6lTRg+yGVo=:Uwp3QoWrZlPVPOVQ7ZNdkO
 f6x6XEktvRCD3i42/ALXkqp/W7G/o6LgatnAavgG3oSR8qnueaADsTvzZdBHM7tL4Lpr7nT0D
 BAeLOxur3KHEqUL2/lrcwO3p2nFOmquNAQfLKNWOqXtB/FZhzDOD7ahvoszUOLdoURsscAXlG
 KPyz5xsxLZ3YcbI7ONjA0xmhAn4tAHvnLEKiSOe/0wf3r5NFsF4C+q0qWz7xqvfERXuKtww59
 vk/EGVmEQQR+FcbZ6tC7IQ3ymJBuNmQd21Y599KbdFWZ2NGwoCO72RtTLO7NmPYej4cbuuGfp
 gu+JEU4XWlPCtmTex/0Cu9y1KU+m/xw8l9u6FnmqeuxEvRHUd447kesv6dKHMKqLEC3V9rkuv
 3xEb8ktbiRbTwyqzgvHaXfkS4GzHL7plj74dgcxNBusiGokcgouZbzZptQ6SA0zC+xO7VDD85
 d2ZImA9aM8+gUJ7CvFpv4nD5HnALRsDzyC+9kfzlJH6zzbKbOzJz/yt1WVjVubJAd+M8oFpXv
 QHm4ZkHWoJvrRBeTW37u2CWEgu15u/K67gUmJpMeIyLE2VhPjZ2BlZcBnrrO7PLOSmQXyUAub
 UDwQsr/+CIC47LYaGdAu5VNxx0N2hyRbBQ5DeKdixsBUGZQVE6Y7463+Z+MrocDOlGbJ3yR9o
 x4Bghoqv6TdZt/SRXk28maBeS4sdf0+ZX8wx35gbZTTnJlaaV7Q/Qpl8gTf/F/BRLaxMNl6yc
 05HBwXyNrYp176Ph7xPlaHjZqm0qPYGcpT7Oj9PYg//boBEVtDz4969+ya4SnP9mt72FewlM6
 2n0vva+xi69XNk4YRDZKQNIHM3FSD5zDDIzfe3VE7xIXimjn6obALKOEuCqAxX/UZUqJMeKPA
 6y4elCa9psw18+tmU8+3V28ncky8NMlmLS/rYRihjzYHjucbyvWFj3/Byk4wvDf+kkvZZz9g+
 YHPjZEcCIWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-875426389-1548072443=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

On Thu, 17 Jan 2019, Nguyễn Thái Ngọc Duy wrote:

> +static int diff_opt_break_rewrites(const struct option *opt,
> +				   const char *arg, int unset)
> +{
> +	int *break_opt = opt->value;
> +	int opt1, opt2;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	if (!arg)
> +		arg = "";
> +	opt1 = parse_rename_score(&arg);
> +	switch (*arg) {
> +	case '\0':
> +		opt2 = 0;
> +		break;
> +	case '/':
> +		arg++;
> +		opt2 = parse_rename_score(&arg);
> +		break;
> +	}

This code snippet is anywhere in the spectrum between smart, cute, clever,
hard to reason about, and difficult to validate. Granted, Git for Windows
SDK's GCC v7.3.0 seems to be able to figure out (somehow...) that this
does not leave `opt2` uninitialized. But Ubuntu 16.04's default GCC
version (which I believe is v5.3.1) is not.

And likewise, human readers have to spend way too much time thinking about
this. So I would strongly suggest to save everybody and their compiler
some time by squashing this in:

-- snip --
t a/diff.c b/diff.c
index 381259e987a5..855e6ddcb2b9 100644
--- a/diff.c
+++ b/diff.c
@@ -4949,16 +4949,13 @@ static int diff_opt_break_rewrites(const struct option *opt,
 				   const char *arg, int unset)
 {
 	int *break_opt = opt->value;
-	int opt1, opt2;
+	int opt1, opt2 = 0;
 
 	BUG_ON_OPT_NEG(unset);
 	if (!arg)
 		arg = "";
 	opt1 = parse_rename_score(&arg);
 	switch (*arg) {
-	case '\0':
-		opt2 = 0;
-		break;
 	case '/':
 		arg++;
 		opt2 = parse_rename_score(&arg);
-- snap --

Not only is the result a lot easier to understand and to reason about, it also
saves 3 lines.

Ciao,
Johannes

P.S.: Please do not send the entire 78 "re-rolled" patches my way, should
you choose to send another iteration of this unsplit patch series, but
just this one. TIA

> +	if (*arg != 0)
> +		return error(_("%s expects <n>/<m> form"), opt->long_name);
> +	*break_opt = opt1 | (opt2 << 16);
> +	return 0;
> +}
> +
>  static int diff_opt_char(const struct option *opt,
>  			 const char *arg, int unset)
>  {
> @@ -5014,6 +5039,12 @@ static void prep_parse_options(struct diff_options *options)
>  			       N_("specify the character to indicate a context instead of ' '"),
>  			       PARSE_OPT_NONEG, diff_opt_char),
>  
> +		OPT_GROUP(N_("Diff rename options")),
> +		OPT_CALLBACK_F('B', "break-rewrites", &options->break_opt, N_("<n>[/<m>]"),
> +			       N_("break complete rewrite changes into pairs of delete and create"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
> +			       diff_opt_break_rewrites),
> +
>  		OPT_GROUP(N_("Diff other options")),
>  		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
>  		  N_("Output to a specific file"),
> @@ -5047,12 +5078,7 @@ int diff_opt_parse(struct diff_options *options,
>  		return ac;
>  
>  	/* renames options */
> -	if (starts_with(arg, "-B") ||
> -		 skip_to_optional_arg(arg, "--break-rewrites", NULL)) {
> -		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
> -			return error("invalid argument to -B: %s", arg+2);
> -	}
> -	else if (starts_with(arg, "-M") ||
> +	if (starts_with(arg, "-M") ||
>  		 skip_to_optional_arg(arg, "--find-renames", NULL)) {
>  		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
>  			return error("invalid argument to -M: %s", arg+2);
> @@ -5331,17 +5357,14 @@ int parse_rename_score(const char **cp_p)
>  
>  static int diff_scoreopt_parse(const char *opt)
>  {
> -	int opt1, opt2, cmd;
> +	int opt1, cmd;
>  
>  	if (*opt++ != '-')
>  		return -1;
>  	cmd = *opt++;
>  	if (cmd == '-') {
>  		/* convert the long-form arguments into short-form versions */
> -		if (skip_prefix(opt, "break-rewrites", &opt)) {
> -			if (*opt == 0 || *opt++ == '=')
> -				cmd = 'B';
> -		} else if (skip_prefix(opt, "find-copies", &opt)) {
> +		if (skip_prefix(opt, "find-copies", &opt)) {
>  			if (*opt == 0 || *opt++ == '=')
>  				cmd = 'C';
>  		} else if (skip_prefix(opt, "find-renames", &opt)) {
> @@ -5349,25 +5372,13 @@ static int diff_scoreopt_parse(const char *opt)
>  				cmd = 'M';
>  		}
>  	}
> -	if (cmd != 'M' && cmd != 'C' && cmd != 'B')
> -		return -1; /* that is not a -M, -C, or -B option */
> +	if (cmd != 'M' && cmd != 'C')
> +		return -1; /* that is not a -M, or -C option */
>  
>  	opt1 = parse_rename_score(&opt);
> -	if (cmd != 'B')
> -		opt2 = 0;
> -	else {
> -		if (*opt == 0)
> -			opt2 = 0;
> -		else if (*opt != '/')
> -			return -1; /* we expect -B80/99 or -B80 */
> -		else {
> -			opt++;
> -			opt2 = parse_rename_score(&opt);
> -		}
> -	}
>  	if (*opt != 0)
>  		return -1;
> -	return opt1 | (opt2 << 16);
> +	return opt1;
>  }
>  
>  struct diff_queue_struct diff_queued_diff;
> -- 
> 2.20.0.482.g66447595a7
> 
> 
> 
--8323328-875426389-1548072443=:41--
