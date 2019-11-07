Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7637C1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 21:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfKGVyO (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 16:54:14 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:33984 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGVyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 16:54:14 -0500
Received: by mail-ed1-f52.google.com with SMTP id b72so3331134edf.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 13:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ePl8EE9sPuq9Aih0vfmCrtk4lXuHQXIfg8Gm9MRUhnU=;
        b=GUrs7dFTswn4WQj9pHm39cbiaEl10bMFLAv7r9P1nwAsZi0W58ZuTOmDJHMzXQ3I/U
         V0BssEuUxxM5USdTkWo4kUAVU04uXhAgmVBwCmxxRmEoNChNHqBOjzanLgxCCiTVoW2B
         q13jHFFk6zXosbVu3YPo3zQplpXnTomLTTkkjbL69nzM+hyvJT2eygVGFnnNJ0rUE1h4
         mf2ZaDrrMm706J3j7B7WUGR03zIYoJh2xK2JPj8be5KD7e7LLDq1Pr+U7hVAGq7T9tzd
         poe1DM2nN1NPAxHh6CwaTDRNTsAECzkG95qQkbF9q64RpDZR8g4pltLqqWirKpCd14/Y
         hr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ePl8EE9sPuq9Aih0vfmCrtk4lXuHQXIfg8Gm9MRUhnU=;
        b=EGstdjBEmlnECjSKQ8aIHUXhx+cmSkxQWnkf2Y9XDdieB2g1pzJY1/h2Osy0t+h++M
         Fws+eQv01MpCeHZib8MSyQWc2wg3grijgqVKP7zDVVX4U9riohzc+LWQvIP7wbeirMp+
         Lp33QcKjRNbCubfdy4rge25qYSdUs1etMGvMUvSBmxoKrCL0osOuzgdk4fz1W9OB214Q
         N3JC2u6sJPOfMF92tCsPDeZxuFvJeT4YVNRepaBE6y4N9uqmTY4HKkt+50vuPXmPBM4U
         C4HWw+fxX4mmWH4hf1oiYzQRKhYtSMtU0TQuiXZm+cax6Y5fDYYMfkeYR5bimgP0VHpR
         H5Lg==
X-Gm-Message-State: APjAAAXk4WE/YKZqleM1Gu4PUrpr384BdFOD7/ZAJJr9RvFiqgp1ay4I
        4jtCIyJOBUHtnSnpnclbjMStGBoZA/3IqRyChhMuJCYbx28=
X-Google-Smtp-Source: APXvYqzLt+x6OlyXKeuLnsIuYEaTDaSavNHkVYowGxRWa1211aPY/tftopizJ0vgc37NGB+g2mlcTlV3RBDXsE+h7WM=
X-Received: by 2002:aa7:de92:: with SMTP id j18mr6410046edv.119.1573163652304;
 Thu, 07 Nov 2019 13:54:12 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Nov 2019 22:54:00 +0100
Message-ID: <CAP8UFD0WXrG=XbZj9fyo1v0zy8p7yNnGZGVH8bHDqPOLThGD-w@mail.gmail.com>
Subject: Git Merge 2020
To:     git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

It looks like from https://git-merge.com/ that the next Git Merge
conference will be in Los Angeles on March 4 2020.

It seems that the conference will only last one day instead of 2, as
it looks like workshops are going to happen in the morning instead of
on their own day.

Best,
Christian.
