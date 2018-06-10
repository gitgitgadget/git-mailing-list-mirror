Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C413D1F403
	for <e@80x24.org>; Sun, 10 Jun 2018 00:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeFJAEo (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 20:04:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36851 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbeFJAEn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 20:04:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id u4-v6so25348912lff.3
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y4i7ADW3ThjudHMiZgWA3i9NdRkarpalNhhRgORY5jc=;
        b=BqMqULMyCmhnEk1o4B/esnR5MTzXwwpTmi+SevIWT3zEbebU793qnawnMPJPSth/HT
         ApqOuE2yqjwmM/cTfYzOaGBJ7EZGOqgsoJSTLvFKiiVYz4NZTtSk0+GbfkKm3mh8PhSJ
         Ai3jCZY01fvS80RkW/8TusgGkj4EhPZNAZuMnhWOyqi+5U5TJN5xEPddFo2ZbBLyBYj7
         mZZHl41HeaS6r1afQIdps3H2G2qtbLeFI3MjvZ0GfkqWK+/fHBjuzI7wgHKzBunq8/Vu
         U/H2/GAuy71iNlIaRxnryPOrnNUkNoM+USnFJP1/uVppPu4g+fc5xbxB/nsQOhPr5Nlm
         CHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y4i7ADW3ThjudHMiZgWA3i9NdRkarpalNhhRgORY5jc=;
        b=oMbQJ+2RhHCJoYPKX3hwpfg1NczZQPhf1Q6I3A4X2MLzDljBzENsThgiQCFsDJstDm
         G/ro9RDgruiV0Rqif+aFdoEAE9WGdDyPC1YyLj3rtg2jCzvyq6+qAInNa2k3sJ8xK+zt
         //3gPtishsNONt9TsK7DHSdJL4R66IbL9eLgP5nVTJckMhnSKXdan4gvjz1LU+nxtOmC
         hgGCmC57Tc0RBU7gQktHJJ50W5FuH6Jslxx5sUkQmKP08OY268dcQYTipCxHviYo8URn
         oHL2V9f6ObTVYQOse5ZNJlpNAXJ/X8BDeysdiDbmpz51bCR5UD+1vaL5Me+tQSP12cWO
         NIrg==
X-Gm-Message-State: APt69E1LdEl+1kuLlLsgwA9wO4zp9h/Zk5Bp7wksSYY9KsHY8Y07BuNC
        RBoLvf19SvzK/2zOd6NgwWia9W7+HnWULk4jTy+KauzTk54=
X-Google-Smtp-Source: ADUXVKLH5v1SeouPvxgx4Pa3EzzFZMJd7RQRjcoTcH13TCx68WPwbPPdJrMgKL97na0yAk9+prnNy3ueCfZ6exHvslg=
X-Received: by 2002:a19:ea1b:: with SMTP id i27-v6mr6933693lfh.98.1528589082326;
 Sat, 09 Jun 2018 17:04:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:4e56:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 17:04:41 -0700 (PDT)
From:   =?UTF-8?B?6Zm26Z2S5LqR?= <qingyunha@gmail.com>
Date:   Sun, 10 Jun 2018 08:04:41 +0800
Message-ID: <CANdbtkOj1jv2++2jSW-FGhPUu3eUyRxupqahKLNBeiDG46HtCw@mail.gmail.com>
Subject: can not send mail
To:     git@vger.kernel.org
Cc:     845767657@qq.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry to intrude, but I can't send a patch to the maillist using
qq.com and 163.com SMTP server.
