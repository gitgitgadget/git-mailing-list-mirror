Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A18E20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 13:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeLNNj6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 08:39:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:39539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeLNNj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 08:39:58 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ln8gj-1h5TxB0ker-00hKJu; Fri, 14
 Dec 2018 14:39:56 +0100
Date:   Fri, 14 Dec 2018 14:39:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Oliver Joseph Ash <oliverjash@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Bug: `git commit --fixup` with duplicate commit messages
In-Reply-To: <CADBHO9E7Bzk9C5ciC416S+5-cS2ANA9d+CzSjKSG+HyxwrU+2w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812141438340.43@tvgsbejvaqbjf.bet>
References: <CADBHO9E7Bzk9C5ciC416S+5-cS2ANA9d+CzSjKSG+HyxwrU+2w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:S0PzGhLMAMf5Nivoda+pKq1bLCYulS0M2Sz+fPWV59GcMVg7//b
 kehkSTvJT+skbIwHaZCgCuFDXvOaxmIJrceqzpLADImAK4Fro0f5gReR6ss36Nfbh9bcilg
 Bo363cZqllXilC16jN7U9Y5yHoFaVlmyw2jditVESHG88bIPpTRTpxjW8nvVGjUceV0813p
 l1e9pzOLhzXpJ4Zsoar+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ru1ila/FKTc=:meCHmxxmU/IjLXK5rnqr4C
 ZFwmrVf5DnPQwhTU7uV6jwE/DzgdE1nawE7rviHRwinV+P4FKeb85tSbsNZNl51zjYKNgIn1u
 aK9ZyGcjI4wTVjgXjCiIVj9M94nSQjn86qamwxA2oEkjbe1qdgZsGJab2Ot8E+GHISI107QsO
 PedTi5kH8yDa+n52kw+qnCQt2lEbkhvkXgy0vFqE4VqcN3GNC3gFekBRBPyKC+aVS5tsf6V74
 I9JfCdnqnvMpHiCVMt5O8hPZAz5h4wIMTj19vplKE7FgytQ2IzZbjqKAZTkdihdlLk7wPiwFo
 I7AEIVFtA0KWMdXF5d1MnPAMatNfCd/SnZPAZBDdQxm8YcFu9Czt5ev7ChnwWJvoTFgvxgBD0
 0KA+7xGtKMreEUYMO5TBscuV3Ty+2vKVZDRDQOM6PGRe/4lX7eSq7D3DYfUmYwwRs+Ust+naE
 wqqcMgMpZbvII92+czLV2TLV5DgOB6aVSZWZ1DwvCD9Dtt42vIzRtQPl4/m2yaoGgFggW/og2
 EU8PCIE0o/Qf0SGyVaQcOy2ZxgHPmtABrI6IfY8IQ32CNN49MeNpSMBG8IWLsjCI5HFfv+jzo
 pjnY6rOA6vv34rCaSJl5ydhHlNw+4KAPPh51peyJ/6yehglHDJpct35RlUjUE5QziwadRZWIo
 G+na23ciPRDgjUboQ4ZJz1efub2v8c9/MXdIcTDWLZufbIHLAPy1TPLhtTNGUkztMP7cdCmrr
 sPgFLu2be0CgyNIBNgQHSOCcO+BupLFVgSx41AYAFnNUOr6Bbjru6JSEsoif7YbYbe4OP+AUB
 Y1GzBIgs3ule8ZnEvextk1tsFb+cMvsryBNX1J0fbebYQvv4Nv2oT2YMraJyjvxgKbWclW4zd
 XHiZoc5VK2UdEeyJT0DnhhOvde4nMQz/G5NDQXVnoAL84rk6DCzwKpGNwSbeGTx9xdwM6fUOW
 aRX+vtTf0vg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oliver,

On Fri, 14 Dec 2018, Oliver Joseph Ash wrote:

> I believe I have found a bug in `git commit --fixup`.
> 
> Steps to reproduce:
> 1. Create a git history with two commits (A and B) with the same
> commit message (e.g. foo)
> 2. Create a new commit using `git commit --fixup {SHA}`, referring to
> the last commit SHA
> 3. Run an interactive rebase
> 
> Expected: the fixup commit should appear below the last commit in the todo list.
> 
> Actual: the fixup commit appears below the first commit in the todo list.
> 
> It seems that the fixup commit is moved below the most recent commit
> with a matching commit message, however in this case there are
> duplicate commit messages. I would expect the fixup commit to be moved
> below the commit SHA I specified when I ran `git commit --fixup`.

Yes, this is a problem of the design of this feature. It was done
partially, I believe, to survive multiple rebases *without* --autosquash
before a final rebase *with* --autosquash.

The behavior really is by design.

Ciao,
Johannes
