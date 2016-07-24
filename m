Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4F3203E3
	for <e@80x24.org>; Sun, 24 Jul 2016 20:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbcGXUD6 (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 16:03:58 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35747 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcGXUD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 16:03:58 -0400
Received: by mail-pa0-f65.google.com with SMTP id cf3so10130043pad.2
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 13:03:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OxTQlJmX3IqziiUcGecF9MuSKQf6EJMtKBgqIol+K6I=;
        b=uP1WON+1PPhgf/qJiTX78Lu2J9IiTsJncA5FoXvozDHJFMN3gGEg/SQ2rcl94+U5Q+
         llWhODoed5IKFfgtihRWN1YdDmyII93oWvuWMNqyG82NG/U4BZZuL1fE4T8HZydmgz2K
         EduheK4Q1OB+iWC+Muh3Sm3nSCEnROs60Tn2QINqYBysFTKsMNcBFWn+OgNwHmKOnC1F
         DQ+GbAlKpb51wv9wIOx2prybglNf3cSDvXYddQe2rqbnVVfVue3AuLPhFrbzNpz9uVhE
         BMc0EOCDj+MUUyln6W5JTQm8odh7WlGpaCdyFdAs0XVQU13M0b5Pc6sbCyqNPTM+B4ae
         aDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OxTQlJmX3IqziiUcGecF9MuSKQf6EJMtKBgqIol+K6I=;
        b=AzawCYe6Ji2QWpSk6U/HAgnoZFqpr9qpkAo3/3sw9m3TgyYlYxzL9jtHWfb2+cLlOi
         t934uVd78AYzt6JKtwv2EGrmKVcePTzp4zCLqPDrO+Ntc0FRDTMdL93MYts3kcwxyz4h
         363+/GH6sArTxd47a9d5sMrPWccjNAfxlXal9R5fcHzP6mmZp0GaagJBrlGFXQhQACkI
         BcNVeqxTHMqcnmKh24CDn4YEvxqVK5e/N/6aoBLC8pNFbDh9RLRI9qnxfsd8ENCVtAyg
         KLqF2CiEWC3x2XnRYYmoKT1mz1qnGcUyqxKhmHOXLYUgvR/Qcar5VIDACrRAQ+Zlq1av
         1Prw==
X-Gm-Message-State: AEkoouuMK30p6PLtQXq202sceE9ov86pBZd+DmcnTVcsZw3Dl0hnxak+kO5iN+J7IiZzIQ==
X-Received: by 10.66.220.73 with SMTP id pu9mr23520256pac.77.1469390637301;
        Sun, 24 Jul 2016 13:03:57 -0700 (PDT)
Received: from [192.168.0.109] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id d5sm34433317pfc.4.2016.07.24.13.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 13:03:56 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <nn1euf$h6q$1@ger.gmane.org> <579483B7.4090508@gmail.com>
 <6f7eea6b-2446-5740-cbec-141d71a33ea1@gmail.com>
 <CANQwDwcy_AXTmG02ynNanNvoNVnK+t3uxf5r1J5tHn1hxaZ9kg@mail.gmail.com>
 <d7918e4a-c4c7-c85f-1aba-3cb9a59e6eba@gmail.com> <5795087C.4010503@gmail.com>
Cc:	git <git@vger.kernel.org>
From:	Jon Forrest <nobozo@gmail.com>
Message-ID: <49f49b92-bc40-e975-10e9-fccc8a3ae25c@gmail.com>
Date:	Sun, 24 Jul 2016 13:03:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <5795087C.4010503@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

>> Also, I realized one potentially major disadvantage of sharing in
>> Google Drive. This is that the URL will change each time I update
>> the book. Apparently Google is taking away the ability to create
>> a static link at the end of August 2016.
>
> I think you can share a folder instead, and this would be stable.
> Alternatively, when updating the book you could update the link
> in the GitHub repository description and/or the README for the
> fork.

By the way, I might have just figured out a good way of handling
static links with Google Drive.

Apparently, when I created the pdf version of Pro Git Reedited
2nd Edition (which I did on a Dropbox folder) I didn't wait
long enough for the creation process to complete (I think
that was the problem but I'm not 100% sure). Anyway, as
a result, the pdf version didn't have any images in it.

After fooling around for a while, I was able to create a
pdf that did contain the images but I was worried that uploading
it to Google Drive would change the URL, as we had discussed.

However, the "Manage Versions ..." option on Google Drive let
me upload a new version of the file *without* changing the
share URL! Assuming I wasn't hallucinating, this will be a
great way to update both the pdf and the HTML versions as
they change in the future.

Jon

