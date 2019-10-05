Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,PDS_TONAME_EQ_TOLOCAL_VSHORT,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F67F1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 16:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfJEQPF (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 12:15:05 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40887 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfJEQPE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 12:15:04 -0400
Received: by mail-ot1-f41.google.com with SMTP id y39so7752709ota.7
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=63GxLIr7b7xWgajpbjwXyJQcCiCJqYgb6Nyrf+1LhcA=;
        b=pA9iBT2T12IcfXORfuBOnUtEcdi+guKV0hJy3Cg9SjrCta+i1cg7dKNOMQ8ndqhjlS
         B0ne8hQAiu0VHLGvCRj+ZAN+6EO3ysukc4fzyXe6D+T0seQM10g8GP6gI4ykFHCxjO+V
         GxaabXEW8aqMiBuyUuXkdURa+MLN6eZUxNiGDdfpE7YHmOf3dcqyZwgsIdrz9LDYlE0E
         EnP6/WNr4HDQLvtROsaQZNQuUlWvApjPhN1/89VsdL4JB7+5nQJmUm/cyb8WhMpjdiZc
         ghQWe6iOqxdzKezI4nPWn+znqvaUqxZT3DaEp4bz19+7erWWYqD0J4Q75nVjr7Uduq3I
         PIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=63GxLIr7b7xWgajpbjwXyJQcCiCJqYgb6Nyrf+1LhcA=;
        b=GP2NC64lPhY5FuGJyOc+qxf3IUyiEt9/NF7k0dmSh5h4Jc6lSZfR8Cv6ArO3wKD67B
         p1/fN6guSQ6XpswxxcXf42RmWecdwd+9yaLKxrGzlGxhd1KFO1D+NQKsXG14yBfw23fJ
         eDSL46b3qFT1ZBPJf+d6FXAl0jQj0r1jerEt3PcyObZo8llYeyEXC+W27DcWJbCZhLYL
         q6zMc+zFya+Q0YCpNHY5sbC8UqnwvYQRV2HETce33bCvQXy29qiq3t7bZ18O6aJpcPLE
         sOBadu9utuIu+bw8YbMNJN566bHgFARvlKU7ACazQ0t2FqvkcA+mBgVZK0aLA8easfpn
         w5bQ==
X-Gm-Message-State: APjAAAXPSeYuMehlnhXjTBbMHwMnW5QUW77q+b+GBG/+fUAPWK0gA1XC
        sNjz98pz5aQcF+UUS3t5NAK66uqyA81sLFKHBo1kZsyTrKY=
X-Google-Smtp-Source: APXvYqz0604N15KYHJKI13f9pZc8Urpdz+axn1qvmE0rrBHok71pslZ/uRqhtSM1nRMUMGiFNbkK6z7jii6VUk0tcBM=
X-Received: by 2002:a05:6830:1b70:: with SMTP id d16mr15603590ote.152.1570292103878;
 Sat, 05 Oct 2019 09:15:03 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Litvinov <litvinov2004@gmail.com>
Date:   Sat, 5 Oct 2019 19:14:53 +0300
Message-ID: <CAMKJxoTfZ5nDM3stKuaydo8A9N-VcUMegh7Bs=zP6+_fM8_xDQ@mail.gmail.com>
Subject: unsibscribe git
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsibscribe git
