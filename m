Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 688161F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfA3TIR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:08:17 -0500
Received: from mout.gmx.net ([212.227.17.22]:53013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732343AbfA3TIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:08:16 -0500
Received: from MININT-6BKU6QN ([62.119.166.9]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFgxF-1gu5kq3vML-00EfvX; Wed, 30
 Jan 2019 20:08:10 +0100
Date:   Wed, 30 Jan 2019 20:07:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 08/13] git mergetool/difftool doesn't list
 'opendiff' as an available tool on 10.8
In-Reply-To: <20190129193818.8645-9-jeremyhu@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901302005450.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-9-jeremyhu@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bUZ9vvcEYB274S3tKh5UqDlUs+L9CBJbUaKj3px86zn3GjeNXDl
 zWnq4R/QLqtdqWgR6ccsb3NGYg3qlstoXemSnBRVthwkp0jsXIJ9Lwejplf2fkda8XLHZPy
 njA7DuKfdQAXGn1Yu47Xf1lXi9/zPdOlM+usPJ10kh5jPA1ReIbBHbfF70ul5O95L9PkPFn
 ltfmQhZnRNvUEHb2094JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0FJXadUjgRk=:D4FgSdn0nhyGviMsXrx6u2
 Oia5ycqjRfj5UzVJUTaswcNcgeSU/si28GmUigEQ30zu1N/YccKiOPPt2oFR941/byBd45TQP
 3CVxKx65ibV99bX/EIybYR6jbAVh197DQh8XEQHNV3jhxd7l013lXcbGclJGO1DcIT+xXIZKo
 9jIdaymWz2gGMIuBx5hzVLEYVEfqr8Klm2Y7Q5vdfAXKrauyycvsV2r9PWp+8RwWD+uVWqklH
 VwrgvkvTjIjLjasOGc3ciPUuK5fHmtLdI5y7ijZu5VYrmR7MgTfz7n5Z3bJ1eCNyiMg95u0YO
 f3UsISEFaJ4CVDEQSI/LbfIrSvde8qewsPmfp52Gp4XcZx57cw/CR+4tfrzcbD0ZfIJ87D+eX
 sXT/psFwNgzrfoHmely/RRpck1i0GlmOjS4PV2cnya73aQYmHy0tUG8xpQPvKe5pMwdDAUzH9
 1TnawPt0/f6vEwPQPVUGIGu2RmzDVMuRpE6O31EIMqnORUPKuUGRKyOdle0oc/lYRp73cUINQ
 i8vVNBfn5z5NVUdZiPHrTP+m351ZFXY2hKp5bMAyZmkhniRliNs1PA8q90I67pMt/LRbgHD/w
 nxyCj3+G3ZZkAbak7o2bpAF3JyZCmPYxxpzR70xfRIjQYS6Q5VReP6u+byz3PoHsc7fVt/Eve
 vSbzT9kpLnnEtZiEmAo5udDSClUNFbiiA9IOMyvIQOTTypacT2NjzLz2oLDkKeAzGaMmQjw2t
 HkULm9nThIub74/NvePOl3ytr0AFw9yEAEcNZfmsYE/8wQwxz2x6uUt6uorIfceq48Z3E60em
 gRFR71NtGNH5w5iX8IcawiyPC07f7iohNNxJRTAjX0joHXP6T7CXr3h+diiltFI7npkHa638o
 xf4kRYOX8gnpHp6kQPMlNM7c7uy3QX63+bBNugpnYprVcgiXA8yB0OuYGKoyeDOGqv4JpXsNz
 7h9QRiU0xCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:

> See <rdar://problem/12652310>
> 
> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>

You know yourself how to improve this commit message rather dramatically.

> ---
>  git-mergetool--lib.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 83bf52494c..f85be7406f 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -273,9 +273,9 @@ list_merge_tool_candidates () {
>  	then
>  		if test -n "$GNOME_DESKTOP_SESSION_ID"
>  		then
> -			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
> +			tools="meld kdiff3 tkdiff xxdiff $tools"
>  		else
> -			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
> +			tools="kdiff3 tkdiff xxdiff meld $tools"
>  		fi
>  		tools="$tools gvimdiff diffuse diffmerge ecmerge"
>  		tools="$tools p4merge araxis bc codecompare"
> @@ -288,6 +288,8 @@ list_merge_tool_candidates () {
>  		tools="$tools emerge vimdiff"
>  		;;
>  	esac
> +
> +	tools="opendiff $tools"

That is a hack, not a solution.

A much better idea would be to leave the `DISPLAY` block alone and to add
an `elif test -x /path/to/known/location` block.

Ciao,
Johannes

>  }
>  
>  show_tool_help () {
> -- 
> 2.20.0 (Apple Git-115)
> 
> 
