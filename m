Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007351FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 05:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbcLLFx1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 00:53:27 -0500
Received: from mout.web.de ([212.227.15.3]:52696 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbcLLFx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 00:53:26 -0500
Received: from macce.local ([194.47.243.184]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCZfe-1cOWlE10Ta-009PCr; Mon, 12
 Dec 2016 06:53:22 +0100
Subject: Re: [PATCH 1/3] update_unicode.sh: update the uniset repo if it
 exists
To:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
Date:   Mon, 12 Dec 2016 06:53:16 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:5OCXS30OnvlLQ0fpgH2cb/l/GnAWwEjbECbvW5ukMr9U+o0wwDz
 tsGy2vBaN7B+ZBDSIeZEUECrtW3GHMlFNy9SdObTAGDiHP8R4xf+TVs7Vpj7YNLSF83et1Q
 XdAKraVDvzHA9n6IMlX+bK8+Ly/chfxEeTOpfEUaCapnEYQ75MgDfKkzbVZl4HTau6Ykjl3
 1y8WnBXDyuS7kCqJotURQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:14nS0tU8px4=:9w5W1r1GQpxDoLz7IS/aUN
 CrsXlktCw1ZUcVurVmnpkZ+xvQyDzisn2NV42gJakNskcTc4t7bRwdathWBNaflVB+4Wz4tZg
 jGiVwIVvOnU4yy+//sV6QmFiNBBpD4L8wAPKUeNn/oauDp31eDYiarV+PP/AFOvIEpCqB14yg
 6oFb15Wbp4AL9D/twiTm+sSzpWwzmQTnwc3nIGg5/ZGqCJkgSoseOCD/ruNaA1ySihL6O1JoG
 jccU3gK8j5Q5gYIwuC3mZLahVqi9gBIkuKfEqWtXg7VCD2rDOf6lBqEkIxNnwnF5LOCHh/qEA
 c/MknOfSl4J8AV4XnzmJf5c09hTXUhxNsrLWdYV+NkoCRwOKQEBuOgvcFd141r/tlGjZMy5N8
 aXrBKRZw6m0gPb1lKtOS7E4R4rt2TVS8TUPdI3D0Wp7E/uaJ6o3eH+QIg+vrqEZBNS0m0LM0a
 QnuY+wojxi2VGtQXQMFK90s2Gqf+yu7ZAPywblk9rLtN9QNsbSVr71+tT/sZz5tqJiO3neZ+X
 0SQFyGprK6QdwrVicPRs3aAbfpOuz7Ih5kmpvNAHMIfZrx3gHzaarCGZc4U/InvtlE8DEZQtF
 6c5FAPoqoNRc0+hSAtLZ+civDRy4iK83hGTIgQyqRtbECNggbsk7yXdVjkUHzdYg3vnRDjR8X
 k+iV+vQDd74DD35s6Q+LioocYNL4hYc2bs644tmEPS/wVt5FgNFdWmYbNLZ4VwoBmIyC//l2Y
 KGUVymn2xF4c7wyeYCaT2R6YFONVIrx6wSkIr27X3gGVfQM3umpErdbJV0xJNLOTTgLlkT7Se
 5NjJJTM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-12-12 00:34, Beat Bolli wrote:
> We need to track the new commits in uniset, otherwise their and our code
> get out of sync.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
> 
> Junio, these go on top of my bb/unicode-9.0 branch, please.
> 
> Thanks!
> 
>  update_unicode.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/update_unicode.sh b/update_unicode.sh
> index 4c1ec8d..9ca7d8b 100755
> --- a/update_unicode.sh
> +++ b/update_unicode.sh
> @@ -14,6 +14,11 @@ fi &&
>  		http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
>  	if ! test -d uniset; then
>  		git clone https://github.com/depp/uniset.git
> +	else
> +	(
> +		cd uniset &&
> +		git pull
If upstream has accepted your patches, that's nice.

Minor question, especially to the next commit:
Should we make sure to checkout the exact version, which has been tested?
In this case  cb97792880625e24a9f581412d03659091a0e54f

And this is for both a fresh clone and the git pull
needs to be replaced by
git fetch && git checkout cb97792880625e24a9f581412d03659091a0e54f


(Which of course is a shell variable

