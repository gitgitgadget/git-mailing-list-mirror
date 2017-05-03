Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_RHS_DOB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820A5207B3
	for <e@80x24.org>; Wed,  3 May 2017 02:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdECCkK (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 22:40:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35667 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdECCkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 22:40:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id i63so6288232pgd.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=nM3AA/fYrN6qCDlMR4RjiYD39VtEtJb7tWn0me0Be60=;
        b=M7brEbpUyHpSv9F708Czyv/Q3jsgx45hZvN3jrSF/HyG6v407yJI35HSjRWGkZIXSx
         /YhPDweQqQhTClmzEgdAIricPure6/SBMS/nS5OkkxJTj4MDDnDB7UQGsTHxjdpQdn+M
         9cnTvuF4Izy2e+0xfVAPSkMkbYU4kuPAxCA/4TnlTC64VTYn6cLYrpCZokHPMmDX1xXx
         rHVxkZ3LArK/7I+HBZLXs+Ivem/fCFOHZVyhTX4RxxWx0W/yJ6xbbbUhG3dXjhvmY8tv
         MQ/4R5814rvQGSEK1aECPG5iIkKUAHinZ+J/5qwA4YbvY/YLK8nDUyE4HGwlo++kFZou
         BeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=nM3AA/fYrN6qCDlMR4RjiYD39VtEtJb7tWn0me0Be60=;
        b=EQkZ7ZL3Spy9cu6XmrWMzK7kv6E6aUi1bbknPNn+d79Ie+thjPa9IsbopWlZ70s9Ek
         N0c1/83EiBu0Di3qOuW8vwtQxp5bSxymOMjIp4ceyoMrWGtM9KUjQVd+72+9x+4/F/Ts
         vBRMvy/vzrkfkjEiUl/CITLOuHOVW1CSjJM9nStaqVw2pn8gHKpw+HS+lpt8RVepn9IE
         6D7CFCUXwTynPhLNwuwfNDg+GOF6zFWKYESsAUDh1m2Z97sNnAG9ob4KvpGD/mws5IZ/
         2RlmNeOsyJlWbVhZJYsAL2s15AAG/EwEdsh/3gVGswMYIcaeWQpCX4TaG6FYoi5z3Mh3
         7jSQ==
X-Gm-Message-State: AN3rC/6K6QHAPQFgEJG2EbHp7SMkgJXnNF2SgBREjlYexIAZ0C4vhisE
        e5A6+kFoF5fNPmDqIpkq4w==
X-Received: by 10.99.51.79 with SMTP id z76mr36373315pgz.137.1493779207933;
        Tue, 02 May 2017 19:40:07 -0700 (PDT)
Received: from 45.77.32.35.vultr.com ([45.77.32.35])
        by smtp.gmail.com with ESMTPSA id p62sm1156681pfp.48.2017.05.02.19.40.06
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 19:40:06 -0700 (PDT)
From:   BAC Credomatic <nadia.q18@gmail.com>
X-Google-Original-From: "BAC Credomatic" <info@baccredomatic.com>
MIME-Version: 1.0
Reply-To: info@baccredomatic.com
To:     git@vger.kernel.org
Subject: Su cuenta bancaria esta bloqueada
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_4_1_3
Date:   Wed, 3 May 2017 02:40:03 +0000
Message-ID: <4900226159944185612131@vultr-guest>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Su cuenta bancaria esta bloqueada. Para desbloquear tu cuenta, haz click aq=
ui: http://baccredomaatic.com
