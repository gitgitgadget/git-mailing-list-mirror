Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0021F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeKNFXg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:23:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:47467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeKNFXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:23:36 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIQlv-1gKjPx3DGJ-004FPn; Tue, 13
 Nov 2018 20:24:02 +0100
Date:   Tue, 13 Nov 2018 20:24:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tanushree Tumane <tanushreetumane@gmail.com>
cc:     avarab@gmail.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v4] commit: add a commit.allowEmpty config variable
In-Reply-To: <20181113155656.22975-1-tanushreetumane@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811132021390.39@tvgsbejvaqbjf.bet>
References: <87d0rm7zeo.fsf@evledraar.gmail.com> <20181113155656.22975-1-tanushreetumane@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AEKsovnfn01OcD4/hglaKYMvNoZqX2z/Cn9sRlrqY6BPX6F2O+3
 Tx/jTcaD1nbKnY+fFAeFMpeAo0A4crDdGfIi/yKUMolsSCRvjKgBXft8mhMU7cscHaEVQJS
 lmKB2IUpTRJHHolyFTMC2WwDogsP4lJFcBDQaWLOZaVE3qpiSHV2xWatKRskS4uNHDVgHvU
 l25vQQeZ0AhgwOj59f73A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zY/1TfXK24w=:dpOm1sFby1vEqKzCeFzsfp
 7pq6AJt3OazHy1u/UPtzlKniwSa9f3Epn/gkHHzbNuiAai6Ln9xK/TRsKROax7AqPoDnPQ7B8
 10E3ZKrkG+hm6NweGW++65B4C5tkQNjPTPnTHjodeBWCSgzilJXstNMWyGTIFgCAmOKwRgX8X
 SZUKpG3p/waBOy6M6dCyHEXhmUH/Rh2+fkoTuNk/tlkx02t7+4U7CKOE+zjRKcl8H2tgkta2z
 z7a+nmaL+HwgwzAlA+B4VPNVPF5Uv5noAPLfUQyF35gtZderYVRt3vBXxhPzWxqaKD+AisVM9
 ojNbWT7qd14jpycK90TN4XSR5mDlJ7w6KDn5PbYLxkGjfjq6L6OtL5vupK5zjHPqrNX7RKLsd
 3xYN8teJ6vcyGxWJAhzKSTkOmpLjdekwecV0Xu0+Gq19W4SuckpKPr5dtRkC03Kk5Rk8dbuq5
 QYMpSlnXWjWtKIQhVt6r74AFGRP10DgBPups6v70UBz64X7Mf3AA3vDTRH7gDzUyhihLpkMhI
 6AukKkC6rnBfzrXA9Ee8iPsYxy5SW0JMiIY7TEU8IKl6gzlOfP5Q3YU2OvqgnTWxkAUC9Q4dI
 5pHbE1JD9U6ylfECHV/gn+w3B7ECmZKaJTRnsG5IOMoxrEA2+QTLa/bucTbtW2/BLCZXrtPen
 gRf/nc4M9hJu2ZX1PVY8Nh4uX3rYgHFoWQ9mn5cuvYzLM8gELfyW7jd8ecq3bCBZdvj7lEIE5
 1/3Ac7s10TYX1Ap3BLirUm5AsKza2/uSy57kIIySOiqfHBZhiemmXjM9kFNGAtWs3iSK0obTc
 HUC9qCetL3CGPmKf3T1igF+ohVwWEsp6j23ji72LPVBJmv2a8tKbEBdrOBMCsMRydAsVVkcKw
 yWAYEU3x2lpPga/PvttI0qyXrc3dJNrKN8laThOx2qblO4UkZCbB7HGWyOe9v5rG8+nsFgPWZ
 C/J88A1jwTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 13 Nov 2018, Tanushree Tumane wrote:

> From: tanushree27 <tanushreetumane@gmail.com>
> 
> when we cherrypick an existing commit it doesn't change anything and
> therefore it fails prompting to reset (skip commit) or commit using
> --allow-empty attribute and then continue.

This is a nice paragraph, but it might make sense to connect it to the
commit's oneline somehow. I, for one, was surprised to see the oneline
talk about `git commit` and the commit message about `git cherry-pick`.

I could imagine that an introductory paragraph, talking about why one
might want to commit empty commits, might be the best lead into the
subject, and the paragraph about `cherry-pick` could follow (and be
introduced by saying something along the lines that this config setting
has more reach than just `git commit`; it also affects `git cherry-pick`)?

Ciao,
Johannes

> 
> Add commit.allowEmpty configuration variable as a convenience to skip
> this process.
> 
> Add tests to check the behavior introduced by this commit.
> 
> This closes https://github.com/git-for-windows/git/issues/1854
> 
> Signed-off-by: tanushree27 <tanushreetumane@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> ---
>  Documentation/config.txt     |  5 +++++
>  Documentation/git-commit.txt |  3 ++-
>  builtin/commit.c             |  8 ++++++++
>  t/t3500-cherry.sh            | 10 ++++++++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c0727b7866..f3828518a5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1467,6 +1467,11 @@ commit.verbose::
>  	A boolean or int to specify the level of verbose with `git commit`.
>  	See linkgit:git-commit[1].
>  
> +commit.allowEmpty::
> +	A boolean to specify whether empty commits are allowed with `git
> +	commit`. See linkgit:git-commit[1]. 
> +	Defaults to false.
> +
>  credential.helper::
>  	Specify an external helper to be called when a username or
>  	password credential is needed; the helper may consult external
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index f970a43422..5d3bbf017a 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -176,7 +176,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>  	Usually recording a commit that has the exact same tree as its
>  	sole parent commit is a mistake, and the command prevents you
>  	from making such a commit.  This option bypasses the safety, and
> -	is primarily for use by foreign SCM interface scripts.
> +	is primarily for use by foreign SCM interface scripts. See
> +	`commit.allowEmpty` in linkgit:git-config[1].
>  
>  --allow-empty-message::
>         Like --allow-empty this command is primarily for use by foreign
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 67fa949204..4516309ac2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -101,6 +101,7 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
>  static int edit_flag = -1; /* unspecified */
>  static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
>  static int config_commit_verbose = -1; /* unspecified */
> +static int config_commit_allow_empty = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit;
> @@ -1435,6 +1436,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
>  		return 0;
>  	}
> +	if (!strcmp(k, "commit.allowempty")) {
> +		config_commit_allow_empty = git_config_bool(k, v);
> +		return 0;
> +	}
>  
>  	status = git_gpg_config(k, v, NULL);
>  	if (status)
> @@ -1556,6 +1561,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	if (verbose == -1)
>  		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
>  
> +	if (config_commit_allow_empty >= 0)  /* if allowEmpty is allowed in config*/
> +		allow_empty = config_commit_allow_empty;
> +	
>  	if (dry_run)
>  		return dry_run_commit(argc, argv, prefix, current_head, &s);
>  	index_file = prepare_index(argc, argv, prefix, current_head, 0);
> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> index f038f34b7c..11504e2d9f 100755
> --- a/t/t3500-cherry.sh
> +++ b/t/t3500-cherry.sh
> @@ -55,4 +55,14 @@ test_expect_success \
>       expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
>  '
>  
> +
> +# Tests for commit.allowEmpty config
> +
> +test_expect_success 'cherry-pick existing commit with commit.allowEmpty' '
> +    test_tick &&
> +	test_commit "first" &&
> +	test_commit "second" &&
> +	git -c commit.allowEmpty=true cherry-pick HEAD~1
> +'
> +
>  test_done
> -- 
> 2.19.1.windows.1.495.g7e9d1c442b.dirty
> 
> 
