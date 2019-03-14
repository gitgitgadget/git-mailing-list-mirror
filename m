Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E9F20248
	for <e@80x24.org>; Thu, 14 Mar 2019 14:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfCNO7M (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 10:59:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:50893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfCNO7M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 10:59:12 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI9n0-1h2mra0hDy-003z5x; Thu, 14
 Mar 2019 15:59:00 +0100
Date:   Thu, 14 Mar 2019 15:58:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] rebase: remove the rebase.useBuiltin setting
In-Reply-To: <20190314132444.25881-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903141544110.41@tvgsbejvaqbjf.bet>
References: <20190213142209.8226-1-avarab@gmail.com> <20190314132444.25881-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1960277247-1552575540=:41"
X-Provags-ID: V03:K1:i2CpgTdwh1PoU7YkqKo0H4TKOoHENh9regBE2SihbMpofKixpZ9
 WwPCKMkgRTUcqhKEe3orvgX8JBsyP3WQsHJo2Fi0poxjmfju4GVFVtiEeqS/g+cGlWmUYk8
 NrMRVXwpwGdaflCloi2keZAE2II9kQzeAq6M89+p6IVACvIivP9O3npSCrP8mlgr6P6Y8jF
 Xo4ii0hgzOC27cSkI6D7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nwIF/va868Q=:3ZYLsGnXU9084Zx1UjSbtU
 dBlFfAHwDAlb2kY4xtbWIJkLXJiEeG5hBEYedVR6+IvxSDuDxs3YR7RhgKPRRrmnF4JHdy60b
 YbwC3fg6Pvoe+TH5Hii/SYwd043wwN0PfMCYAriBaSquXL/FFmZz3Gy7Xojspc+nDCF6pi+SO
 3uhCxl1GgOAD9dy3c+Aly8pRqM0TrGV/GnF+NkxJ0KLw7T7hYN6eYjyirOia7vPEJPktDos2g
 DD4oyZkrRrncMwpTB2JekjTMQzF2qR/sy/AooGHU9FA5uU+o9LgTpuHtJfN4Tk1IqP62D6kpB
 Yv/KsmsJ20noNzoOJIlUqPiJRAHzEku/YuysHrP+xgF823hNhRkY2J7m3hP1Dn2wgouPmGV11
 34oxQNA/61Rm3WMqbsc8GwlzlfhGJAMQeINZn2RDzejvPrgXqMs47fW37uYZmg0jIJugFuRdk
 I42RgnztK/4r0AcIiEHSwgt0ArFlTgiSjF+USalYry9Q0FtKO2Ftikt9dXgqdWZ5mT+f6g/z4
 4nE1iBu7q7RbI1nDaR6MUbcDUhvwOea4VgEcEzfCT4Ay42izHU1Ye3PL6pk8te8FzEtqEWZhl
 Be/4hYNNuSOC6UEv44xsHlX0hdMMPMNUzuJLuZjfGsU0nLWtlxNOd8rcIZ2FnHvs/qIp0tYHp
 /H1rua9FpDwmd6WLjO54u5c5ogTr8j22Zgdz4g4A0rCDKexZgiuOzayHzaIUWtbjCVKYFYbM/
 W/4vDwhfZKZL88jThUVoVDkNrjkFZStpACmEKEdOAAQPQ5OmGm/ogV7Bp4Pe1pjkYdGLnp6Dv
 aM8irB1K0vX4odmT6Rl2EmQoOOUif795lqigLRzvBOwD+aZJW1C3UW4H4U5XNb/FXyyWcWhSh
 UuZps/vbRPE7CEjEHsWAb9rJWOYSnom13hn9Sv8qk/vaP808yyrQX7H8QKqeRuvTUk4OsbgTx
 Al66jUoxS8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1960277247-1552575540=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Thu, 14 Mar 2019, Ævar Arnfjörð Bjarmason wrote:

> Remove the rebase.useBuiltin setting, which was added as an escape
> hatch to disable the builtin version of rebase first released with Git
> 2.20.
> 
> See [1] for the initial implementation of rebase.useBuiltin, and [2]
> and [3] for the documentation and corresponding
> GIT_TEST_REBASE_USE_BUILTIN option.
> 
> Carrying the legacy version is a maintenance burden as seen in
> 7e097e27d3 ("legacy-rebase: backport -C<n> and --whitespace=<option>
> checks", 2018-11-20) and 9aea5e9286 ("rebase: fix regression in
> rebase.useBuiltin=false test mode", 2019-02-13). Since the built-in
> version has been shown to be stable enough let's remove the legacy
> version.

I agree with that reasoning. Elsewhere, a wish cropped up for the `git
stash` command to optionally ignore unmatched globs, and if we go about to
implement this, we will have to implement it in the scripted and the
built-in version. If we can at least avoid that for the `rebase` command,
I think it would make things a bit easier over here.

> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index 331d250e04..c747452983 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -1,16 +1,9 @@
>  rebase.useBuiltin::
> -	Set to `false` to use the legacy shellscript implementation of
> -	linkgit:git-rebase[1]. Is `true` by default, which means use
> -	the built-in rewrite of it in C.
> -+
> -The C rewrite is first included with Git version 2.20. This option
> -serves an an escape hatch to re-enable the legacy version in case any
> -bugs are found in the rewrite. This option and the shellscript version
> -of linkgit:git-rebase[1] will be removed in some future release.
> -+
> -If you find some reason to set this option to `false` other than
> -one-off testing you should report the behavior difference as a bug in
> -git.
> +	Unused configuration variable. Used between Git version 2.20
> +	and 2.21 as an escape hatch to enable the legacy shellscript
> +	implementation of rebase. Now the built-in rewrite of it in C
> +	is always used. Setting this will emit a warning, to alert any
> +	remaining users that setting this now does nothing.

Do we really need to document this? Why not just remove the entire entry
wholesale; the warning if `rebase.useBuiltin=false` is set will be
informative enough.

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 52114cbf0d..829897a8fe 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1143,21 +1143,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	};
>  	int i;
>  
> -	/*
> -	 * NEEDSWORK: Once the builtin rebase has been tested enough
> -	 * and git-legacy-rebase.sh is retired to contrib/, this preamble
> -	 * can be removed.
> -	 */
> -
> -	if (!use_builtin_rebase()) {
> -		const char *path = mkpath("%s/git-legacy-rebase",
> -					  git_exec_path());
> -
> -		if (sane_execvp(path, (char **)argv) < 0)
> -			die_errno(_("could not exec %s"), path);
> -		else
> -			BUG("sane_execvp() returned???");
> -	}
> +	if (!use_builtin_rebase())
> +		warning(_("The rebase.useBuiltin support has been removed!"));

A couple of thoughts about this:

- `use_builtin_rebase()` spawns a `git config`. This is a pretty expensive
  operation on Windows (even if it might not matter in the big scheme of
  things, as the couple of milliseconds are probably a mere drop on a hot
  stone compared to the I/O incurred by the recursive merge), and it was
  only done in that way to allow for spawning the legacy rebase without
  having touched any global state (such as setting `GIT_*` environment
  variables when a Git directory was discovered).

  Couldn't we rather move this warning into `rebase_config()`?

- The warning should start with a lower-case letter (why don't we have any
  automated linter for this? This is a totally automatable thing that
  could run as part of `make` when `DEVELOPER` is set, maybe just on the
  `git diff HEAD --` part, and maybe even generating a patch that can be
  applied; No human should *ever* need to spend time on such issues).

- That warning should probably talk more specifically about the scripted
  version having been removed, not only the option (which was actually not
  removed, otherwise the user would not see that warning ;-)).

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 3e73f7584c..0a88eed1db 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -311,4 +311,10 @@ test_expect_success 'rebase--merge.sh and --show-current-patch' '
>  	)
>  '
>  
> +test_expect_success 'rebase -c rebase.useBuiltin=false warning' '
> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN= \

Good attention to detail! I would have forgotten to unset that environment
variable.

> +		git -c rebase.useBuiltin=false rebase 2>err &&
> +	test_i18ngrep "rebase.useBuiltin support has been removed" err
> +'
> +
>  test_done
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index b60b11f9f2..1723e1a858 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -149,12 +149,10 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>  
>  test_expect_success 'rebase -x with empty command fails' '
>  	test_when_finished "git rebase --abort ||:" &&
> -	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> -		git rebase -x "" @ 2>actual &&
> +	test_must_fail env git rebase -x "" @ 2>actual &&
>  	test_write_lines "error: empty exec command" >expected &&
>  	test_i18ncmp expected actual &&
> -	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> -		git rebase -x " " @ 2>actual &&
> +	test_must_fail env git rebase -x " " @ 2>actual &&
>  	test_i18ncmp expected actual
>  '
>  
> @@ -162,8 +160,7 @@ LF='
>  '
>  test_expect_success 'rebase -x with newline in command fails' '
>  	test_when_finished "git rebase --abort ||:" &&
> -	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
> -		git rebase -x "a${LF}b" @ 2>actual &&
> +	test_must_fail env git rebase -x "a${LF}b" @ 2>actual &&

Not a terribly big deal, but I would have structured the patch (series) by
leaving this change to t3404 as a 2/2, as it is not technically necessary
to include those changes in 1/2 (if your goal is, as mine usually is, to
"go from working state to working state" between commits).

Thank you for keeping on the track with this,
Dscho

>  	test_write_lines "error: exec commands cannot contain newlines" \
>  			 >expected &&
>  	test_i18ncmp expected actual
> -- 
> 2.21.0.360.g471c308f928
> 
> 
--8323328-1960277247-1552575540=:41--
