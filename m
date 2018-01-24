Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA91A1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeAXWqG (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:46:06 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33219 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933036AbeAXWqC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:46:02 -0500
Received: by mail-qt0-f175.google.com with SMTP id d8so14699662qtm.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 14:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudbees.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=;
        b=jKylPgrdk/Yj/4m6eBB+QE5DaDK8P0mBAcjsJ0XWkfmWv2VxGLEKIO3Z/9MsIz5SGR
         /WhnbKoJbV/TE35f6DhSAP+bBrX00ilomWBp6I6VE0WuJu8W4gv1RdjP+rTOzOwZshjt
         72CT2S1xdi5oCsqQRpyTjrlnNIM8q4MeKDxEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=;
        b=UVcUT2/rSwLub9kDwKhHT6HseAmS8UUCz4clax4sGR9p4oXv6wMZwiZWjlSiyqgu8I
         E68OCWeKLUnszG8EQjQXeZ3VSgDoykWv6L4uFT11PYEqgLDT7haziYPTMzQpNaMzqVi4
         KOVuzcNDzQWhm3808SoI28wmyiGEk9lwZAIZXB2GlEIHbXu07YB66RsXC4Vypau+8VzN
         n20QSqKefYDFZhWZFe6Ohv7/AW9wukslilvsi0Z8KKHLAH8T8dqgWHvfprJPbY6YhzBo
         QqTGmWhXorr+ycpnWcYCPE7/Y7MuSTe2utBn5Lv4kLWImcWjqwI1g+jQzwaTh5y8lndU
         A4dg==
X-Gm-Message-State: AKwxytcPrs1Sk9wuXP0yhycM18BUq28VRVX18ZGi6Tk4PImaGNHaJXBq
        i+JpaidyqALtKdkCpz4K00WCle/XUYmnC17DoJrrabCJ
X-Google-Smtp-Source: AH8x2278B/FdllChO1jV6CDU2e2w+wko9u1IR/e3Goaat6Sb9WHZp7KxSYIi+JLR2nT2Z5J5HMFrwXpKYaSQsjyqK/A=
X-Received: by 10.200.51.103 with SMTP id u36mr12867210qta.127.1516833961667;
 Wed, 24 Jan 2018 14:46:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.81.84 with HTTP; Wed, 24 Jan 2018 14:46:01 -0800 (PST)
From:   Mark Waite <mwaite@cloudbees.com>
Date:   Wed, 24 Jan 2018 15:46:01 -0700
Message-ID: <CAM2y_jXumYAHm7pkfTNnHMFKagwhoTGzN72HDchyOmE+ttoK6g@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

subscribe git
