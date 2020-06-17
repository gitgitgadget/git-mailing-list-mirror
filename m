Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98134C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7491B2085B
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFQI1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:27:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgFQI1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 04:27:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 71B52AC46;
        Wed, 17 Jun 2020 08:27:53 +0000 (UTC)
Date:   Wed, 17 Jun 2020 10:27:47 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Don Goodman-Wilson <don@goodman-wilson.com>
Cc:     =?iso-8859-1?Q?S=E9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, philipoakley@iee.email,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, newren@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200617082747.GL21462@kitsune.suse.cz>
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
 <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
 <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 14, 2020 at 03:58:33PM +0200, Don Goodman-Wilson wrote:
> > MASTER IS NOT INHERENTLY RELATED TO MASTER-SLAVE RELATIONS.
> 
> 1) There is a great deal of evidence that that claim is simply not true.
> https://twitter.com/tobie/status/1270290278029631489
> https://twitter.com/jpaulreed/status/1272064807345115137
> 
> 2) It's beside the point. Many problematic words and phrases have
> perfectly benign origins, but take on new meanings in new contexts.
> 
> I personally reject the kind of moral relativism that is being
> espoused here. In fact, I believe that there is such a thing as
> justice, and that we each have a responsibility to seek it out and
> create it in every corner of our activities, big and small. You can
> abdicate that responsibility, I can't force anyone to do otherwise nor
> would I want to. But history judges harshly those who would throw
> others aside. Of course there are more people in the world than just
> Americans. But there are also Americans, and in particular Black
> Americans. Precisely because git is the tool of choice for open source
As far as I know using the word 'black' when referring to people is
considered racist. Of course, it is completely benign word that might
have taken on new meanings in new contexts. Last time I heard the
'politically correct' term was Afro-American. Of course, that might have
also taken on new meanings in new contexts I am not aware of.

The kettle calling the pot black.

Of course, I have also seen patches to remove the occurences of 'black'
referring to the constant rgb(0,0,0). The word can be considered racist
in some circumstances so we have to remove all occurences in all
contexts, right?

Fortunately the ones I am aware of are not accepted.

Thanks

Michal
