Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192ED1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeKMAHu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:07:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:52803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeKMAHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:07:50 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfiFU-1gACRF1Ebk-00N99G; Mon, 12
 Nov 2018 15:14:05 +0100
Date:   Mon, 12 Nov 2018 15:14:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 5/5] Makefile: Add a NO_INSTALL_BUILTIN_EXECDIR_ALIASES
 flag
In-Reply-To: <20181102223743.4331-6-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811121511500.39@tvgsbejvaqbjf.bet>
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-6-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1778378473-1542032045=:39"
X-Provags-ID: V03:K1:DuYzIdlFccBvZJ3tjKziVln7iDJwoAy5rbXaqxunip4/fgRnoez
 tQFZfVDXgQlPRCIySvub4ajEMeou6Pd3h4O36KeI5niDE9wK1LzIitKTvobipMjVyLKQVFn
 Xz/AljZWbN0byAzhR6mtNXQ2ouk7A3FVUZPTxZAxOpkkt1pCW+Pigl94hNnAqb4sHUmGM5I
 mmnd39jlyu915Od6ZV8bQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nIMNaV9ma6Y=:c4iujTWv3Gqhj52CGIwZNL
 QL8DZblb13fSMvezUw6Qq5bqID8w6A80+ryqADWn2C3UvqsaygNIlB5nsPKR1mmo39ykZKkLZ
 kOFZ5og/beg6cYRq0gH8HLGUuxC2kC/q9yjjox86DBsvsJjcuYnODedekhA2w4oPLDCDJo95L
 PrcLKygG3iNVjPgKNi74mDEJwsf7IosAdPpOHxL6WHUpvFvjII6yZRuRHFpUWKMWSzmOiCCcE
 wIn2c37IV43xvexFrV09zQUxbD8I5FyB663+BleqCoXGH7n6msNaUrs10a9KNg8Ukw8kGiWv2
 VFQzEYf+lQhg+e7Lme8wORTq4rviUWKP9BSqs628Ecw+1av0+NlZSvec5VDRu7hZ9eUa+oeIZ
 km6QMxGDjBpJlIcq1+QM7AL1nreojx24bvChxgdga2aIG6/KyzJDqpYkk5ftdg01jq17Xu/iw
 yPZoLp6/JhWTx3ODehikeZV7/rQVpBibisVtVnSUIV5/i2NxwlQGJNE7pdHTsbVos5zh5OhBz
 Q64yvbmxcsBegKBckIFLhdWubOqEL7/UAHY26tPozarvPESMka6GCdXEO99XsFDFEfRqmTfFK
 gptsy8RrTpPA6PIhN9JQ4nUMH8rqec43VgLQ6b0H1f54ezMCoVWemgT+ILeqBwmkWR4siMLAD
 MY2EVWTgtWM0UhS74l0LmwEk3w4Rcv3qA+Z2nk9fx1e9JgRkSyylhWyaEFsWwhL1uW1qnuDbA
 DtkYYgX44x0zZGgsMWQKfU/E52Am/sTLtzRn6w4o24DKXrc8R1+teA8CvrgddbIRPP/0fkuTA
 cBfqTCqK8/u9gGu+Qkk3hJiB2KJHwg/II/w6LyZ5Ekf/3ikwN1y/t0Z/VSTJwb14VdQOs5oec
 uBMCL1h+RMA0TaeXLMAxLtN4MP13hheCneaBlNttAs5GJ2ueUkuhu5OvIIIi+0jXCgkwWCiM1
 EqhLDJstyqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1778378473-1542032045=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Fri, 2 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> Back when git was initially written the likes of "git-add", "git-init"
> etc. were installed in the user's $PATH. A few years later everything,
> with a few exceptions like git-upload-pack and git-receive-pack, was
> expected to be invoked as "git $cmd".
> 
> Now something like a decade later we're still installing these old
> commands in gitexecdir. This is so someone with a shellscript that
> still targets e.g. "git-init" can add $(git --exec-path) to their
> $PATH and not have to change their script.
> 
> Let's add an option to break this backwards compatibility. Now with
> NO_INSTALL_BUILTIN_EXECDIR_ALIASES=YesPlease there's only 3 programs
> in the bindir that are hardlinked to "git" (receive-pack,
> upload-archive & upload-pack), and 3 in the
> gitexecdir (git-remote-{ftp,ftps,https} linked to git-remote-http).
> 
> There's no cross-directory links anymore, so the
> "NO_CROSS_DIRECTORY_HARDLINKS" flag becomes redundant under this new
> option.
> 
> 1. https://public-inbox.org/git/87woyfdkoi.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

I like the idea.

With my suggested refactoring that avoids the non-DRY code, this patch
would also become much simpler (as would 2/5 -- 4/5).

However, I would not call these "aliases". That's just confusing. Maybe
NO_INSTALL_DASHED_BUILTINS would be better? It certainly would not have
confused me.

Ciao,
Dscho

>  Makefile         |  8 ++++++++
>  install_programs | 36 +++++++++++++++++++++---------------
>  2 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 07c8b74353..a849a7b6d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -346,6 +346,13 @@ all::
>  # INSTALL_SYMLINKS if you'd prefer not to have the install procedure
>  # fallack on hardlinking or copying if "ln -s" fails.
>  #
> +# Define NO_INSTALL_BUILTIN_EXECDIR_ALIASES if you'd like to skip
> +# installing legacy such as "git-init" and "git-add" in the
> +# gitexecdir. Unless you're on a system where "which git-init" is
> +# expected to returns something set this. Users have been expected to
> +# use the likes of "git init" for ages now, these programs were only
> +# provided for legacy compatibility.
> +#
>  # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
>  # programs as a tar, where bin/ and libexec/ might be on different file systems.
>  #
> @@ -2823,6 +2830,7 @@ endif
>  		--flag-no-install-hardlinks="$(NO_INSTALL_HARDLINKS)" \
>  		--flag-no-cross-directory-hardlinks="$(NO_CROSS_DIRECTORY_HARDLINKS)" \
>  		--flag-no-install-symlinks-fallback="$(NO_INSTALL_SYMLINKS_FALLBACK)" \
> +		--flag-no-install-builtin-execdir-aliases="$(NO_INSTALL_BUILTIN_EXECDIR_ALIASES)" \
>  		--list-bindir-standalone="git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS))" \
>  		--list-bindir-git-dashed="$(filter $(install_bindir_programs),$(BUILT_INS))" \
>  		--list-execdir-git-dashed="$(BUILT_INS)" \
> diff --git a/install_programs b/install_programs
> index 51e08019dd..8d89cd9984 100755
> --- a/install_programs
> +++ b/install_programs
> @@ -33,6 +33,9 @@ do
>  	--flag-no-install-symlinks-fallback=*)
>  		NO_INSTALL_SYMLINKS_FALLBACK="${1#--flag-no-install-symlinks-fallback=}"
>  		;;
> +	--flag-no-install-builtin-execdir-aliases=*)
> +		NO_INSTALL_BUILTIN_EXECDIR_ALIASES="${1#--flag-no-install-builtin-execdir-aliases=}"
> +		;;
>  	--list-bindir-standalone=*)
>  		list_bindir_standalone="${1#--list-bindir-standalone=}"
>  		;;
> @@ -54,7 +57,7 @@ do
>  	shift
>  done &&
>  
> -if test "$bindir/" != "$execdir/"
> +if test "$bindir/" != "$execdir/" -a -z "$NO_INSTALL_BUILTIN_EXECDIR_ALIASES"
>  then
>  	for p in $list_bindir_standalone; do
>  		$RM "$execdir/$p" &&
> @@ -87,20 +90,23 @@ do
>  	fi
>  done &&
>  
> -for p in $list_execdir_git_dashed; do
> -	$RM "$execdir/$p" &&
> -	if test -n "$INSTALL_SYMLINKS" -a -n "$NO_INSTALL_SYMLINKS_FALLBACK"
> -	then
> -		ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p"
> -	else
> -		test -n "$INSTALL_SYMLINKS" &&
> -		ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
> -		{ test -z "$NO_INSTALL_HARDLINKS" &&
> -		  ln "$execdir/git$X" "$execdir/$p" ||
> -		  ln -s "git$X" "$execdir/$p" ||
> -		  cp "$execdir/git$X" "$execdir/$p" || exit; }
> -	fi
> -done &&
> +if test -z "$NO_INSTALL_BUILTIN_EXECDIR_ALIASES"
> +then
> +	for p in $list_execdir_git_dashed; do
> +		$RM "$execdir/$p" &&
> +		if test -n "$INSTALL_SYMLINKS" -a -n "$NO_INSTALL_SYMLINKS_FALLBACK"
> +		then
> +			ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p"
> +		else
> +			test -n "$INSTALL_SYMLINKS" &&
> +			ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
> +			{ test -z "$NO_INSTALL_HARDLINKS" &&
> +			  ln "$execdir/git$X" "$execdir/$p" ||
> +			  ln -s "git$X" "$execdir/$p" ||
> +			  cp "$execdir/git$X" "$execdir/$p" || exit; }
> +		fi
> +	done
> +fi &&
>  
>  for p in $list_execdir_curl_aliases; do
>  	$RM "$execdir/$p" &&
> -- 
> 2.19.1.930.g4563a0d9d0
> 
> 
--8323328-1778378473-1542032045=:39--
