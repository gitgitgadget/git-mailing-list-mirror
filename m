Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FFAC1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 20:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbeKVGrP (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 01:47:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:40637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeKVGrP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 01:47:15 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyEqr-1fK4Xw0GmL-015ct7; Wed, 21
 Nov 2018 21:11:25 +0100
Date:   Wed, 21 Nov 2018 21:11:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/vsts-ci, was Re: What's cooking in git.git (Nov 2018, #06; Wed,
 21)
In-Reply-To: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811212108180.41@tvgsbejvaqbjf.bet>
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o+y9icfNPXbXrLABM8GF3lQpmEZrwZ5VbWKSju1j5H4AZ3+LoX6
 xqLGEK/1/YrS/UCtBJrLH0PCkBw27OJ53Aovk5hWTuTtlLi6p7anSC9EQnm+sy5DJqNCFYb
 b82u32a6Y+Gby5cFgMYfihgCxoXudV4N1dtuwIrG7vqnyRRakiV9VNF0AtNocCe80v+t6qI
 XCb9KMgPBmSPeqikoWhDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hb/rQ0ooFd4=:h7vHo/02uPUcYFu/0RxUqF
 cDXLUkrOABUBWrgUz3IWAnqxW7D52d7zbOrKZdbJ/UkMWpJpdFbX/gNzUd2K7iW07x1Bb0O/Q
 dRvBnr4x04lYpmw5vgTjwTHRfA2VD3/aA8Mc26XjuT6YVqAckKy5PstSaALgd01Nd8aURGI0J
 0XKk9jmZUeEe8rcHWUP7hFxJ+ahVASFMnl7vkxxTpWaqfQOtXRdlwjewssvHHac0rKivlwkar
 ME0hYGz3Pw2dl0/ureT0HUZ6Ww2PsOOgxFKRGqth4tKIyhpHi/Hfc6k0fZzTM199GmtFI2EEH
 7GRNgziGLHbMhFkIXWfVRn8EE7Fj2SrAwHPfycZKi+eTZ9Wd29XoYW2YkKNo+p/kjweBEEDF4
 71YsRDSViCrtMsLWOy5sIay/VJupkwEZPWTpaYiUTNUOi5mJGfvsMBw9l+pIgpUN5wwmquuUO
 LHM9gtHpk1T2Ry4GtzCJG1Ayv+yY6fdErBTBh6rr7WXoJhxu6ZKrGdP+7n/q/IoS1ItFLHVad
 rwJRh+4jirP5aq0mRSnCQzpoFAeHeUKUp/9LWXrMgAhSPQUrDdHER8UW2wQgEZ8QvYm5wuUUr
 sjld83cMNI70bXWRDAv+jIGLUd7sihy+0VK6BSmn8wVtBGLV2I6NV8VCI+ax0K4TTkgtxvLls
 rw2Bn1tMaegGiz2h4UCpU+lSyZZwX6erNEp4PAd4Bg5twdu5+jBN+dcfAhnp8riRStkWRGp/L
 S6d1RJEu0ul3dsFTXEP0VNVBWCnFtHj7T324s7IfbilShVK7w4XjdKqyKuk/OZqGscNYRMkGI
 +XA60+tOVprIV8vowQ74LMWKQqcPmPMbe7K4OjfyyFoVZrnZwy5Qz6OgBJlJ1AvgQJmFuajb/
 MSeZNpd17qQ6eIAbcJlJxGMKcTkPconAZVgcQ000R0se0fF4fcuFqPrehrMLaT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Nov 2018, Junio C Hamano wrote:

> * js/vsts-ci (2018-10-16) 13 commits
>  . travis: fix skipping tagged releases
>  . README: add a build badge (status of the Azure Pipelines build)
>  . tests: record more stderr with --write-junit-xml in case of failure
>  . tests: include detailed trace logs with --write-junit-xml upon failure
>  . git-p4: use `test_atexit` to kill the daemon
>  . git-daemon: use `test_atexit` in the tests
>  . tests: introduce `test_atexit`
>  . ci: add a build definition for Azure DevOps
>  . ci/lib.sh: add support for Azure Pipelines
>  . tests: optionally write results as JUnit-style .xml
>  . test-date: add a subcommand to measure times in shell scripts
>  . ci/lib.sh: encapsulate Travis-specific things
>  . ci: rename the library of common functions
> 
>  Prepare to run test suite on Azure DevOps.
> 
>  Ejected out of 'pu', as doing so seems to help other topics get
>  tested at TravisCI.
> 
>  https://travis-ci.org/git/git/builds/452713184 is a sample of a
>  build whose tests on 4 hang (with this series in).  Ejecting it
>  gave us https://travis-ci.org/git/git/builds/452778963 which still
>  shows breakages from other topics not yet in 'next', but at least
>  the tests do not stall.

Sorry about that.

FWIW my current plan is to work a bit more on the Windows phase (to make
it faster), and to split out the `test_atexit` patches (because they cause
those hangs). I still think it is the right thing to do, but I lack the
time to take care of it within the next weeks. Instead, I will try to run
even the Windows phase in --verbose-log mode so that the --junit-xml code
can pick up the verbose logs right away (read: no more re-running upon
test failures). Hopefully this won't cause a speed regression.

Ciao,
Dscho
