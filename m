Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984581F597
	for <e@80x24.org>; Thu,  2 Aug 2018 15:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbeHBRvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 13:51:11 -0400
Received: from mout.web.de ([212.227.15.3]:51297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387645AbeHBRvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 13:51:11 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbroC-1gCrb9072C-00jG4m; Thu, 02
 Aug 2018 17:59:19 +0200
Subject: Re: Re* [PATCH] push: comment on a funny unbalanced option help
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <xmqq36vw4vu5.fsf_-_@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b72e5848-a51d-a62d-2a3c-36ea6b8582d0@web.de>
Date:   Thu, 2 Aug 2018 17:59:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq36vw4vu5.fsf_-_@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gTiO123/+XPZBv9C9hPHefvbr+TJoyJC5IHHuVgKkway9h6Kegl
 EButD3WGQmc3GZRKa6Db0HMaCqA1tdWvfdQG2haqAIwaRLhr5OVE77S95KJtdFxb4xT9WUa
 ZOkEtSoKKPtx134sNkgyJinnSXtIH6rdxnNrGuZ9Tr7b26osoFefuMqaUCO6M8Moj5jmrwZ
 kD8xlhhQI2WViQSy/0jRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZzBEEC00IyY=:ka9ow55r7L09rQr5MuHZOK
 MSzxCTOOK9wVurQEc4y9GqsZpCbXUctKGkK1CtF2mQHsRfEuMNbtLP4u7IVQq4pPv0Dnxctp6
 uK13ma/lGAGO7luyrN2Shx3LmOkOmI8DoZk/oqMOtoL/Oz8Q0Yn2E3yOPJl2/0Ym6WWD6QZ1C
 Rxx3aMAKaQ9bhheEQSjgf6jIW3CPmAPqURMvQsiKN3Kocg/e5d1c7eObnKHBDykD70xV/XEKC
 WpIf49jRLbX/pqy1X9XQnY8ZsDFokgkeXYZ96u1wSxrt9O+foE4pyJvHDrj1Q+CvZi3jZcDU8
 ksa0OwNmcaRlaISSe4GbgpVIQOm09vugHLfVfaP9X/sZA+Hpy5Jq7vPIZboMUncLgOcTVtvHr
 mjFKgr9zTeiPimV8T9Ul6hVs3f1b6LMpu6MNuIqfx7CfYa+mUGZMvHDe8IFox86YNc7wSgp1I
 IOA4mcO+cdANGUHWn/T78lFvDYLNq4saVM/pyZhz2uvk7mZXpZElmgRQeAH6Jtzxovs3ZeNPu
 53Ctb7RQpyibMDMg4JeIxy0kUbXDSWcm824tiL3bzPtMW6ysC+842XDc5dJe8XI5lZxZNYvU2
 va/Rz7DxiIwCNR1WSOSHLZqscwthTxI+CP8KKN+PdjllivgQC/+Bvz0GGVBhr1WzL7jIUx4/s
 rc8DVnz4FimjRvIDDfL5pZ/n4EmeJJJOGGbJteaXui8Q74IbQkos12s2ESED2T6Lkm4Xez+VM
 1opEtkrVbeFw+t1MQTdmZbFdZfP55mLOPfeuncUOYtdVb4liHUgjDzSVCrYr29J2E+3F+d6OP
 GAMgEI5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 17:44 schrieb Junio C Hamano:
> Subject: [PATCH] push: use PARSE_OPT_LITERAL_ARGHELP instead of unbalanced brackets
> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Date: Thu, 02 Aug 2018 00:31:33 +0200
> 
> The option help text for the force-with-lease option to "git push"
> reads like this:
> 
>      $ git push -h 2>&1 | grep -e force-with-lease
>         --force-with-lease[=<refname>:<expect>]
> 
> which comes from having N_("refname>:<expect") as the argument help
> text in the source code, with an aparent lack of "<" and ">" at both
> ends.
> 
> It turns out that parse-options machinery takes the whole string and
> encloses it inside a pair of "<>", to make it easier for majority
> cases that uses a single token placeholder.
> 
> The help string was written in a funnily unbalanced way knowing that
> the end result would balance out, by somebody who forgot the
> presence of PARSE_OPT_LITERAL_ARGHELP, which is the escape hatch
> mechanism designed to help such a case.  We just should use the
> official escape hatch instead.
> 
> Helped-by: René Scharfe <l.s.r@web.de>

I didn't do anything for this particular patch so far?  But...

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   builtin/push.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/push.c b/builtin/push.c
> index 1c28427d82..ef4032a9ef 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -542,9 +542,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>   		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
>   		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
>   		{ OPTION_CALLBACK,
> -		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
> +		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),

... shouldn't we use this opportunity to document that "expect" is
optional?

+		  0, CAS_OPT_NAME, &cas, N_("<refname>[:<expect>]"),

>   		  N_("require old value of ref to be at this value"),
> -		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
> +		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
>   		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
>   			N_("control recursive pushing of submodules"),
>   			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
> 
