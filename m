Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_40,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C961F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbcH3UXA convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 30 Aug 2016 16:23:00 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.17]:51162 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752168AbcH3UW7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Aug 2016 16:22:59 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Aug 2016 16:22:59 EDT
Received: from [216.82.251.34] by server-17.bemta-12.messagelabs.com id 61/EA-15568-D89E5C75; Tue, 30 Aug 2016 20:16:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRWlGSWpSXmKPExsVyYG+wh27vy6P
  hBqeeqFl0XelmcmD0+LxJLoAxijUzLym/IoE1Y/rEHtaCqcwVjyeVNDDeYOpi5OIQEtjAKNH7
  uJcZwlnOKLHoZBdjFyMnB5uAtsSCow2sXYwcHCIC+hJ9F0RBwswCuhKz575nBbGFBRQlvm5+w
  g5iiwgoSTw8spoNwjaSWPiwjwnEZhFQlWiZ/RYszisQKLH24COwekYBMYnvp9YwQcwUl7j1ZD
  6YLSEgILFkz3lmCFtU4uXjf6wQtpzE94+NzBD1ehI3pk5hg7C1JZYtfM0MMV9Q4uTMJywgthD
  QPU92LGCbwCg8C8mKWUjaZyFpn4WkfQEjyypGjeLUorLUIl1DS72kosz0jJLcxMwcXUNDI73c
  1OLixPTUnMSkYr3k/NxNjMDQr2dgYNzBOKXR6xCjJAeTkijvno6j4UJ8SfkplRmJxRnxRaU5q
  cWHGGU4OJQkeE+8AMoJFqWmp1akZeYAoxAmLcHBoyTCewEkzVtckJhbnJkOkTrFqMux4MfttU
  xCLHn5ealS4rwdIEUCIEUZpXlwI2AJ4RKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV5fkCk
  8mXklcJteAR3BBHREwZ3DIEeUJCKkpBoYi6/PfcuTdHv7l5+O6x9xHrzlP9GONfPP2TXdHnMj
  JD50Cej++/zNzjz86PJFJ5qeMf9qvbvbOnOHovifCmPDNe4/05MWVL7rZ1zlp/7D0di3wXFF3
  CThXo9ve16Inpt080P5zVWzPugzeHa5OTIbzblw2+/Fp7/6sql2oZPs5v6PnPxLM6VTXYmlOC
  PRUIu5qDgRAEmmUrYDAwAA
X-Env-Sender: Scott.Sobstad@jda.com
X-Msg-Ref: server-8.tower-145.messagelabs.com!1472588172!49208693!1
X-Originating-IP: [192.189.83.72]
X-StarScan-Received: 
X-StarScan-Version: 8.84; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14033 invoked from network); 30 Aug 2016 20:16:13 -0000
Received: from mx.jda.com (HELO mx.jda.com) (192.189.83.72)
  by server-8.tower-145.messagelabs.com with AES256-SHA encrypted SMTP; 30 Aug 2016 20:16:13 -0000
Received: from MD1PRDVHUB02.jda.corp.local (10.0.0.144) by
 MD1PRDVEDGE01.jda.com (172.28.8.92) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 30 Aug 2016 16:16:09 -0400
Received: from MD1PRDMBX01.jda.corp.local ([169.254.1.58]) by
 MD1PRDVHUB02.jda.corp.local ([10.0.0.144]) with mapi id 14.03.0235.001; Tue,
 30 Aug 2016 16:16:12 -0400
From:   Scott Sobstad <Scott.Sobstad@jda.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Patrick Richert <Patrick.Richert@jda.com>
Subject: FW: GIT Support Partners
Thread-Topic: GIT Support Partners
Thread-Index: AdIC+IOgKS6+ZnjpR62IJWPA/ScXxQAArvPA
Date:   Tue, 30 Aug 2016 20:16:11 +0000
Message-ID: <5D0CBD0453308E42BA5B2DB51CAE2C6CE5AE5C91@MD1PRDMBX01.jda.corp.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.4.31]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi- I'm wondering if anyone could suggest a GIT support partner(s)?  The community is great, but I'm looking for a more personalized GIT support experience.  

Thanks!

-Scott Sobstad

Scott Sobstad
Director-Application Support,TSG
JDA Software
20700 Swenson Dr,
Waukesha, WI 53186 / United States
1.262.317.2185 / office
1.480.308.3000 / worldwide
Scott.Sobstad@jda.com
visit us / jda.com 


