Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A742A20372
	for <e@80x24.org>; Sun,  8 Oct 2017 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdJHJck (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 05:32:40 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:50192 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdJHJcj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 05:32:39 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 17wpeQJPKbjdZ17wpeYqQt; Sun, 08 Oct 2017 10:32:37 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=5JiEu4T7_tMj_uWqSNsA:9 a=QEXdDO2ut3YA:10
Message-ID: <8686C1FA80EF45099730B50235CAFF6F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        <git@vger.kernel.org>
Cc:     "Jiang Xin" <worldhello.net@gmail.com>,
        "Alexander Shopov" <ash@kambanaria.org>,
        "Jordi Mas" <jmas@softcatala.org>,
        "Ralf Thielow" <ralf.thielow@gmail.com>,
        =?utf-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
        "Marco Paolone" <marcopaolone@gmail.com>,
        "Changwoo Ryu" <cwryu@debian.org>,
        "Vasco Almeida" <vascomalmeida@sapo.pt>,
        "Dimitriy Ryazantcev" <DJm00n@mail.ru>,
        "Peter Krefting" <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        "Jacques Viviers" <jacques.viviers@gmail.com>,
        "m4sk1n" <m4sk1n@o2.pl>, "Junio C Hamano" <gitster@pobox.com>,
        "Stefan Beller" <sbeller@google.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com> <20171008084824.5331-1-martin.agren@gmail.com>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
Date:   Sun, 8 Oct 2017 10:32:35 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171008-0, 08/10/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfE0aJFj0e7+gJRJozFEnFjKeuwSDuTvA32K85y9TPX6PryaagbSLmpDAZWIQi5zDxem9Nc/FuMficq/qZsefizZgqayB9BpxseAHpDRMaHl11TCgMkDD
 tgBwi/nfUevOonhRfgrIvBxQrTu2/kIEoAPIVSg827Jdqvtq6t3mSAgPuXOHzayCUUe+wnUd8xGH3S3aWak69EpQZ12BtR9vs725Luw/74C14xO4aQvNgaIi
 yFvNEQbiZsa3Ws3PmRWxCSbq++X3SXZYUWgmKjJGrcS7yuFQHJistTAD5ogpKim9+tAfoyRyqQiwd67C3EKbkkQPxrCTKtTJHH9pYtuoHT1qLMgvmhcFsK0j
 JIbL4y7GZpD+s7Rn5iIESiaER/vEYeAWL8uf3zXZ0ypw+o9XIcR+YAhCVvSVtZI8PQZ5FqSI700LYOjOJVpddsmpllZLkMZuPMfFjqwH//vrJEBglOmYMATH
 QOkg5sUJVKjdWKSmENJGq5PJytAktNI83RqXc0nFrsFi6NGCNJuKGMl5sJ4/4QgL/A1J2+h8z2fBjh1kXHqlZWVoSueZLlc//OCDT3hP29cfq3YHiUrtfZ4n
 MbsZfmnxYbVeMBCJdbDmswRz0RlA5Sg89NrY9Q2VsLzSoqMIu0k0YnYSrqCKLYAbdMSgVYgPhrMxVW50OYhN7HCWKjKSM/5EoN6oTmpO6rHOJ5wL+OyWYq+G
 Yx1ewbVAUC8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Martin Ågren" <martin.agren@gmail.com>
> We currently build an error message like "entry is a %s, not a commit",
> where the placeholder will be replaced with "blob", "tag" or "tree".
> Apart from those three placeholder words not being translated, in some
> languages it might be awkward or impossible to ensure a grammatically
> correct end result.
>
> Shorten the error message to "entry is not a commit". We will still
> error out, we will still give a hint about what is wrong, but we will
> not be as explicit as before.
>
> Alternatively, we could have different switch-cases for the different
> types and pick one of three different error messages. We might still
> want a `default` and maybe more tests. So go for this simpler approach
> instead.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> I browsed the diff of the .pot and found an addition that looked a bit
> translation-unfriendly. Maybe something like this?
>
> submodule.c                    | 4 ++--
> t/t5531-deep-submodule-push.sh | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 63e7094e1..3d91dbfd5 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -796,8 +796,8 @@ static int check_has_commit(const struct object_id 
> *oid, void *data)
>  cb->result = 0;
>  return 0;
>  default:
> - die(_("submodule entry '%s' (%s) is a %s, not a commit"),
> -     cb->path, oid_to_hex(oid), typename(type));
> + die(_("submodule entry '%s' (%s) is not a commit"),
> +     cb->path, oid_to_hex(oid));
Bikeshed,
 maybe:
"submodule entry '%s' (%s) is not a commit. It is a %s"
This puts the two parts in separate sentences?

--
Philip


>  }
> }
>
> diff --git a/t/t5531-deep-submodule-push.sh 
> b/t/t5531-deep-submodule-push.sh
> index 39cb2c1c3..e4c98bbc5 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -305,7 +305,7 @@ test_expect_success 'submodule entry pointing at a tag 
> is error' '
>  git -C work commit -m "bad commit" &&
>  test_when_finished "git -C work reset --hard HEAD^" &&
>  test_must_fail git -C work push --recurse-submodules=on-demand ../pub.git 
> master 2>err &&
> - test_i18ngrep "is a tag, not a commit" err
> + test_i18ngrep "is not a commit" err
> '
>
> test_expect_success 'push fails if recurse submodules option passed as 
> yes' '
> -- 
> 2.15.0.rc0.37.gd35688db1
> 

