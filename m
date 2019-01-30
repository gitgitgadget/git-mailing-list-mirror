Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58A01F453
	for <e@80x24.org>; Wed, 30 Jan 2019 13:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfA3Nay (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 08:30:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:52423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3Nay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 08:30:54 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8vJ-1hCgPP25nN-016f4U; Wed, 30
 Jan 2019 14:30:46 +0100
Date:   Wed, 30 Jan 2019 14:30:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     git@vger.kernel.org, peff@peff.net,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH (Apple Git) 04/13] t4014: git --version can have SP in
 it
In-Reply-To: <20190129193818.8645-5-jeremyhu@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901301419030.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-5-jeremyhu@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R7xnDLocdBG4JESe7M/CaSw0c7ncC7dSmVnqEzG5Y5CjZAAGGzL
 xojurWUiGxrCJihGBULVuIkxLtp62bVXH56O5AFX0I/IAvgJnasitSULyx5mDy7XwiO7C5Z
 JXhhlSIUtPzf+KB4FRiQX124fqsyGKPGqgV8MHLpaFKv/o60mNIUhtBW0aoPLL3BK6NoQcs
 b2ysUWDV+NJEplz3aUB8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:unZsvgAJ+IU=:x74qmlL6VS/GMwyTjluVK1
 gv/RQSVaMJBJiQUCLPzmRAZNtDcbyxrdDUio1ux509W0q1ly+o5TXueU2kTsyYcFoVBqdQsqf
 +CN4KI463EZbWdQfp2/KHhMDixXvBIyIjvTOAiE6iC4E0r/1kvjYcBYPmn004HPV5x6VkUs2r
 PCL+4jEb3xWXWEUqZowI1yqf4T8t4gy10vKw4JyrmPaqlbEphvzi0nHI/yDzGuaqlQ5EpgPXc
 Io7c3BD8V3JwwyoPuhu3nxdILX30dJUNR/2GpJSioiz/KeBcDviKSCMLYc0pHGdOH6a9MVBxu
 qP89/al3apeOmp0uPMNI+E3YXUU/Oun4IJG4hPELRG7oRuyzA1ePsoqt82cAcQJh+7I8NIUYQ
 1Gg9sF9FrTmBvpElyZ877SVbUQ14wOQCBP+caylh3cPaALHJPh+hnrwvSVRKdzPDeVEto36rU
 MKINvyWqbMvGQpa+ig9c+AjYtN2jlhGymDdFgGkzUQId/Xxu0Wy4IDRRwPuPhGH3h6mzgJVGX
 KewffGvpcs3wCtepRu/OxgdqX0g6SvAInYLzX/WRq3I1kokmTn/0UkIFYTxUTtSq5+vSnHacB
 7ZthraAZ86c5ISPVKYseHifkfA1oju1dzbjtQRC0WgGtWvXkT4vLKNehzfav22DUYkRfLwnF1
 j0Os0ITwKRcubrJYuImClBPLNKOaIoXikovzeOuivuWRboOGC5NG6wraAk3tvSfGdtNj3MKYp
 yLT443cu91PlRANhs6rytncmflINnk37TArcSWejTjGrGxJ+My/+DQoFlDr97/NUG4Mcg/XhM
 lYL/CUQ0E2U0dYf/E+jMt5vt7WeOAixMjr1TSfIHSCw4demHmIGjC3/Msecsmj29pXwAqTp5c
 WtQkGDY8L/ygjjt8w2/UQLcB+8mVZX8ObHwa7cpj2uG6mXCZRuPB0K0X5y/pmaVD38YV94lCE
 I0/jpicWzOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:

> 480871e09e ("format-patch: show base info before email signature",
> 2016-09-07) added a helper function to recreate the signature at the end
> of the e-mail, i.e. "-- " line followed by the version string of Git,
> using output from "git --version" and stripping everything before the last
> SP.
> 
> Because the default Git version string looks like "git version
> 2.10.0-1-g480871e09e", this was mostly OK, but people can change this
> version string to arbitrary thing while compiling, which can break the
> assumption if they had SP in it.  Notably, Apple ships modified Git with
> " (Apple Git-xx)" appended to its version number.

Here would be a fine place to add Junio's explanation that `git version`
always prefixes "git version " to the `git_version_string` and that the
default signature in `builtin/log.c` is defined as said
`git_version_string`.

> 
> Instead, come up with the version string by stripping the "git version "
> from the beginning.
> 
> Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae

This is really not a good  way to reference a commit, what with our
intention to switch to SHA-256 at some stage.

Besides, this footer is completely redundant with the information that
starts the very first paragraph.

Ciao,
Johannes

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  t/t4014-format-patch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 909c743c13..414c56fcff 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -757,7 +757,7 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
>  	git format-patch --ignore-if-in-upstream HEAD
>  '
>  
> -git_version="$(git --version | sed "s/.* //")"
> +git_version="$(git --version | sed "s/git version //")"

As Junio said, this should be anchored. And for extra safety, in case some
even more unreasonable company decides to change the output of `git
--version` itself, it should probably use

	git_version="$(expr "$(git --version)" : "^git version \(.*\)")"

Ciao,
Johannes

>  
>  signature() {
>  	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
> -- 
> 2.20.0 (Apple Git-115)
> 
> 
