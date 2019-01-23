Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_EMPTY_SUBJ,PYZOR_CHECK,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897431F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfAWOSo (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:18:44 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43814 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfAWOSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:18:44 -0500
Received: by mail-qt1-f176.google.com with SMTP id i7so2444138qtj.10
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightingnewyork-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=n6Bo9W89Vp4akp2mhDnV+WedKB7IG81qw+/thqT7vGY7Y2ZJFWYHPAUK7rCj0Nt9oR
         zllOan8e1VQ7hw1xXdq6RYvlSIuVSB8O0Q+yma4hQU7L7R4ywkwcU2rv5opYH9I2L2nF
         aWbha6RryDbWYRB6zqRUWmwdyDFJs8NEt8T3+NVwLT7AAF+HBojQjPT/bvDRXIUAHxGA
         /Lu5CYATIOMgI67P8MT4D8DTEsKTzPDL34rSVtdBu94SaMd3pUTCaUymW3NDOTSdZ+P5
         r0LX4neTXUSzcTy3seiAgpRi6CHCputHPyz1iRlkDoA407LhrpbMuw3zeba10vSnqSmq
         ZqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=c+ZS6mUSRvjXgM8Kk4ULh4tittEgzPK9weN26/E7m2QNunX4cPu2kk+yyCM1GHHMZ4
         zOESmcDQZa2jFU1ir3uMDovFZ54fLVPfDoShlIVK0qp7GIPnfEQCABwMcl+9Rh4x4LbF
         0z4CNdWtguo27Yg3Ec8TJSKNbJ8ha0rBEGswimW6EpEHkPvqmVVYNW8Dn71kc53PD9ah
         TzFKoC8vojqbKea00TlKKlAe++N/VZLmTRocw2Q3XGOz5axhs4b/iNXFnDS8klh+j+z1
         BCVOLYgAlzsRf6d5L/z7iKrgVGVuBE/ThCnDm8lKr/LJwO/lUUZSFGHfCKZPvqGdXRzr
         LkaQ==
X-Gm-Message-State: AJcUukeMz5XRdxQgZuFynXy1F8WUJaOl520v2FGfn3Vsxfui9a0aCF/w
        8sIf3RfO5FsC+XMoYj1KqV09jQa+z8woEr1glpcqW3eOjVQ=
X-Google-Smtp-Source: ALg8bN7QnFvmF1kCCRjoQenUH+xwk55+VvUYBswnbwQfGKWEwdWX1HSK+K7LEmor34b5bziH1s+vKZCg6Af3tuVFfvI=
X-Received: by 2002:aed:2c65:: with SMTP id f92mr2399806qtd.47.1548253122873;
 Wed, 23 Jan 2019 06:18:42 -0800 (PST)
MIME-Version: 1.0
From:   Cody Kratzer <cody@lightingnewyork.com>
Date:   Wed, 23 Jan 2019 09:18:32 -0500
Message-ID: <CAJLF3qhuOKnPob-y20VmkGc5uBk6pLBhMYjyCjrjd8ONH+05QQ@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe git
