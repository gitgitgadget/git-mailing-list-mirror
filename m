Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39C41F453
	for <e@80x24.org>; Fri, 25 Jan 2019 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfAYJrs (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 04:47:48 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42625 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfAYJrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 04:47:48 -0500
Received: by mail-ed1-f52.google.com with SMTP id y20so6870725edw.9
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 01:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pAmlexMbjHdSfE7D2GZqmpoWnckdH+gytMG8qPYYL5Q=;
        b=ab1TWraUEuhxlN2gJdIuY7xcoI6PK0KlcRCF0RD1Xw7L0OfgFheOnIjsHeXd7YPed8
         CUSNjDUyHYS2+Hcg7mkAMBjFzRj7sgX+A0VWgON4E/tV3vSGyd51FnQsNA5Ri7+Vk6Dk
         6tfwYtCcbznNDgxsrrMXD5mn28jo8Ire2pTOXnZOcTDal6qEJhxupYWOLJR9/hSWTr3d
         3Ob+UcW2nSaFQ3W1G2/2b3X8yyk4rOIcIzOux5liMvAV97Sl+4ZbDBUBgYpAoDQIhLg4
         /C8p78ndm/fhA7pOuGYYn4IkwNO3O1oYoG0VfEgsnp9S1cLIl6TUz2bkClKKvrUyVSSI
         BoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pAmlexMbjHdSfE7D2GZqmpoWnckdH+gytMG8qPYYL5Q=;
        b=MGniIS0KG76dcemOtkHa/hYnZMrxuHuBVAqk9eB04MWkXXXAzRWHo6oiR5wystKMSl
         xsjMldd3hqYSTL0T9BuqOC/Fio8TMTyrQglwS8xoA9UkPtmrUbCpKyQYbdOItiHeyEYD
         WN9sKKA55zGKMLzemXME2WWKuyfpgtoVQErPPsiCNXFCyDB2hFn+JWsGYh0lD9E7bHBY
         VSKFljkUgfNRyoeRblOFGPsHYaHbcTHzrMcI9rlxDD1QPMiRFJ2EF91rZps/LBkbvw/K
         P+Fcfysohn2Z68gCUsJgua03WFQwm5Qpd9oRaKzs7/8LiZzqZU3pCrHjHXDCmU7nKynS
         yHTQ==
X-Gm-Message-State: AJcUukeAFUVCyj6OwT1Dpqqyl767gJtlgY+vkY6VRZSpNqpIOPdtZbIH
        QR5D6v8TKlxqErwIv0Gcl79hgJwR/3DIfA22AyjY2K4M
X-Google-Smtp-Source: ALg8bN62cmU1/9eO5Cipd4Tr+KsuRt94CWDo9RZ1CneFzRBzyC5K6OT0ABZI635W5L2LxP6lC5Lj8iUNVRgzV0fkbII=
X-Received: by 2002:a50:898f:: with SMTP id g15mr9591903edg.257.1548409666119;
 Fri, 25 Jan 2019 01:47:46 -0800 (PST)
MIME-Version: 1.0
From:   Furkan DURUL <furkaandurul@gmail.com>
Date:   Fri, 25 Jan 2019 12:47:35 +0300
Message-ID: <CAL9vGGXKTx26K+ntscx32UeGzabgAnDeNGpuvCefubX4YHyvsQ@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
My name is Furkan. I'm a new graduated Electronics and Communication
Engineer in Turkey. In my current workplace, we use Git in all our
projects and I really learned a lot from your Pro Git Book. I would
like to contribute to translation of this book to Turkish. I'm also a
freelance translator and have experience about translation.
Look forward to hear you
Cheers
