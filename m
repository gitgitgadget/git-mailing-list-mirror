Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03571F461
	for <e@80x24.org>; Wed, 21 Aug 2019 16:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfHUQpg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 21 Aug 2019 12:45:36 -0400
Received: from elephants.elehost.com ([216.66.27.132]:32241 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHUQpg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 12:45:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7LGjRgS008877
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Aug 2019 12:45:28 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Cc:     "'Duy Nguyen'" <pclouds@gmail.com>
References: <20190820225613.GK365197@genre.crustytoothpaste.net>
In-Reply-To: <20190820225613.GK365197@genre.crustytoothpaste.net>
Subject: RE: Feedback on git switch and git restore
Date:   Wed, 21 Aug 2019 12:45:21 -0400
Message-ID: <020801d5583f$d5f89640$81e9c2c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJxGcAGrVB9JmdPw+FXPRNlOp7UmqXOS9Iw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 20, 2019 6:56 PM, brian m. carlson wrote:
> To: git@vger.kernel.org
> Cc: Duy Nguyen <pclouds@gmail.com>
> Subject: Feedback on git switch and git restore
> 
> I just wanted to let folks know that I've seen multiple positive comments on
> Twitter today (at least 3) about "git switch" and "git restore".  Folks seem to
> really like these new commands and are excited about the improved UI.

It's been a bit of a mixed bag from the NonStop community so far. Personally, as the platform maintainer, I am very happy with these.

Regards,
Randall


