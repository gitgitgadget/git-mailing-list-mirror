Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29F01F453
	for <e@80x24.org>; Fri, 26 Oct 2018 08:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeJZQrL (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 12:47:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:48445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeJZQrL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 12:47:11 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgqEs-1flcPE2IhK-00oCn2; Fri, 26
 Oct 2018 10:11:06 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgqEs-1flcPE2IhK-00oCn2; Fri, 26
 Oct 2018 10:11:06 +0200
Date:   Fri, 26 Oct 2018 10:11:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH sg/test-rebase-editor-fix] t3404-rebase-interactive: test
 abbreviated commands
In-Reply-To: <94c0b5b6-ac31-101b-80a0-ac78196e0f62@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1810261006510.4546@tvgsbejvaqbjf.bet>
References: <94c0b5b6-ac31-101b-80a0-ac78196e0f62@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4iv3GH/thEctGb1kUZIwfxv9MtkPrD8JuZpRwuo1+I763NVpCmT
 hvniDdRWsoXBJIXUYBr241Ath8VUgxEW+Ql5GuE8NN8XtML0+DQwtHPdhuAIwHZWI0caIYY
 /aEK09rcuKkdLKIiDtLcalaOt4+QLb5JkkHvsVZ5bfdc0QVSYnxN5+TmC920tYCvsuXxHQ2
 QGpz816GjzOwSgIehnEzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sj0dFWT+Pss=:NcHy6uwrY6VMgXS/XHt+0B
 WDQw8GNyNEaLWIvaDJd1BWP762oR2UZOoDLpkXT1KpUzb/cYhp5+Ru98kc7PccvxCs6xlMomk
 XtwRVgxzepJ0Zj/eRXElwRaoS48axq9MqAns7zvGFFxnIfGDXOu1RVr9+4bIqYtn5kujQSpaI
 /IjyWWiqGzeQYc/VYdiGqu4wwi7K6b9T1TRWQBUey5OEFZsBP4040mme9h0o4hnF2y5p082va
 H0X0FFV3PJA7zX1z7sUxiR1mpZgFDo98cd+MY8uNhRIxIfUbXg3eHQ0Ls8XA69wuVdVSgyH1Z
 khBiKPu4Ya79JpErKNuZFMI5gDfDleiyxYJGHqwKfk4vHR8mJ1Zu2eq1XbU/wfC2Q72qJeX4r
 oU3Py2qqHz1uY6pGAH7wS/C615ZL8VHNHKrrPBnDPz20Q453yAZ7Dlj6VKTle3dBACmuqNv/r
 X0gjsyL3kT/j/r4RoAmE0R/sOLCAadRYO++KApDKcUpRusZ3Fh+D2s6gdhi0jnNT2LtPKsg64
 mvs2xzSIvcGi3eB2ApmHKnSj1PMv9yWKn8UWzP4HNqxPNbwjHRMekPltUc7xuoi9ObcKDbiJ1
 WbnUVp6R+o1/rXwyRltTfixW7OALNdeKysUotR+FYrKdr9HlO6XfeGlG6+V6fJOJ/NFqAzBq8
 NsuYI0YCiHSJHeFlxPZy/4yBeXL8xkpeV/31KKDVKEexQHg/T5Q0UF0BeiDAC/U2qTaREQGuS
 HI1KFMQStlEzEupImJxRXor/ElESSl8fAx0IKm3s899mGJtS3j8xkWBYQ4IhCH3ZGLJKEf7lM
 HnUDwZ6f2D4CSerESIzwa/5VcDJE8gLheq7DGMSG4vxHQ/IXy0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,


On Thu, 25 Oct 2018, Johannes Sixt wrote:

> Test each short command at least once. The commands changed here
> are chosen such that

I stumbled over this, and understood it only after looking at the patch.
How about this instead:

	Make sure that each short command is tested at least once. To do
	so, we modify existing tests to avoid lengthening the already
	formidable runtime of t3404 (13 minutes on Windows). These rules
	were followed to find appropriate commands to modify:

> - tests do not have a prerequisite,
> - the 'git rebase' command is not guarded by test_must_fail.
> 
> The pick commands are optional noise words in the FAKE_LINES
> variable. Test them, too.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

The rest looks good to me.

Thanks,
Dscho

> ---
>  This patch must be placed on top of sg/test-rebase-editor-fix.
>  It has a textual conflict with my sequencer 'b' fix from some
>  minutes ago, but the resolution should be obvious:
> 
>  - 		exec*|break|b)
>   -		exec_*|x_*)
>  ++		exec_*|x_*|break|b)
> 
>  t/lib-rebase.sh               |  4 ++--
>  t/t3404-rebase-interactive.sh | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 2ca9fb69d6..0c93d00bdd 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -47,9 +47,9 @@ set_fake_editor () {
>  	action=pick
>  	for line in $FAKE_LINES; do
>  		case $line in
> -		pick|squash|fixup|edit|reword|drop)
> +		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
>  			action="$line";;
> -		exec*)
> +		exec_*|x_*)
>  			echo "$line" | sed 's/_/ /g' >> "$1";;
>  		"#")
>  			echo '# comment' >> "$1";;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 352a52e59d..d36ee4f807 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -114,7 +114,7 @@ test_expect_success 'rebase -i with exec allows git commands in subdirs' '
>  	git checkout master &&
>  	mkdir subdir && (cd subdir &&
>  	set_fake_editor &&
> -	FAKE_LINES="1 exec_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
> +	FAKE_LINES="1 x_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
>  		git rebase -i HEAD^
>  	)
>  '
> @@ -499,7 +499,7 @@ test_expect_success 'squash works as expected' '
>  	git checkout -b squash-works no-conflict-branch &&
>  	one=$(git rev-parse HEAD~3) &&
>  	set_fake_editor &&
> -	FAKE_LINES="1 squash 3 2" EXPECT_HEADER_COUNT=2 \
> +	FAKE_LINES="1 s 3 2" EXPECT_HEADER_COUNT=2 \
>  		git rebase -i HEAD~3 &&
>  	test $one = $(git rev-parse HEAD~2)
>  '
> @@ -732,7 +732,7 @@ test_expect_success 'reword' '
>  	git show HEAD^ | grep "D changed" &&
>  	FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" git rebase -i A &&
>  	git show HEAD~3 | grep "B changed" &&
> -	FAKE_LINES="1 reword 2 3 4" FAKE_COMMIT_MESSAGE="C changed" git rebase -i A &&
> +	FAKE_LINES="1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE="C changed" git rebase -i A &&
>  	git show HEAD~2 | grep "C changed"
>  '
>  
> @@ -758,7 +758,7 @@ test_expect_success 'rebase -i can copy notes over a fixup' '
>  	git reset --hard n3 &&
>  	git notes add -m"an earlier note" n2 &&
>  	set_fake_editor &&
> -	GIT_NOTES_REWRITE_MODE=concatenate FAKE_LINES="1 fixup 2" git rebase -i n1 &&
> +	GIT_NOTES_REWRITE_MODE=concatenate FAKE_LINES="1 f 2" git rebase -i n1 &&
>  	git notes show > output &&
>  	test_cmp expect output
>  '
> @@ -1208,7 +1208,7 @@ rebase_setup_and_clean () {
>  test_expect_success 'drop' '
>  	rebase_setup_and_clean drop-test &&
>  	set_fake_editor &&
> -	FAKE_LINES="1 drop 2 3 drop 4 5" git rebase -i --root &&
> +	FAKE_LINES="1 drop 2 3 d 4 5" git rebase -i --root &&
>  	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
>  	test C = $(git cat-file commit HEAD^ | sed -ne \$p) &&
>  	test A = $(git cat-file commit HEAD^^ | sed -ne \$p)
> -- 
> 2.19.1.406.g1aa3f475f3
> 
