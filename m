Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1351D2047F
	for <e@80x24.org>; Tue, 25 Jul 2017 11:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdGYL2j convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 25 Jul 2017 07:28:39 -0400
Received: from mx-out.tlen.pl ([193.222.135.145]:39985 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbdGYL2i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 07:28:38 -0400
Received: (wp-smtpd smtp.tlen.pl 16093 invoked from network); 25 Jul 2017 13:28:36 +0200
Received: from unknown (HELO [192.168.2.102]) (lukaszgryglicki@o2.pl@[85.222.70.18])
          (envelope-sender <lukaszgryglicki@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <git@vger.kernel.org>; 25 Jul 2017 13:28:36 +0200
From:   lukaszgryglicki <lukaszgryglicki@o2.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] merge: add a --signoff flag.
Date:   Tue, 25 Jul 2017 13:28:36 +0200
References: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
 <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
 <FE86ED74-D646-4CA8-B931-26BC12B030CB@o2.pl>
 <xmqqk22ye2rh.fsf@gitster.mtv.corp.google.com>
 <xmqqr2x5d0s9.fsf@gitster.mtv.corp.google.com>
To:     git@vger.kernel.org
In-Reply-To: <xmqqr2x5d0s9.fsf@gitster.mtv.corp.google.com>
Message-Id: <33E39FC8-6C5A-4323-AA0F-B65255464649@o2.pl>
X-Mailer: Apple Mail (2.3273)
X-WP-MailID: fdeff32d16cf8f36ce03b0e133f6d5cd
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [wfM0]                               
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, can You take a look at my newest patch version (v3)?
> On 24 Jul 2017, at 22:42, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> lukaszgryglicki <lukaszgryglicki@o2.pl> writes:
>> 
>>> Hi, what is the state of this patch?
>> 
>> I was expecting you to respond to Ævar's <87tw2sbnyl.fsf@gmail.com>
>> to explain how your new version addresses his concerns, or him to
>> respond to your new patch to say that it addresses his concerns
>> adequately.  I think neither has happened, so the topic is still in
>> limbo, I guess...
> 
> Sorry, Ævar's message I meant was <87fueferd4.fsf@gmail.com>.

