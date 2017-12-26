Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A94A1F406
	for <e@80x24.org>; Tue, 26 Dec 2017 00:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbdLZABW convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Dec 2017 19:01:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:33208 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdLZABV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 19:01:21 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBQ01GXw002086
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Dec 2017 19:01:17 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Carl Baldwin'" <carl@ecbaldwin.net>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Git Mailing List'" <git@vger.kernel.org>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <877etds220.fsf@evledraar.gmail.com> <20171223210141.GA24715@hpz.ecbaldwin.net> <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com> <20171225234334.GB24104@hpz.ecbaldwin.net>
In-Reply-To: <20171225234334.GB24104@hpz.ecbaldwin.net>
Subject: RE: Bring together merge and rebase
Date:   Mon, 25 Dec 2017 19:01:10 -0500
Message-ID: <004e01d37ddc$a6683280$f3389780$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQI18OgN1v/82y7ic0+xgGKqnzs/QQHFBa0pAqjYdLgBvYCSRwFbh0wdolOeqSA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 25, 2017 6:44 PM Carl Baldwin wrote:
> On Sun, Dec 24, 2017 at 12:01:38AM +0100, Johannes Schindelin wrote:
> > On Sat, 23 Dec 2017, Carl Baldwin wrote:
> > > I imagine that a "git commit --amend" would also insert a "replaces"
> > > reference to the original commit but I failed to mention that in my
> > > original post.
> >
> > And cherry-pick, too, of course.
> 
> This brings up a good point. I do think this can be applied to cherry-pick, but
> as someone else pointed out, the name "replaces"
> doesn't seem right in the context of a cherry-pick. So, maybe "replaces"
> is not the right name. I'm open to suggestions.

Just an off the wall suggestion: what about "stitch" or "suture" since this is now way beyond a band-aid solution (sorry 😉 , but only a little). I was thinking along the lines of "blend" but that seems less graphic and doesn't apply to cherry-picking.

Holiday Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



