Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C65F20248
	for <e@80x24.org>; Sat, 23 Feb 2019 12:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbfBWMyC (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 07:54:02 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:46500 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbfBWMyC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 07:54:02 -0500
Received: from DESKTOP-E4U7JCE ([5.169.49.65])
        by smtp-32.iol.local with ESMTPA
        id xWoZgX6iq6rc5xWoZgM1C2; Sat, 23 Feb 2019 13:53:59 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1550926439; bh=cRITRjDm32auWpFHMRUNBdCaz0J83yg3I/Amw3BeReA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=F54FxNvqODMvHRqWub0yX55974QbEiwHVH2kdv+9Se+DK6YT8BrPhrvCLuX+BS0IT
         WOH+Pk3lNsb6ardevfM1vs1MgU9jQl4Kv18xK1ldBUtBdYV6/xRfl/lTFU6yhC5vGn
         Ouy6+SMCPE0vxp0QZnalM6pyPXc7/fpEGfHwwNZSB8NCCiMsumfhHS8J00uMQXANmZ
         JFGPbqHt14mFWc1P20DWokU7/1JqQC3yHGQBGchkh+OFTkARBg8fpiVV5/kR8yws4F
         0xvLcGaIPafKIIAPaVhhrxtG2a73imn/pn1waTYKqRVaw8qJD5TZGevS+jrka+9FGe
         7sRIlGpFXXOYg==
X-CNFS-Analysis: v=2.3 cv=d7kkNirE c=1 sm=1 tr=0
 a=zYX2uk1tt1KodCNUFRWNOA==:117 a=zYX2uk1tt1KodCNUFRWNOA==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=EWrBankqWWQk1Bu4D-0A:9 a=QEXdDO2ut3YA:10
 a=u09W0hvIdLUA:10 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <1550926438.2346.6.camel@libero.it>
Subject: Re: Looking for my fisrt task
From:   Fabio Aiuto <polinice83@libero.it>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Date:   Sat, 23 Feb 2019 13:53:58 +0100
In-Reply-To: <87y3664tj9.fsf@evledraar.gmail.com>
References: <1550915602.2346.4.camel@libero.it>
         <87y3664tj9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNdlt1L6r1pVw/9Nnu1Ke6Gq6fT5Mw8nD/XakLOukQGVahaMASdGIQ5UuAeAloMq5w3jJDTun03Vzm8wHcUISGd4e5xxNMA9QoNm3G0waDzbUIJfPBjc
 +ABfI/o94YtuCO4fR6GL3rbe/BeAowhkapqoIfd+uqDytpS8V+eUSsQFQ60xaCP9HcrB/QBKPAUqmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maybe I need more things to know. First of all, if there is a
maintainer I could keep in touch with to have some fix to work.

Il giorno sab, 23/02/2019 alle 12.46 +0100, Ævar Arnfjörð Bjarmason ha
scritto:
> On Sat, Feb 23 2019, Fabio Aiuto wrote:
> 
> > Hello,
> > 
> > I'm looking for my first task as a participant, something simple to
> > get
> > used to submitting patches and all other facilities needed for
> > community development.
> > Thank you in advance.
> 
> This recent thread has a bunch of good pointers:
> https://public-inbox.org/git/86fttvcehs.fsf@matthieu-moy.fr/
