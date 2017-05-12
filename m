Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A531A1FF34
	for <e@80x24.org>; Fri, 12 May 2017 13:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932689AbdELNzJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 09:55:09 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36792 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932661AbdELNzH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 09:55:07 -0400
Received: by mail-qk0-f170.google.com with SMTP id u75so47936325qka.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=jQCl9ochSlQhesx2VEfhmzaM4a845NmO5acdsSx64yo=;
        b=mfLG0j8keUc0KtGyt054hSBm9ecuh0jK8SJ3+Hi9rnIqe4oUkr3Ge0CWQiqGrRCar0
         CUdPbzxwk4umsTP164A8QvysR2NR+EImanKcPr0wIht6eTwPpFhw2ko+CkU/6TJKdl/a
         RWscorTUOU74I/J9rMhtZ92PU+h8O2rMf9AfJ/ANjg1m85OHyL7hmeEouTSSNaR0GDCR
         RSTvIexOgMxjixRo4Ufwx2T+3lagIp1T40ZwhzqF1dqZS454gglfFHFEHNsOC8YTYRhd
         NG6IK3NxhmE/B8ajCXlHAPG8uKxSotxFIc+TrvGPnXIUXOJ3YDzeSm2OVQ1iZS2jYt0S
         ZONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=jQCl9ochSlQhesx2VEfhmzaM4a845NmO5acdsSx64yo=;
        b=FJfvZKxt6/LWWH0f52ymSlThVe3OMriDODgXS4BhqqciEo4gCsagoQpt/jx9+mHxol
         jxCaABTYDnyJrmgpN2co4WiCEetFCHdqmUvSaVuZkmmNjvvnPIYd4buxukcVevprR2wl
         SFLHb9JP173h+BIwmb98aEva4C23/Dpk1NFd5jHB8BEk6aQWloM450dDVVuleTH8y/zE
         V0aXmesTQgLrHVzM9pYzf4uW02WGxfY0Lwiv5H4du02D2N3MHqQj1B56EpWV0k6qZyr8
         R0ZEYIpBfleS4wpNBaeHGRZW3C/x26J3szHSRgA9AliRTnxZxKdf2j5opH90f+DQeE+e
         w9Pg==
X-Gm-Message-State: AODbwcBZgJk3sJtiWeyzez5AFrp67ey7MblfCws6lm4c9SosY55yRrHP
        N7nTYWbPvxl+DXDCkhs=
X-Received: by 10.55.38.69 with SMTP id y66mr3593882qkg.204.1494597306594;
        Fri, 12 May 2017 06:55:06 -0700 (PDT)
Received: from [10.7.103.167] ([65.200.162.5])
        by smtp.gmail.com with ESMTPSA id i40sm2326935qti.63.2017.05.12.06.55.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2017 06:55:05 -0700 (PDT)
From:   Rabii Elguermouni <rabii.elguermouni@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Fri, 12 May 2017 09:55:04 -0400
Subject: Git 2.13 silent install
Message-Id: <CBD45BD0-623B-4301-B02A-5051CDAC1569@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (14E304)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just wondering if someone can send me the instructions for an unattended/sil=
ent install for Git 2.13.=20

Thanks,
Rabii

Sent from my iPhone=
