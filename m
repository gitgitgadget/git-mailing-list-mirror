Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8751520248
	for <e@80x24.org>; Sat, 30 Mar 2019 17:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfC3RRw (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 13:17:52 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:23934 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbfC3RRw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 13:17:52 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id AHc6hKcc0WIpcAHc6hHlSV; Sat, 30 Mar 2019 17:17:50 +0000
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=We0TE4j0AAAA:8 a=Lczhz_mWAAAA:8 a=I7LBQiMBkbgBjNC8B_QA:9
 a=QEXdDO2ut3YA:10 a=_eRXXHC6AMsA:10 a=T8AJnZ-oFs04XlNxSoO0:22
Subject: Google "Season of Docs"
References: <8bb78ce0-9b32-7c49-e4aa-ce9f31662627@thingbag.net>
To:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.org>
X-Forwarded-Message-Id: <8bb78ce0-9b32-7c49-e4aa-ce9f31662627@thingbag.net>
Message-ID: <572677cc-eef3-345b-e970-cd6cc80e8e96@iee.org>
Date:   Sat, 30 Mar 2019 17:17:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8bb78ce0-9b32-7c49-e4aa-ce9f31662627@thingbag.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfHetyaN3lIlOJjIWlVwGeiY3wWP0BcGSqpbKJQyTqFRFDPX+Xj0HkqBPP8zOcwTQAhhrEJ84OdnBT64E3Ds5ihL99qhvqRJ1a8E90saEsc4fAy/KZn+g
 UgnT/R7wgdQ1FZ0FJut8Jstz5gUPdI4Kq5xwQSHHuPr5sYuCqlbRrhdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We mentor Summer of Code projects.
Perhaps we should be doing something similar for docs.  Now Google are:

https://opensource.googleblog.com/2019/03/introducing-season-of-docs.html

April 2-23: Open source organizations apply to take part in Season of Docs

My thoughts include:
* There is an expansion in the user base (e.g. 1.5m downloads on 
Windows), with a corresponding shift in focus (application to practice).
-- Are more examples needed, are the basics understood,
* Manuals are no longer printed, so readability assessments should match 
screen formats (maybe).
-- bite-sized chunks
* Developers rarely want to write documentation (it's too obvious to them)
-- if stack-overflow is the go-to source for 'real' users, why not mine 
that source.
-- Our code base has become larger than the average brain-full, maybe 
that (developer education) also could also benefit from some further 
structural documentation.
* Git for Windows: to few developers, large gaps in knowledge, chasing 
both upstream and MS directions of travel, a high hurdle for WinDevs to 
get started,..
-- the wiki could be built upon, anything to get more support..
* git-scm - the book - at least make it easier to find the 'how to help' 
page! (falls between the Github corporate and Open Source stools, or so 
it seems)

does anyone else have pet thoughts..?

Philip
https://www.infoq.com/news/2019/03/google-launches-season-of-docs
