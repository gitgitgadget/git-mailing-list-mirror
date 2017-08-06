Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C411F991
	for <e@80x24.org>; Sun,  6 Aug 2017 17:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdHFRyH (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 13:54:07 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:32778 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbdHFRyG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 13:54:06 -0400
Received: by mail-ua0-f176.google.com with SMTP id 80so23181944uas.0
        for <git@vger.kernel.org>; Sun, 06 Aug 2017 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvbaQQsiZI3knC6FxVEqp62LcZja9mKZ0/8+zYnG+NI=;
        b=N1GPyJkil5BmIMp5VusajZ+aEj4cV9wC9vhyVmA8FcFPvfrguyJ7/GnvS8H7/J9J+B
         V+IwyqzN4pKV+IWJ7gEuajJdIJLYtH0wIXJ4aUTe36/D7S/jmVM7ewjIFNKw/tIy9kXS
         VBC6KMR5Qjjjp/DLPQLbSbCmL+ot/WP5lXilS66G76h3KWuCm2GgdjYkR+7jHzwTzQWa
         oRrMplxHJU59WeZ470Dna4gh8nnxlHz0Yoyob9z9/pl15AJm7x03ko05TWgmXvzbGg5j
         Wlr3uNV+E33uRndoL5rDhPRXiinUvNmpnHR327iuWWLTNyL6foh/wUrvZoMBgR1il4no
         6xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FvbaQQsiZI3knC6FxVEqp62LcZja9mKZ0/8+zYnG+NI=;
        b=MOLahizMvENZ59udW1idHh8OZZTAkI758GfHEPLqbhWprqS8ETwSQPTiIDBnK1sKcn
         YUWPkor6whWe6AqutIqlc5rUBfviWlLrveImC4OkDNDx2EvfVgrAcfExbKudPrj6pZOC
         NjdZSJ4mNO/VzxF+vgfodwA37Kp03sLVQxp6K8Bmz4zRblNYQr6AeZJSYVt3Pz0R8Iib
         sAPI93AxS46J1REtOhyYkKC1LgQy4RlGa2VPSwbUSJSueof8uKXkRZBRe4KiJCRg8eRz
         ODYVNW4aSK0BlBaBNWZo5RHgI8744p4P/Gc1+59NujtT9v+ih5Z4YCGvdaR20QUsUaCo
         0CbA==
X-Gm-Message-State: AHYfb5gXfa0Esbl9xjid+z54oq8kiiO69Sywt+ugWjZqttd43s1YwVMb
        JNipnIKGMfNNiyLh2LUykw==
X-Received: by 10.159.32.97 with SMTP id 88mr328225uam.102.1502042046195;
        Sun, 06 Aug 2017 10:54:06 -0700 (PDT)
Received: from [192.168.1.6] ([201.240.21.117])
        by smtp.googlemail.com with ESMTPSA id u74sm1306520vkd.40.2017.08.06.10.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Aug 2017 10:54:04 -0700 (PDT)
Message-ID: <1502042042.3232.131.camel@gmail.com>
Subject: Re: Contact with Latinamerica
From:   Christopher =?ISO-8859-1?Q?D=EDaz?= 
        <christopher.diaz.riv@gmail.com>
Reply-To: christopher.diaz.riv@gmail.com
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Christian Couder <christian.couder@gmail.com>
Date:   Sun, 06 Aug 2017 12:54:02 -0500
In-Reply-To: <CAH5451kzm-gh-7MRYie8nt17+yZdFLgzyPF3ZAwmL74SrR0XvA@mail.gmail.com>
References: <1501423608.3232.30.camel@gmail.com>
         <6EF3784A5C1F420699D881AF642F28CD@PhilipOakley>
         <CAH5451kzm-gh-7MRYie8nt17+yZdFLgzyPF3ZAwmL74SrR0XvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all :) 

I just wanted to let you know how are we going :)

We can say now that we are international! New members are working with
us from Venezuela! 

By now we are on the 50% of our git translation project, we hope to
have it ready for the next release :)

This is our first draft of the website, it took me a while to finish
the legal stuff but hopefully in a couple of weeks we are going to have
 all done and our english version of the web for you to share it :)

https://codelabora.github.io/

Please feel free to add any comment or info that you want us to tell
here.

Thanks a lot for your participation in this project
Christopher Díaz Riveros
