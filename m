Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36F01F859
	for <e@80x24.org>; Mon,  8 Aug 2016 06:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbcHHGtc (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 02:49:32 -0400
Received: from mout.web.de ([212.227.15.3]:62990 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbcHHGtb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 02:49:31 -0400
Received: from macce.local ([79.223.101.66]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MhOpG-1btHYN0m6U-00MdjB; Mon, 08 Aug 2016 08:49:01
 +0200
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
To:	Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
 <20160804225649.q77p4u6cbdo6q336@glandium.org>
 <xmqqfuqkyutp.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <3e98179d-a13d-e0a1-038a-dd9cc5739cd8@web.de>
Date:	Mon, 8 Aug 2016 08:48:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqfuqkyutp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ySEwEKuksCIOxRsCbffXlUUNzTtjLds4Cu3xuOf7TrwF/13pSIH
 NoRZqCAfpHblFxendRUN/ByWEjIwvkmXVqDnKTaWCEfEfNeGY4XNMg+x+NjESVQYvUehkZD
 OPbu2SYEBJ7T3SisuB5+Ya9M2izDYXVTUDzMDUoXtOpCR0N0QKm4eEFZM2h971tXYl/HnFL
 R2ugfyDD1MVmck3ztohyg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:gJgZiHw5FAk=:j/WyMrV3gt0LzfbNkx+BFK
 QZBHxgOhqZksrEyNFrHIwKkCuMm2itC4c+912pdaRilTyR4lJB/qblmQZoBQ0NScjvRm73A8n
 57/FlZhzqV0x46vNBCH7l4+NfCgTPmOWe3uQruCzCHAQD9KTk08UE4Q1ODKqRqLCnkqQnMjDY
 8lm5Z18VG0ComtZPBaoXI3i7A95PqDUmHeY0STnXcTkmDFvEoMbkBqkMhoqc+4OfJKwSTNEf1
 jk4QOIEGHYYwnbITdJl/1nBkYUhUU6wk+T+WBypCVu/domtGKTZYrWOBxNQ6L1kApOvru2FeU
 zR2izVWa/CWLwAOKE2V3VPTMv3c1Fjz9+yrvf7ekMR6cqN9WNVwMqIa4sL6Hl0DlwfC9CDI8/
 G2/xrlDeH6kFAp5Z4mgGH/rzgJOhUKi7pJjIW9ywVfMorYN4aUI2yUrS5tfVNDwfdGp/GObE5
 z525vMu0D2G3ZE9/MlNApYbolyYj54wjnXcv2iH30JK4foFDGjdaPPtKUKQGXxGGMWIDTOpkj
 mReuKpkS8yuZUW6i5Rif6oD/xO6N21IfvFi0He8UihoW3lC+jKz/pvT5CZ4SxdTaiQfdaduUs
 ZP30skpIOMuV0CQ+HKMKoBsr6euUywtFsrwbrN11OkhU4pnxN5Cz1CPmv2VHscXJBv8xbLhDW
 NRbnESaFuNZPlWoLvA4D7B3yQBRivhltSIa4sSYN7jQgnfgbCY99Da8iuyhyMJ8vKuvs4NPoe
 sUsNFI69ynkYprkc8fw7LRoCUxnxZt8FjsxwMrPQkYXp5e/zlMVkbJp/ymtveJpiquKN5Mpql
 2RC7u/1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-05 01.32, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
[]

>> What kind of support are you expecting?
> 
> The only rationale I recall you justifying this series was that this
> makes the resulting code easier to read, but I do not recall other
> people agreeing with you, and I do not particularly see the
> resulting code easier to follow.
> 
If that helps:
I can offer to make a code review,
and come back at the end of the week or so.


