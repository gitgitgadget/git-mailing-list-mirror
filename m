Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAA151F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdB0Tye convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 27 Feb 2017 14:54:34 -0500
Received: from elephants.elehost.com ([216.66.27.132]:59352 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdB0TyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:54:25 -0500
X-Greylist: delayed 2232 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Feb 2017 14:53:33 EST
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (wsip-72-215-82-129.lv.lv.cox.net [72.215.82.129])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v1RJG71m014676
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Feb 2017 14:16:08 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'ankostis'" <ankostis@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
Cc:     "'Jason Cooper'" <git@lakedaemon.net>
References: <CA+dhYEWV4TWp_-sVoGCK-r14JSKsS3_Q7tfwjmowRr5V_F7BZA@mail.gmail.com>
In-Reply-To: <CA+dhYEWV4TWp_-sVoGCK-r14JSKsS3_Q7tfwjmowRr5V_F7BZA@mail.gmail.com>
Subject: RE: Unconventional roles of git
Date:   Mon, 27 Feb 2017 14:16:03 -0500
Message-ID: <002401d2912d$f3cefc30$db6cf490$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHFYZ/T0/zBFDBNWTQlURYKTV0ajqGXl9Kw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of ankostis
> Sent: February 26, 2017 6:52 AM
> To: Git Mailing List <git@vger.kernel.org>
> Cc: Jason Cooper <git@lakedaemon.net>
> Subject: Unconventional roles of git
> 
> On 26 February 2017 at 02:13, Jason Cooper <git@lakedaemon.net> wrote:
> > As someone looking to deploy (and having previously deployed) git in
> > unconventional roles, I'd like to add ...
> 
> We are developing a distributed storage for type approval files regarding all
> vehicles registered in Europe.[1]  To ensure integrity even after 10 or 30
> years, the hash of a commit of these files (as contained in a tag) are to be
> printed on the the paper certificates.
> 
> - Can you provide some hints for other similar unconventional roles of git?
> - Any other comment on the above usage of git are welcomed.

I am involved in managing manufacturing designs and parts configurations and approvals with git being intimately involved in the process of developing and deploying tested designs to computerized manufacturing environments. It's pretty cool actually to see things become real.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



