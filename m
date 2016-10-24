Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B0E2035F
	for <e@80x24.org>; Mon, 24 Oct 2016 18:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938663AbcJXSXi (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:23:38 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:40793 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754461AbcJXSXg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:23:36 -0400
Received: by mail-qk0-f175.google.com with SMTP id i68so5394804qke.7
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=05t/EOITtkA8B0SUZpMakasHIQGanKdkVZjOsaKFzgk=;
        b=irkUQMrIVhorabspdvrsxX4RVt7Nt3wDuVn+4+UEmGg5Pe/slRTDfoU0DxA+DY8ma+
         /OZOuWH91Oi1YJcl6DXRxd8bv2vqPYv1CmOSsLtT7T4yTYPLPAn+eHVr948xLzx+o4O8
         1GqwZXI6yeML/G/EaBoapATSo1IEl52VaqRfAJrRGYx7yu5LOK0yWvrjT/5VYKpXktkZ
         OJA1imGwzkAUgjW7HPUIAXtD+KfijT5oEJyTIMh/1xHAvm0S/e3r/euvpz2Z1PL+zMiv
         EdPxcoZJCtkwptqcBNOT8tFVkk7P0nbORd0S90AWvMntK1k0crpcHL2hN77V4+kWjMXe
         5MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=05t/EOITtkA8B0SUZpMakasHIQGanKdkVZjOsaKFzgk=;
        b=ILEYwbvAtaqDo5STVeX9lS6txDfbdQMQepwamlGVPwDSJVmKc2GcbzyFx3AN/qzYbU
         bUene3x1EscqkCKEWzcE8/8jg4t5OXIVEx+FMBkn2obZG1xF1EnIv2lMNgzt+ZQQxabu
         LjO7dtvWTeeOahk812thSDr1rYg9/2XTt/fyEHAv+itvf+IqRFQoGA/1+fndRiZE9F1n
         hf9LJUjdotB2MiBv3eZKHrh2V+Fd9AZKJrQc0HPoxrjRpQaZNMkJCdGF2XeZ0k+W3dBu
         M//lyZ0pqb/qlW6rgLvrui930/KEUlvkvE8Ky64uyQI7S8kFjS6z1bg59FMH1nq9ZiVr
         bpdQ==
X-Gm-Message-State: ABUngvfEcXJcBnusnPem2TlvFh8FnO3ELQPwqSymvhJ5xgQQSm3CiUTG1DT9ok7b3kI5Y0aCgMFPU/DToBNVftYe
X-Received: by 10.55.129.1 with SMTP id c1mr15188954qkd.53.1477333415624; Mon,
 24 Oct 2016 11:23:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 24 Oct 2016 11:23:35 -0700 (PDT)
In-Reply-To: <CAN8fUZe4iWJCZYqBBDbNyPq1Dz7f4xvTNRVEZgg5AYN2NrKCbg@mail.gmail.com>
References: <CAN8fUZe4iWJCZYqBBDbNyPq1Dz7f4xvTNRVEZgg5AYN2NrKCbg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Oct 2016 11:23:35 -0700
Message-ID: <CAGZ79ka+_CUxQjB2R-EEk2nKmc_rbj_m7884fLvU9+NgJ5gUug@mail.gmail.com>
Subject: Re: Reporting Bug in Git Version Control System
To:     Yash Jain <yashjain.lnm@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a Github issue, so ask Github support.

Or read up on .mailmap files.

On Mon, Oct 24, 2016 at 7:28 AM, Yash Jain <yashjain.lnm@gmail.com> wrote:
> Hello,
> I have two accounts on github("yj291197" and "yaki29").
> Both the accounts have different gmail IDs("yj291197@gmail.com" and
> "yashjain.lnm@gmail.com" respectively) but same passwords.
> I used to use git for "yj291197" account and a few days earlier I made
> this new account and used git commit to commit on "yaki29" but it
> appeared as "yj291197" committed on "yaki29's" repo.
> Then I pulled a request of that commit then it appeared "yaki29"
> pulled a request with a commit of "yj291197".
>
>
>
> And during this whole session I was signed in as "yaki29" on github.com .
>
>
> Please reply ....
