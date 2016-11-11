Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C0E2035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934054AbcKKRCK (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:02:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:58409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756200AbcKKRCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:02:09 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHnzh-1c641f20wH-003eZ1; Fri, 11
 Nov 2016 18:02:02 +0100
Date:   Fri, 11 Nov 2016 18:02:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
In-Reply-To: <alpine.DEB.2.20.1611111711210.3746@virtualbox>
Message-ID: <alpine.DEB.2.20.1611111758150.3746@virtualbox>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com> <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611111711210.3746@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bVpsyF8kLnKv9PeTpt5pd3B5Jz+nwr3VrU6n+BHOApMPG625HKr
 7Vjce+GbPFQGl09LKCDmrY1jazZtCZ9+tRpCkKGKsXRrv5ffXMw6zBKZ6Zvfv5FLXSIZllB
 rivNJ/kYzGCqYXazjyEQ7+viimstrfLbo10PUKPiBL/lgm42kvoaUUIDr6xOIdDtiGkpcrw
 Qxdm78kLHy6hWOr2hYUIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1290Yt83qWk=:mvNon+hJaOlY/+kCu+EOv0
 WzHzZq1zGplJ6vPUK3QQTvw2S5uYBYpeg1EiU+fDlCi5RTX8Tbzp1KtddyDpUCxe3qjpY0boX
 fx/V+wsQfCcEj5G+LBiW52BTDU2uXLPUkkK2THofmmHXlNjJza9DDFd6uCCKw0+u1+k7EeRfa
 fUSRCGZTyUcTtV0EY+dYYL0mlCRizjH6XEb2ItYStQoBpH7KOsVrBzp51I7iAN5JTdTawQJGA
 nJpCwnacSk75HYOg+4ZaMa9TQ3GaDmYrfNISA6r8lYLV6UoP1cLsZkrjwQFPvlC6N04XJfbfE
 PTzQLjG+VieNWeyzd3oOXDMW2u0unH2eCEoCZAITuiJug+JT4qoQoLHUy0vgySNSvs4T5eAhh
 HXXXDFFyz7hLv1f0jHDDRmsaVH5xbockhBKl7mWF0rLuDkUYtzzH2dSAZ89B+1bB2sI6/ghbG
 1CIxbfJ/W5JmLKXgYkPTTFwLHgzIX/0Q9kBhRX0FoPmO5BlBFzQtZEXfaaSCid+q4d6VGVCKU
 QZ8/aKqkg74mrn548eiZg7ivrAMc7OCVwDlf8a7FVTT8ijVXUAHSS9HlU6Xo2Op94wQT2X/Ey
 OJOGL5YcFytzt8d455ClgpX/WFw1UQiY7gZZslzh8EkodqKnrKa0YLy+qKQ8BESnXGGVXOIUe
 0PPXOnN2lHNAsz6HFUoGveKRn8QQhuDVifTN8PidDsMm1JZscdexmHECh8CbLaWuTDJDIRv2c
 vOIkwvXGMGJ6rZnQtncWSGuqHDDxXJgsnVEOAGHbJiLtEp3vSXjY4yf2aEq9f63CnVECfgqp/
 g8RS3CC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 11 Nov 2016, Johannes Schindelin wrote:

> On Thu, 10 Nov 2016, Junio C Hamano wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > I'll report back an updated schedule when able.
> > 
> > I pushed some updates out on 'master' today.
> 
> Which means that t0021 is now broken also on `master` when running in Git
> for Windows' SDK.

To be precise, it says:

	# failed 7 among 23 test(s)

Running with -i -v -x shows that the first broken test is this one:

-- snipsnap --
expecting success:
        test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
        test_config_global filter.protocol.required true &&
        rm -rf repo &&
        mkdir repo &&
        (
                cd repo &&
                git init &&

                echo "git-stderr.log" >.gitignore &&
                echo "*.r filter=protocol" >.gitattributes &&
                git add . &&
                git commit . -m "test commit 1" &&
                git branch empty-branch &&

                cp "$TEST_ROOT/test.o" test.r &&
                cp "$TEST_ROOT/test2.o" test2.r &&
                mkdir testsubdir &&
                cp "$TEST_ROOT/test3 'sq',\$x.o" "testsubdir/test3 'sq',\$x.r" &&
                >test4-empty.r &&

                S=$(file_size test.r) &&
                S2=$(file_size test2.r) &&
                S3=$(file_size "testsubdir/test3 'sq',\$x.r") &&

                filter_git add . &&
                cat >expected.log <<-EOF &&
                        START
                        init handshake complete
                        IN: clean test.r $S [OK] -- OUT: $S . [OK]
                        IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
                        IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
                        IN: clean testsubdir/test3 'sq',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
                        STOP
                EOF
                test_cmp_count expected.log rot13-filter.log &&

                filter_git commit . -m "test commit 2" &&
                cat >expected.log <<-EOF &&
                        START
                        init handshake complete
                        IN: clean test.r $S [OK] -- OUT: $S . [OK]
                        IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
                        IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
                        IN: clean testsubdir/test3 'sq',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
                        IN: clean test.r $S [OK] -- OUT: $S . [OK]
                        IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
                        IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
                        IN: clean testsubdir/test3 'sq',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
                        STOP
                EOF
                test_cmp_count expected.log rot13-filter.log &&

                rm -f test2.r "testsubdir/test3 'sq',\$x.r" &&

                filter_git checkout --quiet --no-progress . &&
                cat >expected.log <<-EOF &&
                        START
                        init handshake complete
                        IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
                        IN: smudge testsubdir/test3 'sq',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
                        STOP
                EOF
                test_cmp_exclude_clean expected.log rot13-filter.log &&

                filter_git checkout --quiet --no-progress empty-branch &&
                cat >expected.log <<-EOF &&
                        START
                        init handshake complete
                        IN: clean test.r $S [OK] -- OUT: $S . [OK]
                        STOP
                EOF
                test_cmp_exclude_clean expected.log rot13-filter.log &&

                filter_git checkout --quiet --no-progress master &&
                cat >expected.log <<-EOF &&
                        START
                        init handshake complete
                        IN: smudge test.r $S [OK] -- OUT: $S . [OK]
                        IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
                        IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
                        IN: smudge testsubdir/test3 'sq',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
                        STOP
                EOF
                test_cmp_exclude_clean expected.log rot13-filter.log &&

                test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
                test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
                test_cmp_committed_rot13 "$TEST_ROOT/test3 'sq',\$x.o" "testsubdir/test3 'sq',\$x.r"
        )

++ test_config_global filter.protocol.process 'rot13-filter.pl clean smudge'
++ test_when_finished 'test_unconfig --global '\''filter.protocol.process'\'''
++ test 0 = 0
++ test_cleanup='{ test_unconfig --global '\''filter.protocol.process'\''
                } && (exit "$eval_ret"); eval_ret=$?; :'
++ git config --global filter.protocol.process 'rot13-filter.pl clean smudge'
++ test_config_global filter.protocol.required true
++ test_when_finished 'test_unconfig --global '\''filter.protocol.required'\'''
++ test 0 = 0
++ test_cleanup='{ test_unconfig --global '\''filter.protocol.required'\''
                } && (exit "$eval_ret"); eval_ret=$?; { test_unconfig --global '\''filter.protocol.process'\''
                } && (exit "$eval_ret"); eval_ret=$?; :'
++ git config --global filter.protocol.required true
++ rm -rf repo
++ mkdir repo
++ cd repo
++ git init
Initialized empty Git repository in C:/git-sdk-64/usr/src/git/wip2/t/trash directory.t0021-conversion/repo/.git/
++ echo git-stderr.log
++ echo '*.r filter=protocol'
++ git add .
++ git commit . -m 'test commit 1'
[master (root-commit) aa5dd37] test commit 1
 Author: A U Thor <author@example.com>
 2 files changed, 2 insertions(+)
 create mode 100644 .gitattributes
 create mode 100644 .gitignore
++ git branch empty-branch
++ cp 'C:/git-sdk-64/usr/src/git/wip2/t/trash directory.t0021-conversion/test.o' test.r
++ cp 'C:/git-sdk-64/usr/src/git/wip2/t/trash directory.t0021-conversion/test2.o' test2.r
++ mkdir testsubdir
++ cp 'C:/git-sdk-64/usr/src/git/wip2/t/trash directory.t0021-conversion/test3 '\''sq'\'',$x.o' 'testsubdir/test3 '\''sq'\'',$x.r'
+++ file_size test.r
+++ perl -e 'print -s $ARGV[0]' test.r
+++ command /usr/bin/perl -e 'print -s $ARGV[0]' test.r
+++ /usr/bin/perl -e 'print -s $ARGV[0]' test.r
++ S=57
+++ file_size test2.r
+++ perl -e 'print -s $ARGV[0]' test2.r
+++ command /usr/bin/perl -e 'print -s $ARGV[0]' test2.r
+++ /usr/bin/perl -e 'print -s $ARGV[0]' test2.r
++ S2=14
+++ file_size 'testsubdir/test3 '\''sq'\'',$x.r'
+++ perl -e 'print -s $ARGV[0]' 'testsubdir/test3 '\''sq'\'',$x.r'
+++ command /usr/bin/perl -e 'print -s $ARGV[0]' 'testsubdir/test3 '\''sq'\'',$x.r'
+++ /usr/bin/perl -e 'print -s $ARGV[0]' 'testsubdir/test3 '\''sq'\'',$x.r'
++ S3=49
++ filter_git add .
++ rm -f rot13-filter.log
++ git add .
+ test_eval_ret_=128
+ want_trace
+ test t = t
+ test t = t
+ set +x
error: last command exited with $?=128
not ok 15 - required process filter should filter data
#
#               test_config_global filter.protocol.process
#               "rot13-filter.pl clean smudge" &&
#               test_config_global filter.protocol.required true &&
#               rm -rf repo &&
#               mkdir repo &&
#               (
#                       cd repo &&
#                       git init &&
#
#                       echo "git-stderr.log" >.gitignore &&
#                       echo "*.r filter=protocol" >.gitattributes &&
#                       git add . &&
#                       git commit . -m "test commit 1" &&
#                       git branch empty-branch &&
#
#                       cp "$TEST_ROOT/test.o" test.r &&
#                       cp "$TEST_ROOT/test2.o" test2.r &&
#                       mkdir testsubdir &&
#                       cp "$TEST_ROOT/test3 'sq',\$x.o" "testsubdir/test3
#                       'sq',\$x.r" &&
#                       >test4-empty.r &&
#
#                       S=$(file_size test.r) &&
#                       S2=$(file_size test2.r) &&
#                       S3=$(file_size "testsubdir/test3 'sq',\$x.r") &&
#
#                       filter_git add . &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               IN: clean test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: clean test4-empty.r 0 [OK] -- OUT: 0
#                               [OK]
#                               IN: clean testsubdir/test3 'sq',\$x.r $S3
#                               [OK] -- OUT: $S3 . [OK]
#                               STOP
#                       EOF
#                       test_cmp_count expected.log rot13-filter.log &&
#
#                       filter_git commit . -m "test commit 2" &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               IN: clean test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: clean test4-empty.r 0 [OK] -- OUT: 0
#                               [OK]
#                               IN: clean testsubdir/test3 'sq',\$x.r $S3
#                               [OK] -- OUT: $S3 . [OK]
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               IN: clean test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: clean test4-empty.r 0 [OK] -- OUT: 0
#                               [OK]
#                               IN: clean testsubdir/test3 'sq',\$x.r $S3
#                               [OK] -- OUT: $S3 . [OK]
#                               STOP
#                       EOF
#                       test_cmp_count expected.log rot13-filter.log &&
#
#                       rm -f test2.r "testsubdir/test3 'sq',\$x.r" &&
#
#                       filter_git checkout --quiet --no-progress . &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: smudge test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: smudge testsubdir/test3 'sq',\$x.r $S3
#                               [OK] -- OUT: $S3 . [OK]
#                               STOP
#                       EOF
#                       test_cmp_exclude_clean expected.log
#                       rot13-filter.log &&
#
#                       filter_git checkout --quiet --no-progress
#                       empty-branch &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               STOP
#                       EOF
#                       test_cmp_exclude_clean expected.log
#                       rot13-filter.log &&
#
#                       filter_git checkout --quiet --no-progress master
#                       &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: smudge test.r $S [OK] -- OUT: $S .
#                               [OK]
#                               IN: smudge test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: smudge test4-empty.r 0 [OK] -- OUT: 0
#                               [OK]
#                               IN: smudge testsubdir/test3 'sq',\$x.r $S3
#                               [OK] -- OUT: $S3 . [OK]
#                               STOP
#                       EOF
#                       test_cmp_exclude_clean expected.log
#                       rot13-filter.log &&
#
#                       test_cmp_committed_rot13 "$TEST_ROOT/test.o"
#                       test.r &&
#                       test_cmp_committed_rot13 "$TEST_ROOT/test2.o"
#                       test2.r &&
#                       test_cmp_committed_rot13 "$TEST_ROOT/test3
#                       'sq',\$x.o" "testsubdir/test3 'sq',\$x.r"
#               )
#

