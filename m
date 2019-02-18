Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A571F453
	for <e@80x24.org>; Mon, 18 Feb 2019 19:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfBRTh6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 14:37:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:38011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfBRTh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 14:37:58 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8axL-1hHDPC4C7H-00wBLS; Mon, 18
 Feb 2019 20:37:42 +0100
Date:   Mon, 18 Feb 2019 20:37:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Max Kirillov' <max@max630.net>,
        =?UTF-8?Q?'SZEDER_G=C3=A1bor'?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
In-Reply-To: <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902182008270.45@tvgsbejvaqbjf.bet>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com> <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com> <000001d4c624$da8e05d0$8faa1170$@nexbridge.com> <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OQUqjnKfsay1+JderIT6pnyjlFfEM2pyfWp8JuU6WJZfHFB8gVX
 EGDmEjL+9WKWRma3Sasce7hqn3d0F415qnW+pJ3RtDWZfMwszyqDcdgCXEmPHdrOrUyL4sw
 mXuCm7OrsRVpxlqD61sw3WuqWrfWYiUE03Xs6C8o4pfoZN6h7Q5DnSAGDSJvBC5eHO1DqtL
 EnVJAXZecpzM5mgOM9enQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oA+4rB+89xw=:h6kI4e1XC89fM6bvwOhm+Y
 SJdQGOZCtVVpwZysWNHW8Oa9wUpmJlu5vO2oPrG/ViLHWo9Yv6LIg+SOP/PHDdt77E9j2fxqS
 RoU+zt11lIJiw82E7MgRkPdUY0Uv5YqA6rVm3HJSIKJdup9Fp0mvj+nwI4jyz7Fb5scXwAujW
 vqEv3uL2sRshvf1iZ9FAeV6womJAIQ1FqXIrIjXjQaA/zX71IrTQJhKAoqYxrETh0O1s60Ij6
 RnFX2FNLdHzzoqLIZwC4vGn+3FHjm/zma/ZZDU2+FtHYrWFRg30E+J2kzQF7nq6AX3dBxqtIe
 iJDoFcIdGAgFWrG+YGwbg3dJQ062h4ZMvaTEPRJuGVpgmwELc0Uyfxqdco9Qi+d2p4ibrl/nf
 vHl9ycPEcihRvYs4RxygUNj1lkTKhfKu3PtBmT6wSte5oW7rqy9wq+3E21S7GdWZQdSAHBdjK
 dHji7AGYf8jmdWsT0kS+KBIsEMwmUqy7Sq1KRk1MlcspGYUeiZzzmVz6GKzVAk9S7np5YYXmn
 9Ebuf1KjCtw2gaCWebLwVEfJdd0at0xXiXSKn5zg3zreVzjR1hfbo4OkHxzm0AiE/F5/B8mpJ
 WloF/qFyYvgNmwlzoUaiFjsF2idUkngwqZIyb9Hp/KpniKYpIfBHpdqqRBpsyeQDx3MalHgM5
 e3tHM50gYC1DZoqGgVcTQej9BIvF5g3jeeejEMvHIYuh5riEpq3QPJXcB2v3TAtRNMShEKP2/
 1ZUT1fBTr1Gbz5pWhkYnNpeKCmuNzsksTi77RkVAqQ3qX5aOTogT4Hjq3pRywfwACzqZG30wT
 JIEiDSq1d+DgUZyghCQybQWvGU9stoi2KiOuMSiFNLYD55gLl7RQtlGJg1aG5CSJxYm2X1bBk
 hhwd4ccszCqCFsGHXnu93xaiQtKmWavG4t/j3M5yZnxkAegkWMDRpLSSAuZ3KFL6x3bZfzSMG
 OdcqPAwe2Ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 16 Feb 2019, Junio C Hamano wrote:

> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >> > The current condition of the code is (the generate_zero_bytes delete
> >> > was previously removed so can be ignored for the patch):
> >> 
> >> Just to make sure I do not misunderstand, this result is with Max's patch but
> >> without the generate_zero_bytes stuff?
> >
> > Correct.
> 
> Thanks for a quick response.  I've been staring at b46221ff ("Merge
> branch 'rb/no-dev-zero-in-test'", 2019-02-13).  IIUC, t5562 wouldn't
> have passed if it still fed http-backend from /dev/zero, no?  The
> shell redirection would have failed, so we do need to keep that part
> of the change---i.e. in order to pass, we do need cc95bc20 ("t5562:
> replace /dev/zero with a pipe from generate_zero_bytes", 2019-02-09)
> and Max's "t5562: do not reuse output files", right?
> 
> I have been wondering about the whole /dev/zero business.  Although
> we have b46221ff ("Merge branch 'rb/no-dev-zero-in-test'",
> 2019-02-13) in 'master', "git grep /dev/zero t" has hits in
> t/helper/test-sha1.sh and t/t4152-am-resume-override-opts.sh, so it
> must have been somewhat incomplete to help platforms that lack
> /dev/zero in the first place.
> 
> We haven't heard from Dscho in European timezone,

Some bacteria redirected me to /dev/zero for a few days. That hung my
inbox.

> but I'm inclined to
> 
>  - keep b46221ff in 'master', not reverted.
>  - apply Max's "t5562: do not reuse output files"
> 
> to 'master' and hope that we can declare victory in this part of the
> code ;-).  There may be fix-ups for other topics before -rc2 on top
> of that, though.

For the record, I did not set up that fully automated PR build & test at
https://github.com/gitgitgadget/git just so people would still wait for me
to run the test; a simple PR would have tested this without waiting for
me.

Anyway, in the meantime, I tested it, and Max' test seems to work:

https://dev.azure.com/git-for-windows/git/_build/results?buildId=31274

Ciao,
Dscho

> >> Thanks, all.  Hopefully we can get this test failures behind us before -rc2;
> >> knock, knock...
> >
> > Once the fix is integrated and in the usual spots, I can verify
> > with haste. The full test cycle is now at 50 hours (argh), which I
> > will rerun in full at rc2, but this one is fast.
> 
