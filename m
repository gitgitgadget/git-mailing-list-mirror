Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F56201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 15:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbdB1P12 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 28 Feb 2017 10:27:28 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17918 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbdB1P11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 10:27:27 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (wsip-72-215-82-129.lv.lv.cox.net [72.215.82.129])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v1SFRGHJ041659
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Feb 2017 10:27:17 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'ankostis'" <ankostis@gmail.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>,
        "'Jason Cooper'" <git@lakedaemon.net>
References: <CA+dhYEWV4TWp_-sVoGCK-r14JSKsS3_Q7tfwjmowRr5V_F7BZA@mail.gmail.com> <002401d2912d$f3cefc30$db6cf490$@nexbridge.com> <CA+dhYEXtkrZk4g7KHUK_JPWCE=o4cCC9hU8inp1GJuk-V9gtew@mail.gmail.com>
In-Reply-To: <CA+dhYEXtkrZk4g7KHUK_JPWCE=o4cCC9hU8inp1GJuk-V9gtew@mail.gmail.com>
Subject: RE: Unconventional roles of git
Date:   Tue, 28 Feb 2017 10:27:11 -0500
Message-ID: <006d01d291d7$25bd8820$71389860$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHFYZ/T0/zBFDBNWTQlURYKTV0ajgIs1/SfAf5TzQ2hd4/aQA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>From: ankostis [mailto:ankostis@gmail.com] 
>Sent: February 28, 2017 8:01 AM
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: Git Mailing List <git@vger.kernel.org>; Jason Cooper <git@lakedaemon.net>
>Subject: Re: Unconventional roles of git
>On 27 February 2017 at 20:16, Randall S. Becker <mailto:rsbecker@nexbridge.com> wrote:
>> On February 26, 2017 6:52 AM, Kostis Anagnostopoulos <mailto:ankostis@gmail.com> worte:
>>> On 26 February 2017 at 02:13, Jason Cooper <mailto:git@lakedaemon.net> wrote:
>>> > As someone looking to deploy (and having previously deployed) git in
>>> > unconventional roles, I'd like to add ...
>>>
>>> We are developing a distributed storage for type approval files regarding all
>>> vehicles registered in Europe.[1]  To ensure integrity even after 10 or 30
>>> years, the hash of a commit of these files (as contained in a tag) are to be
>>> printed on the the paper certificates.
>>>
>>> - Can you provide some hints for other similar unconventional roles of git?
>>> - Any other comment on the above usage of git are welcomed.
>>
>> I am involved in managing manufacturing designs and parts configurations and approvals with git being intimately involved in the process of developing and deploying tested designs to >computerized manufacturing environments. It's pretty cool actually to see things become real.

>Thanks for the tip.
>Can you provide some links or the legislation involved?

I have not done much in the way of write-ups other than PowerPoint-based training material for the companies involved. So far, this does not seem to be subject to regulatory or legislation - but that depends on what is being manufactured. In the current situation, I'm helping organize cabinet parts, components, GCode, optimizations, and other arcane artifacts in the woodworking community for CNC and related process support. It is an evolving domain. I do wish that Cloud providers like Atlassian would provide more comprehensive integrated code reviews (a.k.a. Gerrit) for some of this work. Surprisingly that's a harder sell to dedicate a server internally.

Cheers,
Randall


