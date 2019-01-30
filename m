Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3281F453
	for <e@80x24.org>; Wed, 30 Jan 2019 13:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfA3NhK (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 08:37:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:54013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3NhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 08:37:09 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mg4FJ-1gTkvG23t7-00NUZ6; Wed, 30
 Jan 2019 14:36:59 +0100
Date:   Wed, 30 Jan 2019 14:36:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 05/13] t5701: git --version can have SP in
 it
In-Reply-To: <20190129193818.8645-6-jeremyhu@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901301431110.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-6-jeremyhu@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vRd5Jhcgh2V5OgU5p9PL9W4n+Rho4qtmwR3k8QxIUxiU/yUsuQS
 benhLu5vhtzVIuz8yQk9gQNtk3nu1ivBHJb2rukoi1u3LgWKGAvy/DLPkHIATN9NjtSnUZo
 SeldbTHwexP2DJvipHjBx81om8zH0s9VMyq1RAUtGWzs+m4OcPp46CWP2EikIDb/TWyL5rb
 J935+16UW36bCPum28fPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nb+6y+Uat14=:ko24E7QPLSq5YSMC22IQVR
 tpcGmMVnmRoqomvcG38srpYpnIRSTnNOzqZ0BoAJMzuVEMUyvyg64fjMcwEM77cdY2jKKljoq
 DwpfWdfpsohNOrL12oOOyBMSWET91ZKNt3wzWPrH8AMB4BtbjKqA32dr/HArop+GoQJttavOc
 CoM3lyPj8iljXg2t/t01MDWOYqpUgqShUw4AsLXVXdOPYRtyoZnnJkh+U8/QCQph02WC/SGds
 hO4g3hEHCqydZF1/tfsvF03WJiovB+mGL3jrqczyax9j1WAgKo9rb7K4jsPecBr1vmIi3aaox
 CirFtLGFfVu/jI7AYp4tOQcQqIDPsWMA709rpK977NAbImpzqgANO9rors7CKoFlXQK4jPYjY
 sH+hGRwi1VwL+BAIODjSeFNdSJpt/Xb+YWqpl5uPD4gQCKJng/ehAiNgMfGfFlnMpgF34n6RM
 V6yrOfgIzbcf73rU4ySvY0itoQ4+Da/Jsstl7MZ3p9xy9VETWvplV1wDWFCy6SBCqcGnFwiv/
 ktqhePwtGT2p1WxYcDK1zaSG6IdMHRS/C0mthILUQ1kB1WE6QDivC3Bz1QJR4s2hDizo1ydGV
 dUFqSafWSNX/jaOCpPqT+1nW5/GMZA9DhG8yLC4blwqAXELGo/1lhGWuXFmlBLUPeZVo0hDW6
 qdTEOEUtPcMVjNZ1RVIaLUN8JNYcSkpzgdyejls8cff5MTj0E8Mdpxvsg982Vuds9nS0JjjOA
 lC7fvhQ8gqT3JbiOG/EV/Cld3uGAu2uL4S5PQNc9+fnZzuT23LwL4DY2sUoJ4+fcrVw/pOp6O
 JKKu+/OQrKBAA9gmSJEeRTnJWhzPIMvXaZ06snIFsMNlM+hHuY4/f4TyeXtjpBxxkCvVTNf+Y
 QteI6KGPMHrTG5fraI7jdJjWgdmlrV3JKmGgACq0x0Yb68kcSdN9XiCQlgl4WrZvfV9UQA/X5
 L5nmH1MWgFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>


That commit message is again very short. Only because I remember the
previous patch's commit message do I have a clue what this is about.

You definitely need to write something here about customized forks of Git
adding suffixes including spaces to the Git version.

And you will need to state where those spaces are converted to dots in
Git's capability advertisement. The reason for this requirement: should
that logic change at any stage in the future, your patch will fail,
somebody will investigate and find this commit and *needs* a helpful
commit message.

> ---
>  t/t5701-git-serve.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index ae79c6bbc0..7bc25700fa 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -7,7 +7,7 @@ test_description='test git-serve and server commands'
>  test_expect_success 'test capability advertisement' '
>  	cat >expect <<-EOF &&
>  	version 2
> -	agent=git/$(git version | cut -d" " -f3)
> +	agent=git/$(git --version | sed -e "s/git version //" -e "s/ /\./g")

This `git version` needs to be anchored, and it would be much conciser to
use `-e "y/ /./"`, which even BSD sed understands according to
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

Ciao,
Johannes

>  	ls-refs
>  	fetch=shallow
>  	server-option
> -- 
> 2.20.0 (Apple Git-115)
> 
> 
