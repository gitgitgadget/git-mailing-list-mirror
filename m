Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E8B2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbcGGOM5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:12:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:54219 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbcGGOMz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:12:55 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ldttv-1blNv81qvD-00j2aa; Thu, 07 Jul 2016 16:12:25
 +0200
Date:	Thu, 7 Jul 2016 16:12:23 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Mike Hommey <mh@glandium.org>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: counteract gender bias
In-Reply-To: <20160707124943.GA22668@glandium.org>
Message-ID: <alpine.DEB.2.20.1607071611100.6426@virtualbox>
References: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de> <20160707124943.GA22668@glandium.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:f2pq6oxR+qi4wMn3PJmwJb+x8qQYqYjKoWUxpGuQT2p+9QtUH93
 NiWGuwIH71K8LSNwdk+o5PwLNsvnbEMnHhqT7NHmOlj3NiLk9rhQVlqbsEsh8Dt0W3pb+zh
 mfRnywzZA6ASq4YINXxsgUIkxXDptYrS1prBjqqLHKLf0NaxKMMTUTMk1t07jW2T+wk0+bE
 dYEk5sBUrFrs16aDJ7vlw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TxfYyL+Lhs4=:lWnXiAKH934UBK4dpMwxkL
 VfJU1vTWPnxyPPz1fj2YF4t3DPT8/ZvlzdJfwhjsmf+t55pnplLxNz9Fg8OpLeVLLtPzSN0qh
 rv5NuAQIYqv2L6htaW/ua6ITM7aCG/v4VkRHU7Ov69mzFDckW1VGKCY77n5qilp3+LvbGSGoO
 Mhuka4PIVp8stq+jkht4s9ZTdmvm6QRqO5mRw3ldb/IuI5joZ0jrBawGITiCNgnr9b18zkZ0W
 VBSGdxZesZ3zqoROSsL/mCy3D8OO3TB8hWsZluQ0cMDEWYZnPnXOAqJE/xrOeVtDNJqXr7ERp
 lSjhi73xvVF1kViBuuki2W5lVHZICKOAoKHjqrhMKopdxfD1JwBo0kdYNj+ruaUDP04JVIo7V
 WEDt620NNGUMj6UxuIeUJ8MaiAACU1tb7e10CMKRobOXX0d8e1LbU1tR2s9eYCvP5AZHiau3A
 I90l4wtgXF0oINBRjIM9Wwl/rQ6a6lQLtSxorU36tlFjkJoucW/fqaS6SS73IDHgH0NfdyciV
 9OphBlcHT6Tl1u4QPPfJ5ayhxp/cY20z/HfSFGHeGsLMQ26ZDQvk3txwv/ynMeg7j8jSLVBvC
 tmnKawNEEDwaEIU9RkighU4QiFgsizojwBNo9I93I/VVkUZN5BAesYJOsdCJgeijkOcHrDwAx
 tFrlqIhXoIPe7atBh2i42JB9Q2K4s1AG+F15EXS1nsrap7ScAIAtqdTsG9NK7zi4ovw27+rd6
 ri0EnFHeF73/ELL/luo5833n74qkpaDJ6KgThmNAymtZVuwp7CQN/P6EE6fCI5o4JF2orCu7x
 wifGNwn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Mike,

On Thu, 7 Jul 2016, Mike Hommey wrote:

> On Thu, Jul 07, 2016 at 01:47:19PM +0200, Johannes Schindelin wrote:
> > Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
> > almost 11 years already, we demonstrated our disrespect to the pioneers
> > of software development like Ada Lovelace, Grace Hopper and Margaret
> > Hamilton, by pretending that each and every software developer is male
> > ("his_tree"). It appears almost as if we weren't fully aware that the
> > first professional software developers were all female.
> > 
> > We know our field to have this unfortunate gender bias that has nothing
> > to do with qualification or biological reasons, and we are very sad
> > about the current gender imbalance of the Git developer community.
> > 
> > Let's start changing that by using the variable name "her_tree" for an
> > equal number of years out of fairness, and change to the gender neutral
> > "their_tree" after that.
> 
> You make it sound like the decision to use "his" was conscious and on
> purpose. I doubt that was the case, especially 11 years ago, when these
> issues weren't as publicized. Let's not attribute to malice on part of
> the people who wrote those lines what can be attributed to linguistics.

It was not my intention to imply that the original decision was conscious.

What with me being a non-native speaker, would you kindly suggest a commit
message that conveys the intention better?

Thanks,
Dscho
