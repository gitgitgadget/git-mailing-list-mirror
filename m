Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547541F463
	for <e@80x24.org>; Thu, 26 Sep 2019 19:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfIZThP (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 15:37:15 -0400
Received: from mout.web.de ([212.227.15.3]:54709 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbfIZThO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 15:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569526629;
        bh=v1Etb0Q8hvzPlvx8fVuyrMQ+JWS2qADKM8YvUJ53ULU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=omJM/yDRw2tFSkHz6XxNnC59sJKW8bh4jD7DwZuNseq/wQwyO8d9ETnpbYRj6ksel
         ySijlKa0SSSExeqx131aQhirel19uIf5TmNKJY5TfB7wbeesRmOd3GdUy5iu2/dD53
         TTMSfLvi8qvt/LNgQAkgS1IlebDKZhElS4Tbfwu8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2dxF-1huoCW21WH-00sNae; Thu, 26
 Sep 2019 21:37:09 +0200
Date:   Thu, 26 Sep 2019 21:37:07 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Update: fixed typos in commit message
Message-ID: <20190926193707.wx4iu3ctbmbssxwd@tb-raspi4>
References: <pull.347.v2.git.gitgitgadget@gmail.com>
 <pull.347.v3.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <pull.347.v3.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:2lyeTVYy92WjIK3OFTFBdigPFFOSHRod7JlUM64z6qqFvpRj4IX
 i8pHMDVbhdnagMCBmjicpXZ2kRFxiJlHMWq7HckWRIXGiTxyD3bKhoD9CiAf3TplcCRtzIU
 Xuhes2AhHgsQKNTcxuSp7NXklBJal0PX1s69hpjxFWUwI2QXQqjuvx4UhSH2dqN3XYFKEk4
 Oea7Ilxz9WZjxjQstq92w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YOhWkGlBjBc=:rym+CbhxHa13/qEC5UNUvY
 frzgTjB+We4NnFSSYBr7v9bUGFvF54YZMGY7tTBhtDm975YzTjT9oF/7ouFEKVvSox7dTrs3+
 13fRuaonYV27qgFVt8MFpSe/BoWPM+ZLXD7LVMMujcaXHZkuaf1FIYfiWyKPVywV9R1ZABGDx
 /oWjZ2no2UbU3NTEW0UWtqRCMVgTQynmpvMkjqdzuvoW3JBr1L23Zcqq+bcNU29an8+L7Hy4z
 K24dpQaoUvovf0x/q93eZCOo3oP90VBFMKzMoW9IEU/PAUcOhliY5ZTDUCawlGi828CTsigv3
 Gg4GADUKdHTwj9cGuXpS/x2yjWmh89kXeXiHP6HhRsADnhjJF5NznGOwCBXoip7AUeIrToFUv
 U26YXKFf3YrJsKqnC7cWNgqsinvhHnSGkz6zeaZ3JlN+66QZAxSV+CaV4Pqh7AbecQpQQOA8j
 UnJSxFZ0AM1t7yi255UcKewP3wPNpE0Jogdedjlwj+qm/9HxyGoAiOc7b5QLTlvPjX3uLAEiz
 dLoJvGbnzgUDrFfSbV/t59CEIapULagOOCR42G4uSNWrmKQInV7WTr4IvELQ+Nxftd0ZyWEtZ
 q5ol4GHyrjLkjiGZiexTLCLUGKd3thEW9HxafxPPr15t4V6RurXFJ+hJ1m0HTjyWrh4reYoCA
 PuFg3PckSrq9zMgWNcv0LpmCMHpJdmegoQ9vJLtEg8K9X9S9qHT9MDno8z9CDV6g/8m2IT/7L
 v2ukJu7X53a51BHpeRS/PPVFzsq2u6iCUXef78fPd6h5ppgMKOHR18SFIZI0d2YhbnH/465BQ
 Nz0Ar4xdg5o/wiUF/nyGNBZ5AjwCT2C+u6BVpJRPhcDz94FcmWJbeCZ4n9sueZm2AXxQGAZCN
 n7fEIYuI3MDYNzGwUm0BmG8Jj6tkQdG6DsidxFRj39409dWeOGgGADmBGgmx93Cg5wxPBruGT
 OML8Tm0ajcB1hJsdtaPPsFKO6hRIf4TlAtdPHVetDJlFtH05TI/clfKG/FSJkQzGK/yjd24UY
 Fb1lhcNdyTqU1gRdUvmCM0+kgXQZvTV8lzwPsj2e/8M/LTsg70VxgRVQFqUi7K1Rx/sdEZP7A
 soDtZ6kv9S42ndC+dxQYNlTfkZRLHnDfZyUEOvMFCY4o45/jHy7r0eGuiPfyS4Q1MfplinEJc
 RbbeigKpMl9RRm5HrIX6LLUu2C6WCGTAwSHxae/NWH4ts41sHymgcjVRkQELnMQ+WECidlQ+O
 PeEvUOwdnXrP/Q3aXM1zIrE5Etcu9VsV2lLM+lQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 03:40:28AM -0700, Alexandr Miloslavskiy via GitGit=
Gadget wrote:
> Commit 1/2: t0028: fix test for UTF-16-LE-BOM Commit 2/2: t0028: add mor=
e
> tests Please refer to individual commit messages for more information.
>
> Alexandr Miloslavskiy (2):
>   t0028: fix test for UTF-16-LE-BOM
>   t0028: add more tests
>

Thanks for the update -
Reviewed-by:  Torsten B=F6gershausen <tboegi@web.de>
