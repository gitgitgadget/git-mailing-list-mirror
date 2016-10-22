Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A76420229
	for <e@80x24.org>; Sat, 22 Oct 2016 05:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbcJVFpl (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 01:45:41 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:28454 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbcJVFpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 01:45:40 -0400
Received: from PhilipOakley ([92.22.49.100])
        by smtp.talktalk.net with SMTP
        id xp7hbxmQaxR4bxp7hbOfks; Sat, 22 Oct 2016 06:45:38 +0100
X-Originating-IP: [92.22.49.100]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=IeMlVUjV5MTIAXSPXElgMA==:117
 a=IeMlVUjV5MTIAXSPXElgMA==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=3Eyz6yWsl_VLsd-ZWU0A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <715E1D41ACDD40D0B8046CA9220B77A9@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <20161020234009.1768-1-philipoakley@iee.org>        <xmqqa8dyeebj.fsf@gitster.mtv.corp.google.com>        <D861234B3E78496DBA70EE63B2BCDB96@PhilipOakley> <xmqq1sz9b9ex.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] doc: fix merge-base ASCII art tab spacing
Date:   Sat, 22 Oct 2016 06:45:38 +0100
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
X-CMAE-Envelope: MS4wfIitjqsIRKDXh3jCJ6J+g6Vh933ZVkFEpi5RfAjPPisI5RQ6G94GCvWokUk/rhfsBci9TVbXDs/4qmofl48E1zlvNNAMzV+x++La7G6WUcv9Br9cE5/J
 5bdBr5Xa1IvBHVHbEsMr4soys7Y4YIaNJQTjmwnZrvIvc1GZLeLFBPhFLBDnK30KYbZD6ssSdL2g2SGuxgahsMwCHM0QrsfXDlDsGkupLmUE5qKpvvsq8EvL
 75Clj/SAdHQKcuetlVlabA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
>> It appears that acciidoctor sees the art as being a separated
>> mono-spaced block, with border/background as locally
>> appropriate. While the asciidoc looks to simply change to mono-spaced
>> text.
> 
> FWIW, I changed my mind and your patch is now queued on 'next'.
> 
> Thanks.
> 
Many thanks

Philip
