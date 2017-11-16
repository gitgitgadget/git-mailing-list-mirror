Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD807202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 16:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934159AbdKPQPL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 11:15:11 -0500
Received: from mout.web.de ([212.227.15.4]:55681 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdKPQPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 11:15:09 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0yjP-1f34Bo10ed-00v9Nx; Thu, 16
 Nov 2017 17:15:07 +0100
Date:   Thu, 16 Nov 2017 17:15:06 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ashish Negi <ashishnegi33@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Changing encoding of a file : What should happen to CRLF in file
 ?
Message-ID: <20171116161506.GA20809@tor.lan>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de>
 <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
 <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
 <f9dc6482-587d-50a9-d649-aed63be18fad@web.de>
 <CAJ_+vJ6SxLOmZfG79Sa-vskBR-XG=C97--PB-vpijjUKym=jYw@mail.gmail.com>
 <20171115171258.GA12963@tor.lan>
 <CAJ_+vJ7am7dU9B0qTYVtxpkHoZdV45ciZN5ifbv9W8xRO2o=EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ_+vJ7am7dU9B0qTYVtxpkHoZdV45ciZN5ifbv9W8xRO2o=EQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:92sTwQ/kULWTQGd0cLPr2IM2Xw6QDAoXpMEyQIf6PeRj7t4TMOG
 uVYLAmiYGuYInTR1hUyTTMDtgSI91mNj6zohoOHFqW8TCYc0Fg8R0WIcym9xMLyN/nyMpOf
 JAMuO1/IngxDA3oVdwVM3wN4u0UtiCL02c9C51NaYMMso+3Z+5kl8R6tneLoEUomqJ0i5sS
 yse5cMjAft9J/kxVRpoVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kWygc47vTCQ=:AiAUMZlYj/GD9nJY5MB4nR
 z8cXfui0JJqLQFS4MSn3O/Ibtpah/4/baVZ/KXuuwZKT47Ux3SNHVwbGh4KpJyhz9aYlw3iDA
 daC1qsyNrWbgvpNdOBUQd02XOqVWvE+m2IQHznNcl3oYXF188OevCFMdjb8KULhcxmfZAEjrS
 +s0VfFNIod1UtClnIk9dEKrxA889Iunm9O/3l8KsD5gNaxIEyVa0D3aT7m2wHHpDVBbeHJf2L
 Us0HofTTCyuQ9OupiddE5hcvp4tsLwJux/Vpm5heQYRYIgAZUYY2L8Npnl3Y0vapcL064WmRW
 MN3DSOqFob6q8mdOPGuwuL/2arEalKc/a2Brp/2VykAjEP+NiBKeoQKTv6mzXWZUQTIKm2fop
 na77QXCV475TeaSfhVTPhU0EJCYNRkZXWIXstdD/RdbrPwJQldK2gTFoBU5rpa3M6AnUUga50
 LMtIOsGs1O4ijBVvV+Dye/RUBQ4z1Q62p7MeS3ich2lIWpEMi5suLfkGDNvZkLCfIj79HjbXV
 646HUEZBteTbPnTvUHSP8mWdFNstAe+u+59Je7qo7U7V8LpfeETX3WY6U+NGzZ7tDRloTw7C/
 M2KppH+Ii+p6As1l6V3akfQUqXiuoRrxnjTatz1F4bAmvOIolRKYZT5Ym6Ii9Ew3vMIhlvrV5
 b1jT+LZhtQl9zJ0Vs5Su+zFiZ/sOK8NE+kcB8ysfeV6CEwWpe7/nfTBAbwtB/3dC0YepibC13
 7Eb8I+eAInZLnVcRbIKOkPuISYvM1fOZZYKdHv4zVXegHsmYjSAKRFFUu+wad+t7lEs5gSlMs
 fHnwwJvY6ABUU0P9cfGQOYp7mDQVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 16, 2017 at 12:35:33AM +0530, Ashish Negi wrote:
> On windows :
> > git --version
> git version 2.14.2.windows.2
> 
> On linux :
> > git --version
> git version 2.7.4
> 
> I would like to understand the solution :
> If i understood it correctly : it removes file_name.txt from index, so
> git forgets about it.
> we then add the file again after changing encoding. This time, git
> takes it as utf-8 file and converts crlf to lf when storing it
> internally.
> Right ?

Yes, exactly.
(In a coming release of Git there will be a "git add --renormalize <pathspec>" )

> 
> Thank you for the support.
> 

Thanks for a clean bug report.
Actually it is a bug, I put it on my to do list


