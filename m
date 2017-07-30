Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC6B20899
	for <e@80x24.org>; Sun, 30 Jul 2017 18:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbdG3SBj (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 14:01:39 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:21988 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbdG3SBi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 14:01:38 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id bsX3d3osAiSHabsX3dv641; Sun, 30 Jul 2017 19:01:37 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=5rxgeBVgAAAA:8 a=49B8Qy0mYDbi_iZE0doA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <6EF3784A5C1F420699D881AF642F28CD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     <christopher.diaz.riv@gmail.com>, <git@vger.kernel.org>
Cc:     "Jiang Xin" <worldhello.net@gmail.com>
References: <1501423608.3232.30.camel@gmail.com>
Subject: Re: Contact with Latinamerica
Date:   Sun, 30 Jul 2017 19:01:38 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170730-2, 30/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBhG2JVk1LglLnXdQLPvLS7nui5ioP+G4ljZghmwlt+xXqtzQHbJat26tLOeLuwjX5y2IdP2dc/tXG3nJwge69HgHAjgtx6gLhX6Kb1yPOaetQrPpcw2
 uwOXUP0NvMNcaySKkrH9j/KG4P0mZ/N5scqTt2iwii0jh3P2OIUeBRNd0HjtI9kXqwiA420356Z1LITwKXuNMbHXRktbWgdXu5UXVkCPCRXpGnxkhKBtNnqa
 8o/V/hR37EOWJFYUm5iTHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christopher Díaz" <christopher.diaz.riv@gmail.com>
>
> My name is Christopher Díaz Riveros, I'm a software development student
> in Lima, Peru. For some time now I have been supporting my Linux
> community, Gentoo Linux, and I have discovered a wide world of
> possibilities in open source.
>
> I tell you this because it has been so much benefit in my training as a
> a developer that I am determined to start a new community in my country
> to be able to make technology-related career students find an open
> source community in which they can learn to work and get the same
> positive effect that I have had on mine. I have already been talking to
> some teachers, I am about to begin my final year of studies in the
> institute, and they agree to start the community with students of the
> institution.
>
> As one of the main problems when getting involved with a community here
> is the barrier of english language, and few are able to have fluent
> conversations in that language, as it is a bit intimidating for most to
> approach an open source community. My community hopes to get in touch
> with different open source projects throughout the world and seeks to
> be a midpoint to interact with young developers and communities.
>
> Having said all this I have only to offer to your community, the
> availability of our community (we still do not have a definite name)
> and see if anyone is interested in supporting this group of developers
> here and with a bit of luck be able to turn it into a movement of all
> Latin America.
>
> Thanks and any kind of feedback is welcome :)
> Christopher Diaz Riveros

I can see two simple steps toward your goal that may help.

The first is to ensure that the open source tools do have localisation 
(l10n) of their command line messages, for which I'm sure Git's l10n team 
would be happy to have your communities support. - 
https://github.com/git-l10n and 
https://public-inbox.org/git/CANYiYbEJ3Gw=JvbhLBeFWBD7xLXxd=_fFdH3UX76H97ZU_3zKA@mail.gmail.com/#r

The other idea is to consider how Git's version message, or something 
similar, should report the users current i18n settings, and any links to the 
right (e.g. local) support groups. At present, I don't see any obvious 
command to help users (and those on the help forums and lists) know what 
i18n nationality / language names to use for discussions. Sometimes it is 
worth ensuring these baby steps are in place.

--
Philip


