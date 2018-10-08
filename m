Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B9D1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 13:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJHUpA (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 16:45:00 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:46313 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 16:45:00 -0400
Received: by mail-vs1-f50.google.com with SMTP id i10so11385472vsm.13
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=OR5kIIFh3TVb7YV3O0+yZjYRGhf3BwHKltS8M0NbvbIVZxteG0E4XZxnKZca6h15U4
         BPbyvGBTiqveItfPD1EDFmI+gJBkngn9BeGNspgNSDEJHwGvxYb09vSZpTPyB+ozpUPc
         PjyaRaNe7KOBMww3Xr0V5cIt5dvibo08+6Pe8f3VZIk3Xv6pN9XIsPp2b731217FGa7s
         hgkC/zfclOB88FJ9InUwx5sVjFvNO6Bi2kkY3pjhQ11ui5nVCH69Abasi/PLGOuldP41
         cqYCdeICiQ9O+tI+ELOc29xpnVZ1AgfTakFP873+Cle4+C7gQsHPuTo9a7XKuq6uo60/
         bc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=Px+vui2/IWRrhLIM3T+SxipNiduJPPSwBVsKJGRTY3AUD4MjIl0ApfUAfMd7xUE/Xh
         vblqHKUMWt6W4FOjoItucTnZCYwvA82rNLGZvZNNfvLfC45A+8uL5d0yMRMrNaK0mp2D
         3JhSUuLBa5vEo4J3dsICsDsZML12cw4mTabsfjABoFEAsu1DJktsuuJ/zDF4Ej3LyWPF
         JpFHwoiw8OpL+R5IoaDytssILQezR0ReunN9lImYksBVJt9IAfGb1wc0wYtWpvIU9Aox
         2K2R9yar/OgqOGS8eLtl/ebgN2s5QQP3yFsCXC8FevRhoA2bijt/YnBv1vjEhG7LLD29
         NPwg==
X-Gm-Message-State: ABuFfojp/cyeOd3LWQB54TeTkyANxSr/KA4RNFH1caRpn4aoWbnJuw8R
        DzvTXXfsFf9Iy35oBX6QcseMfXApo6my2ZRn5IYkj6/JEjg=
X-Google-Smtp-Source: ACcGV63gK26cIrezj0gO6FlWQIxGNht13PGUuViKTNoD9SHcw+5Gz6pj+R0uSzvlz6i9xb8tK/S0hqK6UkbL20phSiU=
X-Received: by 2002:a67:8c83:: with SMTP id o125-v6mr8685679vsd.3.1539005594134;
 Mon, 08 Oct 2018 06:33:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: netravnen@gmail.com
From:   Netravnen <netravnen@gmail.com>
Date:   Mon, 8 Oct 2018 15:33:03 +0200
Message-ID: <CA+cYV6v9RVkcheB+9gZot_tP07RzJuLP6b=gstxhCnzN=PKGPA@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe git
