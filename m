Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77831209B8
	for <e@80x24.org>; Tue, 12 Sep 2017 04:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdILExO (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 00:53:14 -0400
Received: from ikke.info ([178.21.113.177]:55136 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbdILExN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 00:53:13 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id C837444012D; Tue, 12 Sep 2017 06:38:15 +0200 (CEST)
Date:   Tue, 12 Sep 2017 06:38:15 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] doc/for-each-ref: consistently use '=' to between
 argument names and values
Message-ID: <20170912043815.GA23062@alpha.vpn.ikke.info>
References: <20170901144931.26114-1-me@ikke.info>
 <20170911193338.25985-1-me@ikke.info>
 <xmqq8thk3b2n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8thk3b2n.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 11:28:00AM +0900, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > The synopsis and description inconsistently add a '=' between the
> > argument name and it's value. Make this consistent.
> >
> > Signed-off-by: Kevin Daudt <me@ikke.info>
> > ---
> >  Documentation/git-for-each-ref.txt | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Good idea, and I think it is in line with an earlier suggestion by
> Jonathan (cc'ed).
> 
> Thanks.
> 

Yeah, this is his diff applied. Forgot to CC him.
