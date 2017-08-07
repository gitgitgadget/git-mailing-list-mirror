Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E46920899
	for <e@80x24.org>; Mon,  7 Aug 2017 09:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbdHGJUT (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 05:20:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:50632 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752367AbdHGJUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 05:20:18 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeLKt-1e0RFY2PfT-00Q9Y8; Mon, 07
 Aug 2017 11:20:15 +0200
Date:   Mon, 7 Aug 2017 11:20:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Konstantin Khomoutov <kostix@bswap.ru>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.0
In-Reply-To: <20170807082105.fwbv7d7hotsqeddx@tigra>
Message-ID: <alpine.DEB.2.21.1.1708071103220.4271@virtualbox>
References: <20170805230001.3232-1-johannes.schindelin@gmx.de> <978038E7-74E8-4F9F-A3B9-0BAD82C80FFE@gmail.com> <20170807082105.fwbv7d7hotsqeddx@tigra>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uZWA4tEO3TuJLpHHWoQP1FlwnV1njGheypDPPQxPlKPk/6huEL3
 CeKLmpPNVjaKiuXhsudZRVxZul5lHnBwYunBeUD5x4R7+alt0FiudRxN30CaTqoHAVncrdD
 FWKzbaftF3yzlz70EzoApv4iQq8OfkNRVvkt9OzAYtaoZR/xmZgjzcDRKin37eWfD7iYHjY
 WKbB9q5VxsKZCF7xVtepA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z4Ml8kmuv80=:zco4qR2K8A4yu5Wu9yiMFo
 ZGFwiC5C8g1f2QmNR7041oIQ4xTLGK9Ih19cOsUo6VxnHhH8Tzj3/WOu6qsDBubwxtngMOPO0
 +DLT9g9m7bc+TVXHB6j6qAaRfdgfbvbFQ+EKNDL179j09EXg5pyb6bM89vq1GO+hqQXJErnt0
 5dPd6KQLO4Yly0ZswSEBMPEAihRwSNMfmPNNjzPMAtnX7UhF4OSP3RqU3zWeG0W1ceGYRpkGy
 5ZUA3enhdLfRLFRasTVovHJv+g2hldlsoxSR6XNqMEzDQKaOfJbiQ0MrDM7hKxQyJq20kj6qu
 hHBInoET1E8u/4Q3m2jqwenqHI+L2EJY8S1jrWjnAimOoj26VgVZXOST3YVt9wTjSKsuUuAzT
 6Tygsrjer65zW3QpcgQIaR3b3jhto9jF6xpDjqpRhIWWLW6SbtozWkcw3DQQVRE+z5To6rnNv
 ga1xYPI7/DTVICqPfaNp8p8GllEJqUXoQfZzkUTwV+kZyuIXb8BBqEmZuYwXgX5mgOR8hqlLo
 ZRQz+em5WPcVrRqu19g6XwvKolmB91+RsGxPnMiOVQwFGhf0vbXIw+kTV/9lnbuFmuToKOqyD
 I1pISFkzDao+aoSlfe++OItchJm14tflwo9gTpdiLG2Of9iXj5lR4mx4BpvCji7N5hHhn+LCF
 UifFNTbjjFaIbu69rzhb00zDjKwqAgvrS2BXSMXW20yhbKqtwx9a9EkROk3p/zlBOELdtDxQ7
 9V0SNc4NmR/sSwZNwK8J6cW3Y8Pz7mkL79aZBnI+8PDtVlZUIUcnJRcoJqeSZLpDAA0eoQAKG
 pmBg3qbWpNWBqDlv8GntbFCHrKRtuDO35tqnH6khkCCfjoH98k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars & Konst,

On Mon, 7 Aug 2017, Konstantin Khomoutov wrote:

> On Sun, Aug 06, 2017 at 01:16:46PM +0200, Lars Schneider wrote:
> 
> [...]
> > >  * It is now possible to switch between Secure Channel and OpenSSL for
> > >    Git's HTTPS transport by setting the http.sslBackend config
> > >    variable to "openssl" or "schannel"; This is now also the method
> > >    used by the installer (rather than copying libcurl-4.dll files
> > >    around).
> > 
> > Does anyone have a pros/cons list for this option?

There is no exhaustive list of pros/cons as of time of writing. Off the
top of my head:

OpenSSL pros:
- well-tested
- been the only option for Git for Windows in almost a decade

OpenSSL cons:
- does not integrate with the Windows Certificate Store

Secure Channel pros:
- well-tested
- is an integral part of the Windows Operating System
- supports the Windows Certificate Store

Secure Channel cons:
- has not been used by many Git for Windows users yet (so may have some
  surprising issues?)
- does not support OpenSSL's way of adding custom certificates via
  ca-bundle.crt

The big deal with the Windows Certificate Store? It can be administered
enterprise-wide via regular Windows administration tools. That makes a
huge difference when working with an internal server that has a custom SSL
certificate.

Please note that I, personally, have used Git for Windows almost
exclusively via Secure Channel since late January this year. I have not
had *any* trouble. But then, I do not use servers with custom SSL
certificates at the moment.

> > AFAIK OpenSSL is still the default in the GfW installer and I wonder
> > why.

Only one reason: the law of least surprise. Some users went to certain
lengths when working with custom SSL certificates, building elaborate
upgrade scenarios that modify the ca-bundle.crt file (and of course none
of those efforts try to help any other user having the same problem).

> > My gut feeling would be to go with the SSL implementation shipped with
> > the OS. However, I don't have enough knowledge of either
> > implementation to make an assessment.

The reason I worked on cURL to allow choosing the SSL backend at runtime
rather than build time is so that you can test this easier.

Personally, I think that Secure Channel is the better option, for the same
reason you mentioned: it is integrated with Windows. So if you configure
proxies via regular Windows settings, Secure Channel will definitely
handle it as expected. If you trust individual custom certificates via
regular Windows mechanisms, Secure Channel will pick that up (IIUC).

Therefore I would expect Secure Channel to provide a far superior user
experience to OpenSSL.

As a consequence, my plan is to switch the default from OpenSSL to Secure
Channel when I feel that enough users have tested that backend and are as
satisfied with it as I am. This will of course *not* affect users who
upgrade, as the Git for Windows installer remembers previous settings and
reapplies them on upgrades.

> One fact which immediately comes to mind is that both frameworks use
> different sets of certificates (schannel uses the system's one, and
> OpenSSL uses what gets shipped with it).  Another fact is that they
> might have different sets or protocols implemented and/or enabled by
> default.  Hence switching schannel on for people who used OpenSSL might
> break things for them.

Indeed. OTOH Secure Channel should be a safe default.

Ciao,
Dscho
