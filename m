Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08ED1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755179AbcIFHMD (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:12:03 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:36157 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754870AbcIFHMD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:12:03 -0400
Received: by mail-yb0-f179.google.com with SMTP id 125so67339063ybe.3
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grabcad.com; s=gc130320;
        h=mime-version:from:date:message-id:subject:to;
        bh=N4FFeYF16MkzFSMSGqEiZi69M2Imkp9b1KpXz4EaGko=;
        b=eq5jIlUPaeK6e+sT/MDKXH9CGQhPzt8CMYvky/dqkIqGwucgDNMZt6RAqIRFlvZT5h
         X9KCqk7FMXc1WQoNDvrAtZNHZZ9efDMeLlHGHROTNEGyu18rAzUTyySluF8Ey5M3PKYS
         EpkSyJtOIFXHmLxT9ksnkEdZSa6GwN28DDRvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=N4FFeYF16MkzFSMSGqEiZi69M2Imkp9b1KpXz4EaGko=;
        b=KaALUJpPzO1ViIQH0yMe10IaK3fHLCoq+qyphufIBKevE/sPqswWykPs62v1SAr676
         6lde3pyNHMYmqJwh9J8bXM5W5Sv3kvCH8Jg1hG7qZvlNOKIZJaUnqmXZy1drmAz0SWEz
         pBjgD39p/uhT3+9AVYO3IT+rryvAcl8Rjxt82GnWlWs4BdUfGIvRsXqHlM8/NElr1j4W
         fOf+ledQXn7B2VvLKQhME1VrLhDUapHrqh3ybVkugeZP8xO6/89EonR9767EZlJVg3fG
         0EaSOnheSXtDkbH+/fPnnOvAnfUtff1SKKof3XCH6mUtr4nVZldkTIAl+0dXr2qMP5IC
         52RQ==
X-Gm-Message-State: AE9vXwPSxb9KhrGWn8jZBZ1aRzzSkpsS01RRcR96YahJJwzWlXLLuM9/tTmooUgRWffVbyGqFIODXYFtR6H11JDN
X-Received: by 10.36.200.86 with SMTP id w83mr26695190itf.74.1473145922098;
 Tue, 06 Sep 2016 00:12:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.37 with HTTP; Tue, 6 Sep 2016 00:12:01 -0700 (PDT)
From:   Idan Shimoni <idan@grabcad.com>
Date:   Tue, 6 Sep 2016 10:12:01 +0300
Message-ID: <CAFfNYUmMdamkW=Ca-iRDJ35ucr=S8A_qLTmjoD5j1M_ohdCgSg@mail.gmail.com>
Subject: Context Menu is missing
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The last install removed the old good context menu I used to work with.

Is that on purpose or is it a bug? is there any way to get it back?

-- 
-Best
Idan
