Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23B01F424
	for <e@80x24.org>; Sat, 20 Jan 2018 20:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756686AbeATUw6 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 20 Jan 2018 15:52:58 -0500
Received: from elephants.elehost.com ([216.66.27.132]:20494 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756642AbeATUw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 15:52:57 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0KKqolj038519
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 20 Jan 2018 15:52:50 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        <git@vger.kernel.org>
References: <20180119173406.13324-1-randall.s.becker@rogers.com> <20180119173406.13324-4-randall.s.becker@rogers.com> <1153e1c0-c7d5-3e0d-ce41-ffb1230164f7@web.de> <019601d391f4$dd367de0$97a379a0$@nexbridge.com> <9b7bf754-90bd-c25c-f5ae-124dcd97d281@web.de> <019901d39204$4ed19980$ec74cc80$@nexbridge.com> <877esci81l.fsf@evledraar.gmail.com>
In-Reply-To: <877esci81l.fsf@evledraar.gmail.com>
Subject: RE: [PATCH v2 2/6] Add tar extract install options override in installation processing.
Date:   Sat, 20 Jan 2018 15:52:47 -0500
Message-ID: <01ad01d39230$a41c9b20$ec55d160$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH5ceUaUBDLnBuBgyHh9+OiHAZcgwJI/tV9AkeXrP0DG2hYFwHm6YW2Ak67iZsBczKowaLG1jRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 20, 2018 3:34 PM, Ævar Arnfjörð Bjarmason
> On Sat, Jan 20 2018, Randall S. Becker jotted:
> 
> > I will reissue this particular patch shortly.
> 
> It makes sense to base that submission on the next branch instead of master.
> I have a patch queued up there which adds two new tar invocations.
> 
> Also re your commit message see the formatting guide in
> Documentation/SubmittingPatches, in particular: instead of:
> 
>  - Add a brief subject line
> 
>  - Just make the body be a normal paragraph instead of a bullet-point
>    list with one item.

Got it. I've been swapping between contribution styles so got a little confused. I'm going to reissue all of the patches required for the NonStop port later tonight or tomorrow, once the test suite run is finished. I'll take everyone's comments into account for that. Thanks for your (and everyone else's) guidance.

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



