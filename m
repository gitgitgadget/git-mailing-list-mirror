Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BCF1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 21:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcHPV3h (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 17:29:37 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:25120 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcHPV3g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 17:29:36 -0400
Received: from PhilipOakley ([92.22.79.128])
	by smtp.talktalk.net with SMTP
	id ZlvRbOlccxR4bZlvRbcy9j; Tue, 16 Aug 2016 22:29:34 +0100
X-Originating-IP: [92.22.79.128]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=XEvdTb7KCAz4OJCw3EI8rA==:117
 a=XEvdTb7KCAz4OJCw3EI8rA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=8rg8s2i0kd85yYEDVlAA:9 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <A12D8350E1E24F12B530B6EBC9B4E321@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Duy Nguyen" <pclouds@gmail.com>,
	"Jacob Keller" <jacob.keller@gmail.com>
Cc:	"Stefan Beller" <sbeller@google.com>,
	"Git List" <git@vger.kernel.org>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com> <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com> <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com> <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com> <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com> <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com> <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley> <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com> <3E80981D72F74A11A41A228901644E1C@PhilipOakley> <CACsJy8CXKcjo6KO8HvBpx+N4Lj7MO5yMH2q4bVWi-x3mbvWsmQ@mail.gmail.com> <CA+P7+xr+HonJTj5AcRhAMf5Z059zHKiuOY8Zbd77uu_jAiiZBA@mail.gmail.com> <CACsJy8DJmONcgQO37Xk+2cZb+Svx-bgwjrG1XrZQ4BYipownqw@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
Date:	Tue, 16 Aug 2016 22:29:33 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfEFN70ogb02pH6xeI3zBodxZ9kIwTqlTRNMZtCPr7THGml9nLOMSkNk8d4g+kh1ajiD1Ko2d3fPHBTV7LvvnKpS1Ur9x16rZDS8HcUiiiOX2QQP57O/T
 LupwS1ofsncQlKLX4iRUW+L7G0Xdv5u/ohC6fuRdN0fqcsi6DKlqp8NyIqZNp4q5y1N/cFww4GT6COMqNIAEyj86mXrbzuTap7eiSgFMQf0x8lKdr1pZHm1p
 rJyZFrvdQWCbKnjSASzJeQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com>
> On Tue, Aug 16, 2016 at 12:26 PM, Jacob Keller <jacob.keller@gmail.com> 
> wrote:
>>>> They can just add "squash! cover! <series>" commits for that ;-) Though 
>>>> more
>>>> likely the advanced workflow would be used... We'll need both (more 
>>>> than
>>>> one) options.
>>>
>>> Or even better, "git commit --reword $SHA1" brings up the editor with
>>> commit message of $SHA1. Modify any way you want and it creates a new
>>> empty, "reword!" commit that contains the diff between the old commit
>>> message and the new one. "reword!" can be consumed by "rebase -i
>>> --autosquash" without bringing up the editor again. I realize making
>>> "git commit --reword" run multiple times would be tricky though...
>>
>> I was just thinking you write text and it gets appended to the text of
>> the reworded commit, and when you squash them using rebase you get to
>> finalize it like a normal squash?
>
> I think that's what Phillip meant by 'squash! cover!' though I wanted
> to go further, I don't want an editor popping up at rebase time,
> instead 'rebase' just update cover letter automatically for me.
> -- 
Hi Duy,
While we can have code that is auto merged, I don't think that I'd want to 
submit a cover letter that was simply auto merged. I'd want to refresh and 
re-personalise the text. As long as the flexibility in our cover letter 
inclusion is there....
--
Philip

