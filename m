Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0AA0200B9
	for <e@80x24.org>; Tue, 22 May 2018 13:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEVNGp (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 09:06:45 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35975 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeEVNGo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 09:06:44 -0400
Received: by mail-oi0-f45.google.com with SMTP id v2-v6so16106240oif.3
        for <git@vger.kernel.org>; Tue, 22 May 2018 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Vmmp197xogir2XkN7+pIVwlHgsdq4VJoNCflstrWod0=;
        b=hVfHFOGFM/fBkOxqZdo2gM67Nao0TVzOPGP6wpd6ecQMEurKdnUu7kxUR9qGHtnQrq
         MvQXrDL6uloqhOgdP+Sy4V3p+4ktHiypSPsgfP14lR6SN22QPQgK8QpHo9ugIXjpB5Z4
         XPv+bZJCEWxSugoi2A+rZl6JSkOeojz2rohxspQXJOHjRX3EoSrh2o+8YWpcCX5hO6KC
         KppmcWOpWsfXo0/lZcVhywgMRywhWPJS9CA7gDNDLEUTo69xlHGkDN5WHhqopn8kPGeD
         JzaZOwSKsEB5F2XBqobT4MOCjlXPJgQkMLpIuTrI3BdotxZHGOpwlR+WiQc9raxuyP/a
         Ui4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Vmmp197xogir2XkN7+pIVwlHgsdq4VJoNCflstrWod0=;
        b=VWjdXgZUjGSo6n3fvYYoLG0/INA18QC2/zjbW0d4AjzPd23k3p5aEoURGWj1hYRvA8
         08coAeyVaacPS4+NzLUMNvTeGy+SiPEMOVzZvvmVgwx1yXb/nQ79g5nVXzQ/Y3wYAt/H
         /BYCZvdViTZlhh1EC8VQB26K/Bnetx8A/xkLmOwDLIhBIEmfd8/Jp5C0JWPiF/ZTSx23
         /Fcc0rD9lbwj+G/YzkhlMUvQ6mUZ9tigJcJhEee2eVX1rQYoRC2oluiJJmOMDttZa6zk
         CZ6JNizsFUmhAIss+d2mJsAcsn7t9SUrAFhNFbTcuKwWkgBjSO1NIxJHiy2EpeOt1+Si
         nkOA==
X-Gm-Message-State: ALKqPwcfn6SVWpMwF0EclEa62foMS9js+Bci0QU1M42p7KOVNPHGPV8y
        LRuZPf/i24cfyetBEkQLiEOs9GV8IpLW/wvJ5AnmMQ==
X-Google-Smtp-Source: AB8JxZpHnrq/IOHPpxnfZOfkSXgGgq3KAEZCG72enCadJYE12qIqcjQDPdw+mL0vRTjSWGU3HX+dqnFvq46sjJDnndU=
X-Received: by 2002:aca:4e43:: with SMTP id c64-v6mr13175966oib.343.1526994403949;
 Tue, 22 May 2018 06:06:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.120.203 with HTTP; Tue, 22 May 2018 06:06:43 -0700 (PDT)
Reply-To: dpowless517@pobox.com
From:   Dennis Powless <claven123@gmail.com>
Date:   Tue, 22 May 2018 09:06:43 -0400
Message-ID: <CAGC=61KqsBa1dUqQSSyow5Qksgtspw-4yovkmKohny9SDM5ZMA@mail.gmail.com>
Subject: user name
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it customary to use your real name or a user name when registering to GIT?

Dennis
