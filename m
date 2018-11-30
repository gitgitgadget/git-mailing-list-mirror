Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDFF211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 18:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLAGCc (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 01:02:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:59055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLAGCc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 01:02:32 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUoma-1h11ff2FcS-00YAis; Fri, 30
 Nov 2018 19:52:15 +0100
Date:   Fri, 30 Nov 2018 19:52:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ralf Thielow <ralf.thielow@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/rebase.c: remove superfluous space in messages
In-Reply-To: <20181130181145.13539-1-ralf.thielow@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811301951190.41@tvgsbejvaqbjf.bet>
References: <20181130181145.13539-1-ralf.thielow@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MftJxIw5DptFIcy17sLoW/5+w6WD6unBGfCwZNuCWHiCb/J7Zx0
 RSvKVyMNbgj0IggXqvd7ChJZlDekROlQagMjASUAebR0g5Tj9OPMJ9eRDr0ccvh8H/Gni80
 Q0f1CLx9uPcA4M8qs1CtgtU8RSVs9KShmN//yR/X5jH/DTqDc5UJvELZNy7bvNpdjXBOPYG
 HukGfTF4d5PpF3bSdIXqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WqZ+FiwDoLk=:Sa7kx/Mnh3wK/9aY+/idcd
 FVTnDlYKbnmivJ2JyVMnT7gR3UHFeJ9mRAy238wLxjS8a3YyiQKBfaH+3SdwL6iULhaVi1hYZ
 nrBmw0phAjWCKZ2ruGc72kwY78ucuN0lb/tCSk3JAH25VrHUO+kMSBMwHchjR1Nt530p7px95
 YWsf4C5ZJMind3d+Yth5151FpXFkbLRrqFxh2t9Img/WPMj+VL6N47BzPJheJ8ypaWr53aFEJ
 gBWCLFIW/QDbH0nM8X3/8p5g67y0eioK4KaHXI8Ul1P3KzkSC6jUYs5KoRGrSoE/Or/s4kFd6
 MYXCn3NnUD2vxC2+XEfdaAgAbfzWv8EBajZCVjZcIkJQBerXZMnh4BPJm4/4QINlBcOPYouxu
 X7ba0MzvydsNGUp2sKCiqbndhT0fzOcQMn5pejT1ACzFcC6tdo20hpHHuwPidY9zVVTloIgzz
 jNK7liPK789ByQAnT/VWCNBhVPo8PXjfuVB45PfQGnuW4iUqArFRVfhv/esE7Mw70xb/oOK1j
 9LiYa5jxOBxdEL75olTNdc6siMX5/idgTaF5+PqQ4KZAonbq3HL2QX3poNay8+WZYxX7/NkTJ
 2yO0WddjzrRltFhvQyMpLC+TEakDL91NbIu0TO5UYglACY7SXRfwQxnBgyBb38xf4+eooxrXh
 rQZ2yj33dbbZZfB2B58dQIL+lJgsgjU2OVkQqyZPyn6GQMS+KxyoHZIc3YzZI1hBcLGy+qKks
 x43P5CVsrCzwJlR1imSE4voA+smNi+ZVdZr5L3lcOjLgQI17Fl46VWzWifBsXca5h5YVb39I4
 w+ArJEeUJG/P7uikWY+GIhxRKJC048e/K7WhZo6nAkRL1GF1LqroUlNv3UWbUJuhTMMt5p03B
 K6viqg/+WbaJv22EFTtt2wTLd81nkxGG85Vwdh44uieFZO7xUTD0SfCGHXIbiUvwSwWdjBhVl
 74Lglq0tJsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

On Fri, 30 Nov 2018, Ralf Thielow wrote:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>

ACK.

The commit message could state that the scripted rebase does not have
those whitespace issues, and that this aligns the built-in rebase with it,
but I won't insist.

Ciao,
Johannes

> ---
>  builtin/rebase.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5b3e5baec8..a6acba76b4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -871,7 +871,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			       "them"), REBASE_PRESERVE_MERGES),
>  		OPT_BOOL(0, "rerere-autoupdate",
>  			 &options.allow_rerere_autoupdate,
> -			 N_("allow rerere to update index  with resolved "
> +			 N_("allow rerere to update index with resolved "
>  			    "conflict")),
>  		OPT_BOOL('k', "keep-empty", &options.keep_empty,
>  			 N_("preserve empty commits during rebase")),
> @@ -1520,7 +1520,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	 */
>  	strbuf_reset(&msg);
>  	if (!oidcmp(&merge_base, &options.orig_head)) {
> -		printf(_("Fast-forwarded %s to %s. \n"),
> +		printf(_("Fast-forwarded %s to %s.\n"),
>  			branch_name, options.onto_name);
>  		strbuf_addf(&msg, "rebase finished: %s onto %s",
>  			options.head_name ? options.head_name : "detached HEAD",
> -- 
> 2.20.0.rc1.379.g1dd7ef354c
> 
> 
