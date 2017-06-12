Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221FC1FA7B
	for <e@80x24.org>; Mon, 12 Jun 2017 10:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdFLKCq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 06:02:46 -0400
Received: from mout.web.de ([217.72.192.78]:61333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbdFLKCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 06:02:45 -0400
Received: from [192.168.88.159] ([194.47.243.242]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdW7q-1dkIzn3Jxa-00inVW; Mon, 12
 Jun 2017 12:02:37 +0200
Subject: Re: [PATCH v2] doc: fix location of index in worktree scenatio
To:     Andreas Heiduk <asheiduk@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20170610090719.8429-1-asheiduk@gmail.com>
 <20170610173824.19460-1-asheiduk@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <b4906d3f-7e4d-f4dc-dc39-7eac5da8292d@web.de>
Date:   Mon, 12 Jun 2017 12:03:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170610173824.19460-1-asheiduk@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WKd3uBL3d84qI+/wHbJSNNR331RnY7MI91/RsgGahGPm2Dl+v5L
 jJroZcnXLUzytCLs0v7EUat3NkEqG7BMfUAfKMiqH0yozrmBRygCD+YyVHOd+jSDgjLgpVq
 9ZXwMcAE2DNL28sOLKk1Qc7xw7kvuRvlO4XfBOCs7ZXgkENdNgDJSYhd18tYh4YPiDN2ymV
 xVp6aXZBZNDSINzSYhy/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RUhbx7SPwDk=:xXpa8d2EeBS9VQzn6zh2xn
 KbXeAZQWscKZeOyu49O5xR7Bm0Fuv90WGdzSQn759yE8z6/7STzMHKC6q4wDDOc4jhyqkqo89
 dJ9sGzKZNjszSFN/MNsPJ1xDN4sRnSyHoRqUJD3unKBxTM4B6xTiOBLvMd7ww/jrCr4B4qLwW
 sVw5ZYDS6IRNe5HmF1ViJZpPFnJVJTDVphC9Ff6I1JMrJ9aXN7qurvllqh4UqEsuQMcipcdWD
 OlTIYYx0tKcr5WfuWc7ZuDGI/kicYCqSx6aBvCNpkydRiOnD3Uj/E2PHO/a0ukTke1BvT6Hwc
 OvU4oWrhQbfGW+CEBP6L1ZlBFv3yXxqAdxJzMew/VJS60eykNa2Ih8nkcYvxACzvn5yWtTEWl
 thLuOVYbFIsMSgTiQmBYHnb6mAxabomkg8v2iZfzIzEoi5yeSzYEC8y269xrVpvue8wkXyytz
 rIEFBViAcrsWou/cJuKFIHDNaogQCcRWZIjrCX2RpUHP3xACa5WcwwyIU8hOE86AMWjnlwpdi
 pBP6shbwpKnXAXBZkFJmnSEf48AhwKf7mqVkaqH86b4EZG03yBR+MtzlshPLkh58XdYOMupni
 Px9eMSZg15qysZrtNjdeFwt53UNNhRBCLZbOQdkbJCDHH/2NcX1ltfvEwad5ygjGqhZGW4LnU
 iukvphD2qMkNLE99vVwRNzxGjAyGIsuAOxQI7Q9N+mMmgDbJQ8ovzmrEnq7+yloe1YzaWi1a9
 Zw8eelut//yDJvEminETengj9acElKP3iFm8Q3X6WO6OOM9oKi+XrJVGBmTTEyOQm7vCQZdot
 JeGcA8o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for working on this (and keeping me in cc)

The commit head line does not fully match my expactions:
"doc: fix location of index in worktree scenatio"
"doc:" is OK, but is the "location of index" fixed ?
Actually something that includes the important stuff:

"doc"
"fix"
"normalize the line endings"
"worktree scenatio"

could be more helpful.

How about this as a header for the commit:
"doc: normalize the line endings in a worktree scenatio"







On 10/06/17 19:38, Andreas Heiduk wrote:
> When setting `.gitattributes` in a second worktree, a plain `rm .git/index`
> does not actually delete the index.
This feels somewhat short. setting .gitattributes is (in general) independent 
of the index.
In normalizing line endings case the user needs to do both, fix attribiutes, 
and re-read the work tree, discarding the index.

How about this:

When line endings are normalized in a second worktree, a plain `rm .git/index`
does not actually delete the index.
Fix a long standing bug in the documentaton and use "git read-tree --empty" 
instead-





> 
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/gitattributes.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 473648386..2a2d7e2a4 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -229,7 +229,7 @@ From a clean working directory:
>   
>   -------------------------------------------------
>   $ echo "* text=auto" >.gitattributes
> -$ rm .git/index     # Remove the index to re-scan the working directory
> +$ git read-tree --empty   # Clean index, force re-scan of working directory
>   $ git add .
>   $ git status        # Show files that will be normalized
>   $ git commit -m "Introduce end-of-line normalization"
> 
