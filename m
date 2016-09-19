Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3C82070F
	for <e@80x24.org>; Mon, 19 Sep 2016 16:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbcISQWL (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 12:22:11 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:10184 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbcISQWK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 12:22:10 -0400
Received: from PhilipOakley ([92.22.33.116])
        by smtp.talktalk.net with SMTP
        id m1KabM1UPcpskm1KabadIR; Mon, 19 Sep 2016 17:22:09 +0100
X-Originating-IP: [92.22.33.116]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=7PoCAWDTb98b1EGiAsJI/w==:117
 a=7PoCAWDTb98b1EGiAsJI/w==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=3Eyz6yWsl_VLsd-ZWU0A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <15B3BA8028D444A0B458BEDF18929D4C@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Fredrik Gustafsson" <iveqy@iveqy.com>,
        "Andrew Johnson" <ajohnson388@gmail.com>,
        "Jakub Narebski" <jnareb@gmail.com>, <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
References: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com>        <20160917183919.GJ20666@paksenarrion.iveqy.com>        <223e818d-6d10-2679-c2d0-150011e74a59@gmail.com>        <630656BFF8F84E43A2E4C67138A9A675@PhilipOakley> <xmqqlgynhocy.fsf@gitster.mtv.corp.google.com>
Subject: Re: Why are there multiple ways to get the manual in Git?
Date:   Mon, 19 Sep 2016 17:22:10 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMGKKEdyaEm3h62VN9OyNrGwgy1hIA/5hOj1ztAbabc93BD7j5dS2Z9zSNRLMsdS7zcAPEnIKoCUxX5/D+NXSQ+rYKtDDiTfpEMzApX7mgbQu4E+WhcX
 raHgJyZ4sITC49ZZjgZ6lV7rMdQ1MgHTl9Rh8REkY8V9wq8TC43YCXSte7cCYTvMP/Iuod9HLCnJFnKVhyvgGsYmILwUsXJhgM1iS/dn1kwNLiI4wyJHlbPm
 4h+rKOhip4TB6UVS0gqbY6/HzV8Xttrm++oEgrfyd+sU04nvy9eKJht2oivJ28zO6jLmjbKuUWaAU4AelWfBww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
>> The `git revisions --help` does work ;-)
> 
> Not anymore ;-)
> 
> I think Ralf Thielow fixed it recently.

hmm, I sort of though it would still work with a valid guide.

I'd only checked with my last GfW version.
--
hey ho
Philip
