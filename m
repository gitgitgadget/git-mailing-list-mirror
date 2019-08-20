Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8D81F461
	for <e@80x24.org>; Tue, 20 Aug 2019 17:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHTRXe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 13:23:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36839 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTRXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 13:23:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so6941312qtc.3
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=;
        b=k/QjWprzIWfeNsccO+sPBntPvxkA0HXS053vUnXE46eX3wIkmKUJ4/+IM/z7GoWsJC
         kwm3invtg4p2nQWuQgFAuSvBcnRu1lXpqQRKETb/pyAgC9Yj6Xh4c7ftS7hPjP5ykLyY
         M8wZCmRwrorUDoQicugPdqyxsM/B5o00+L4S3ciw0BccUOLHjWe4lje/Ln16avdDuzD5
         TVJEM4KshiqBh71oEgrcRw26Wnrd82f/AlLTFBbcvwULgTMFHYjDv2iCvkpixTh+cToW
         JXV5see3G1atczyOzSoL0IlmK6qGUiO2eRNsYwgwoeCy3cgVVfyf6c/RopAH1yyOiHKO
         pQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=;
        b=rx+jBeUU9sffEi02WPLXZxZRJet1dM3AMKHvGkNcncc7lLNURbomGfXcVbUz1Dn5eX
         Ysq230j1/823xfZmJz0ghNXiie2MqR1VTLLCXQjhAeelvf0lcK4VOLUFieaHWjEzqh2G
         xkUyQg32Od6CZ7Y22zThCFR1J2symzpe5MB/TyoVTe0zMwcdPkvaewWkbSwjWxja1dhP
         NDtp0b6uSxMgD0cTuexKV6ZEev9ePoJNXBSlYoH8n6o6DcxdCtsMr6aVxvryZ4ic4Wsd
         oZY+VRzVOUqHx/8i2/JnM7URIKb09h9Bs1nkyK3EiaivyerzHjd4whUpLF/MrZWNnap3
         moqg==
X-Gm-Message-State: APjAAAWR3VLU2LpaYh9MFLW+s6xR2okspRa007bQODg/9q9Rejoejxcv
        m/OGYqzvNdBUAamaBQNlxZd1Rp20WuVt5GKMg5RMLlz8RqY=
X-Google-Smtp-Source: APXvYqz6i+P2319tr61LWlrBXEQEczyDWhgpqEAOrdPNO1lArwxQcWNjVm5IRSzEOobv9B8KEMwrUAltwE7+t5qB6Js=
X-Received: by 2002:ac8:45c9:: with SMTP id e9mr27837083qto.133.1566321813200;
 Tue, 20 Aug 2019 10:23:33 -0700 (PDT)
MIME-Version: 1.0
From:   William Baker <williambaker54545@gmail.com>
Date:   Tue, 20 Aug 2019 10:23:22 -0700
Message-ID: <CAOoiaAP_dOjrqSA--DcWxE+6nb4FY1GCn3+QKZnC67LHo+xn8w@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

subscribe git
