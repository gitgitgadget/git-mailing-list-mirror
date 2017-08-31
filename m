Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6844208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdHaQXN (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 12:23:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:50280 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbdHaQXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 12:23:12 -0400
Received: from [192.168.178.43] ([88.70.152.153]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDFB2-1dhuKW0w5U-00GbLW; Thu, 31
 Aug 2017 18:23:08 +0200
Subject: Re: Bug report
To:     Kevin Daudt <me@ikke.info>,
        Aleksandar Pavic <pavic.aleksandar@nsinfo.co.rs>
Cc:     git@vger.kernel.org
References: <db0580dc-3ce0-47ba-b82a-b1e50b9d0a3a@nsinfo.co.rs>
 <20170831063614.GI3839@alpha.vpn.ikke.info>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <be66e3d8-3673-fe5e-c65d-2dc9a7202315@gmx.net>
Date:   Thu, 31 Aug 2017 18:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170831063614.GI3839@alpha.vpn.ikke.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:v97TUstsY83AWGpkWYXUssqLRXJPQOHm+D0pP1rlUvluqiTKmXg
 K4qeHS0dPWZrjagyg86GUdpZiI6CNWDp7eWmXCMm6BXYwrLQZOXTURSsfPKC3yLfJllN8FY
 Peg59DmqUgdpp/S8XiCFwAiuz7Uk57ys1Y6DjTeWaQ8dDvAFkZgYi+pmrd7EoYbzYCVFw6+
 ZHQV53mYJd0258SpB5E8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YeoBt9Cip5s=:Y9Z+rPzqw8LcEypxjzfWzj
 bcAd97kCAMTUPlYy4W5YnnAvJMwtZwOU4zSF0ppJ3rj7MB7morvff637EjzyDuxsr/YemkFWL
 IzRbPps5YvDa+vI2GEBC6saD0anKnzcZ7HQ9JhjhktYPolydi5g/R30pgERQMYl/4fBB+djit
 Q1vIKUGsdHbOJRwPdAIvOoeeQy6/JIHT/HcwKfYwP1ipVJ+z3MUMv+vdygbtin/oQ8xevHaNs
 OUQB/5TCwVPGFa4i6elcXcTGj6q34g3QvyAbeXFQ6cnM8YomqVTPrGoBlCV4dWlGdFDJOoC+C
 suDZXhSmEzf4DyGT6+niae81OoI0ihghTqlLsuFefUeRQeCFY5ueMI2q2nfzqaDeEvBQNBz5w
 P7+867eZI7pNAHySVVLkfF/CcZBw1qYmAcU+dHJcr2friK8+pxDDE1C611cjO66UVwzSkIdwv
 lnFOagDOBBRGjMFdiMfaDFCdFArbcbImG9sXLkya4VTBBmu5ffg8fZV4SrB88j/ikqm2P3uDJ
 1WmGBRe3eRK5c3K4l8v7SRmC8zREeVYqUzjLj/jazr18QJI6rD/9sUl9Ffw6PbdUAi1h0J3aU
 lZ7utX97u/zei6zryKhDIjbpfqMd5S2SdQTs3rTkh/D3IeTBEngQVv/ToioW31HKqcMOYwr72
 2G6vqOb+0+PPgh0DVrFT6eOoxHPABHs9K7FPMaUWLn2rzSpnuCvHhk4S5I//az6csZ5kPrO2b
 JCO3ktuQ8aDUQ2hKei8Ei6S05/um8PGfBKGjYh+617KBU2NiTQmzBUz/9Ap7VXSFiJA8yuo1y
 CCgtIKQBew+tFA27VnqOPrLO5qapbtJinZs6h1vMY8A59S9aM8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/31/2017 08:36 AM, Kevin Daudt wrote:
> On Wed, Aug 30, 2017 at 11:25:00PM +0200, Aleksandar Pavic wrote:
>>  I have a file
>>
>>  app/Controller/CustomerCardVerificationController.php
>>
>> And when I take a look at changes log, I get this (no matter which tool I
>> use):
>>
>> 2017-07-31 19:41 dule             o membership renew payment email
>> 2017-06-07 08:59 Dusan Tatic      o cc refund clean
>> 2017-04-15 00:16 Miodrag Dragić   o refound admin payment
>> 2017-03-20 12:02 Dusan Tatic      o CardVerification card connect
>> 2017-03-16 15:59 Aleksandar Pavic o paypal
>> 2017-03-10 13:34 Aleksandar Pavic o Production branch
>> 2017-03-10 13:01 Aleksandar Pavic I Migrating dev
>>
>> However if I manually browse thru revisions and open revision from
>> 03/27/2017 07:05 PM
>>
>> I can see the change in that file which is unlisted above, at revision
>> ff9f4946e109bd234d438e4db1d319b1f6cb6580

I am not sure if I fully understand but I guess your commit ff9f4946e1
has been commited at detached HEAD.

You could do
	git log --oneline --graph master ff9f4946e1
to see where the "missing" commit lies.
And probably a
	git cherry-pick ff9f4946e1
might pick your missing feature.

Stephan
