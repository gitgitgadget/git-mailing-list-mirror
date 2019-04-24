Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33071F453
	for <e@80x24.org>; Wed, 24 Apr 2019 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDXUQq (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 16:16:46 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48858 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDXUQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 16:16:46 -0400
Received: from [192.168.1.12] ([92.21.144.249])
        by smtp.talktalk.net with SMTP
        id JOJvhZeC5p7QXJOJvhHydK; Wed, 24 Apr 2019 21:16:44 +0100
X-Originating-IP: [92.21.144.249]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=Dgn57AdRJ25t4HaDIyq3iQ==:117
 a=Dgn57AdRJ25t4HaDIyq3iQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aulWLQ49AAAA:20 a=5rxgeBVgAAAA:8 a=WS_TXWvZmjCv2RXBa2AA:9
 a=QEXdDO2ut3YA:10 a=V47CcFzRC8AA:10 a=u09W0hvIdLUA:10
 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: Checkout file without changing index?
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <CAA01CsoJZMJ86mpybukqT0hVnvXi0FuRjZ23akM5kNPBdT754Q@mail.gmail.com>
 <xmqq5zr31poo.fsf@gitster-ct.c.googlers.com>
 <CAA01CsrsSQ-_bhS_T5gxDqtPa0XKbHp1c7WCgdxLVvEA3fBSGA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <2d3fe651-d1b7-5992-f091-fb72ad944d5f@iee.org>
Date:   Wed, 24 Apr 2019 21:16:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAA01CsrsSQ-_bhS_T5gxDqtPa0XKbHp1c7WCgdxLVvEA3fBSGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfNzb4DFORoGHEwNdz9YXN2VCkGoulwaBoVD8FT2Yy9Eqp9gxCLezLoZcfAi2S3/0rQ33q4Kr0TywI/8oB1Qohv5B3x29vC0yKWhx95hijcb3uaft84kD
 EuYdPnYsOzwPOyc59aSaoYEsfif8b7Rh9isMjbKqNYiCq57oztZ5RA4vB93RHmDkKATleSJog0z5W4pQOpnA7heeLYxuWWw2nYOAbSZpcku2uZBP+ZEyAw4v
 4pbBdAPOt68gbjN+Ot+Ozg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Piotr

On 24/04/2019 19:15, Piotr Krukowiecki wrote:
>> I think the new command is now on the 'pu' branch, but in a few
>> weeks hopefully it will appear on the 'next' branch.
> Is it possible to get a Windows build?
Dscho maintains a relatively recent merge with pu at his 
https://github.com/git-for-windows/git  shears/pu branch

https://public-inbox.org/git/nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet/ 
ref [1]

Philip


