Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C991F424
	for <e@80x24.org>; Thu, 19 Apr 2018 07:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeDSHrs (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 03:47:48 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:27916 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeDSHrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 03:47:48 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id 94IAfwBsI4Zqz94IAfk0bG; Thu, 19 Apr 2018 08:47:46 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=xtxXYLxNAAAA:8 a=MG8gEn-HevpAMUs9EpEA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <32318E6BB2994998ADFEF47E05F839D4@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Duy Nguyen" <pclouds@gmail.com>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Git List" <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com> <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley> <CACsJy8BqoW_YWBiMoOks+WM5XY7Mmadkd0LUBoUWLDXehx1GZQ@mail.gmail.com> <A9B6B3A17C4844C69F8865C01BCFC51A@PhilipOakley> <CACsJy8BTX=6FsH7-Dc86ExQRfBSNVn9yxD5JrNZyLT9VDQOPEg@mail.gmail.com> <20180417164831.GA18563@duynguyen.home> <8F15D4F40F164250987F5DD3896AD825@PhilipOakley> <CACsJy8APfzL_VchsUT0KgKooijARbMqkcFd6rC4A2v5LV84Gww@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
Date:   Thu, 19 Apr 2018 08:47:42 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180418-4, 18/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfAEwI7uDT73UPTPlKnxOxWr762sX4lG95KlqXCuS845EXOfcIoQP2oaGu7lhUURbbLIFukjv7Wr9T11a5ubq2ctN0gzrtrweTyuxixEkzBcL0hrgfhSH
 ZXOLb0b79rnAeNabbbpNy9hV6Ls+/JK/acCgtSl1hUAE3sndOVy+66+6h4YilRGpTxI4nvt7qf0hF+7wQOyLiZ3BJEgImnC9pDF/WDMbAnibsWR1tOggDMTV
 o8jI2/iTwnO0MTo/EXy2eNOdqkklzeLskrBfpE4Xw3Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com>
> On Wed, Apr 18, 2018 at 12:47 AM, Philip Oakley <philipoakley@iee.org>
> wrote:
>>>> > Is that something I should add to my todo to add a 'guide' category >
>>>> > etc.?
>>>>
>>>> I added it too [1]. Not sure if you want anything more on top though.
>>
>>
>> What I've seen is looking good - I've not had as much time as I'd like..
>>
>> I'm not sure of the status of the git/generate-cmdlist.sh though. Should
>> that also be updated, or did I miss that?
>
> Yes it's updated by other patches in the same thread.
> -- 
Thanks. Hopefully I'll have some time this weekend/coming week as my wife is
away....
Philip

