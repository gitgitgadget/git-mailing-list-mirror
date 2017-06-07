Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06F41FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdFGWOH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 18:14:07 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:46704 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdFGWOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 18:14:06 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id IjDIdiGPD9tMzIjDIdfmND; Wed, 07 Jun 2017 23:14:05 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=Q9fys5e9bTEA:10 a=pGLkceISAAAA:8
 a=E6URIzALPCrbYYsxcYsA:9 a=PUjeQqilurYA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <6500B5D478934FE1A5EB49F6B936BF80@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>
Cc:     "David" <bouncingcats@gmail.com>,
        "Samuel Lijin" <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Stefan Beller" <sbeller@google.com>, <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>
References: <1496671452.4809.2.camel@gmail.com> <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net> <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com> <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com> <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net> <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com> <xmqqvao9991r.fsf@gitster.mtv.corp.google.com> <CAMPXz=oorE7MQa4a_1eC-+Huf1Tf2XQFjEBcQxsOdso9BJ1S-A@mail.gmail.com> <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley> <xmqqr2yx8h9v.fsf@gitster.mtv.corp.google.com> <1496758102.6664.2.camel@gmail.com> <4A4DB115A50D432A8FF7B8589C5BAC84@PhilipOakley> <2d7e165d-b44c-ab3c-a4db-af5df64048a9@gmail.com>
Subject: Re: What does this output of git supposed to mean ?
Date:   Wed, 7 Jun 2017 23:14:04 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-15";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170607-0, 07/06/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfKev9eRZcWXhuhZi1c59qgYkBSxArVGkGh4q8ps0dACOeNg3lPFo+JpbJoT91BJov3zFwBSEJPeD2RcWd1O8KQTnijlGsjEMUp3nHYECQCXXDtfc4XLr
 b4SwhyuuMb/ki72kz78DtX6poDlfm2DWNrm3h8D/M0tG5WEDgEcHVyZ27QB1qa1S5ORGiD9bDxOLq5CPuru9snWAAJV+khgsOfotlPg89c+bSwxnLIx0mtGr
 gC9vftj47Krq07EWLbybeLmahYxwMw+rbupU+4pCMRAekKKVC3g0VgL3QuR4KEUwPtg5ZY6cKx50TyQq+anB3TALqO+AXH0/fzf+vjXQP5JZLxqTmKYteORu
 urV+RWGD7ZD29SYAE70gQzBVxO2DSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>
> On Wednesday 07 June 2017 03:35 AM, Philip Oakley wrote:
>> Maybe have a try at a patch to update the text? See the 
>> git/Documentation/SubmittingPatches for guidance.
> I guess this should be trivial (correct me if I'm wrong). I'll try when I 
> find time. In case I make the change which of the following message should 
> replace the message 'Initial commit' ? (this could be a poll, I guess)
>
> 1. No commit yet
> 2. Waiting for initial commit
> 3. Your current branch does not have any commits

2, or 3, or a mix of the two "current branch waiting for initial commit" 
maybe.

>
> Further what is to be done about the following comment,
>
> On Wednesday 07 June 2017 12:23 AM, Jeff King wrote:
>
> There is a slight complication, though. There's similar text in "git 
> status -sb", which shows: ## Initial commit on master Should that also 
> change to use consistent terminology? If so, we need a phrasing short 
> phrasing that matches (and the --porcelain and --porcelain=v2 formats of 
> course would need to remain the same).
>
> BTW, could anyone provide a pointer to the implementation that prints this 
> message ?

I think the two messages are in wt-status.c with the simple "Initial commit" 
at ~L1560, while ~L1728 has the "Initial commit on" line.

Philip


>
> --
> Regards,
> Kaartic Sivaraam 

