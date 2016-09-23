Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36AF81F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 01:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933345AbcIWBBg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 21:01:36 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34076 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758613AbcIWBBf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 21:01:35 -0400
Received: by mail-qk0-f171.google.com with SMTP id n185so93110137qke.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metecs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=dobhZljk5zz74wYDQxtuV2QvdG+JJ6B3Sh83BQteXrI=;
        b=ZOxv2Pw0G75lKq894ZIlr/qJskFitNAUYaqCEOH0AA5JctJJGa7FUgdC5aip8cOeBv
         1eMsoNyFtzzB6mY4jQrhoPpexn+FoSZHVMLmmimTJyT6pX4tp/a99Oejnm/My/aQ2xtj
         Romx+bO7xG2Ypy09IWwZ3nu2Pi7bubI2io9eMdgyjM322my9nZPQNhlbZbgRkWOM2ueZ
         t3QVYHIdJf4OHTLAow+tai5XsXmYInJUrwouLEzJnOzWBhv4pfVqRMa7m1SJ2AHveS2+
         v9dZXfZbkpF8YWW8kP2CRWOcVDIt67MWILkxoQGJYVV+bOwt2BXrAsAYAksQdqny25iH
         tvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dobhZljk5zz74wYDQxtuV2QvdG+JJ6B3Sh83BQteXrI=;
        b=VUXF5fwbvcUruJe741Z8DKgRKiS+tE6cI6PpD7owsY3DClnS10HeK0STcnXMkIkMHS
         vCNp5TW8BNcJE/mK9NLaK3HMRNfqFBxdd2zdDz47623hiYdTRE442YrngIgHxDgq8jIJ
         TAO5DP6X+xSayo5KPxqwdTXuBLUQZFby6t3PHf+z1FmF3cl0Zr7GB1TiuACodNTVUASn
         nqQ+N0PwRoNOqmm3SmgknlzqVxmg7blwRObISud1wz79EGPEqMSoCVLm7dW9e98sXSQV
         4wEPVHlslBMKfk+4d2QcIxtRuzMuhcf2xAUznFeLgg6/EekxI4YmuLFXiNnsWjOIcBkb
         PscQ==
X-Gm-Message-State: AA6/9RlRCyooYPQWEhOUbnTo0sYnKAHkboC+fCE01obkTjxWg7/Ei6NngKV7/zSwR1iIzZ9BDEQlUoKCNFNuvtNy
X-Received: by 10.55.158.208 with SMTP id h199mr4816328qke.111.1474592494132;
 Thu, 22 Sep 2016 18:01:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.148.50 with HTTP; Thu, 22 Sep 2016 18:01:13 -0700 (PDT)
From:   Frank Graffagnino <frank.graffagnino@metecs.com>
Date:   Thu, 22 Sep 2016 20:01:13 -0500
Message-ID: <CAMpxh=LQP870mvZm=VWz13H4g42sE2PDXy2jPoe+mOLwGMv3bg@mail.gmail.com>
Subject: our company's open source award for Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure if this is the appropriate mailing list or not.  If not, I apologize.

Our company (METECS) decided this year to try and give back to the
open source communities that help us do our work.  We had a vote for
our 2016 METECS Open Source Award and Git came in 2nd place!  So we
will be making a donation to Git at the SFC for $300 soon.  We hope
that you all put it to good use.

Other winners this year were Blender and the Free Software Foundation.

Thanks to all of the people who put in work to make Git such a great
tool.  We appreciate you.

Frank Graffagnino
METECS
