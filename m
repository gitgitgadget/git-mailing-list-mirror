Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C747F1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 15:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeHZTS3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 15:18:29 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46694 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeHZTS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 15:18:29 -0400
Received: by mail-lj1-f171.google.com with SMTP id 203-v6so10324859ljj.13
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OTHMCNQ+udZPLL39UJlJZyYMOlQHIrpzUZQ1EASkmyY=;
        b=C0QVcKqdCehTo6VNZZZ6N1xwdukyKcXQwJVPddjaiUfsiaj6FGGDyU4idTMlr4oh/C
         KNJpi6K7SIQIczDn1siY+zETk+zjezCR1/bXcUjE6Nsb4LzR4pvTf7D2xEqpOuYJFbQ4
         B89Wh7L6apnN32/M+D2nloq+BgV6BtyicH6KhTMHBj3QXWod/TJbNnFlTB/qREyk9wXh
         AzsIMzltEfPdIr4lfreKbne4a52+wkKAH7uQ2cBwQhoL5uAT47hcB/aYsYIBQVE4Gj6W
         cINVNf8fD8YEqsxF8Ag77ZCjQVphXELGFFXh717LHA2A+E0T/L/XIodB4BHSH4ycdAG1
         uW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OTHMCNQ+udZPLL39UJlJZyYMOlQHIrpzUZQ1EASkmyY=;
        b=pYqChu44ms8RZ3MbF+yWQgzZNhfxC7wA68PCsNYqtqeW53VPaMuYEElDhfH9lHfepC
         OeOOd4W+uTNejRHc2wmwAPCL6MfAnA4SanDGcFIvutVgbGA0B3IBRkCmp8zLK7N4cFPP
         tmp4ERyXDL4vJ7G0jcxxOX8T/ze8GGYIwtxcAyx29goq6gZCyiSn0AcYAdDJBADcyh5q
         m2p0HrP5wskqeVDMLLsFm2eV3COg+EMg2rDAHUWO3rRhPm0NZky6kwQu1UPLCB/G7omn
         XTiGWXPnzdvqELYNb1NGdqw2k1WJyiaQWameE6c3cSmcmwieahgz9O6vQWjlMI7rIg/w
         YjtA==
X-Gm-Message-State: APzg51D0k+ysdmDapNIHh1kpQQGe2Ok1zMzyeF3Sr8j75y632jMgW05F
        QJE4oNX5g1yFGk2zCG9B0sCIkMlBQH6b/5T0SkY6ig==
X-Google-Smtp-Source: ANB0VdaEdF8KaxL2AQhrSymGrj6FOOFRSLifeVZjj3DjE641JSuqS24EUeOiFSdZr2WV/RzrhGxVx+Q86I66ZGzYEto=
X-Received: by 2002:a2e:360c:: with SMTP id d12-v6mr6043459lja.88.1535297735087;
 Sun, 26 Aug 2018 08:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <5b827432100c5_33683fe5790d45b43591aa@github-lowworker-4f62d42.cp1-iad.github.net.mail>
In-Reply-To: <5b827432100c5_33683fe5790d45b43591aa@github-lowworker-4f62d42.cp1-iad.github.net.mail>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Sun, 26 Aug 2018 16:34:56 +0100
Message-ID: <CAPMsMoCR4J_gLBYCZpNW7JcMmdSGu-jFHpvVkQks7myYte1KeA@mail.gmail.com>
Subject: Re: [GitHub] Your password was reset
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

just wondering if there's something going on? Is there a github
account associated with the mailing list email? seems odd...

GitHub <noreply@github.com> escreveu no dia domingo, 26/08/2018 =C3=A0(s) 1=
0:35:
>
> Hello amc2399,
>
> We wanted to let you know that your GitHub password was reset.
>
> If you did not perform this action, you can recover access by entering gi=
t@vger.kernel.org into the form at https://github.com/password_reset
>
> To see this and other security events for your account, visit https://git=
hub.com/settings/security
>
> If you run into problems, please contact support by visiting https://gith=
ub.com/contact
>
> Please do not reply to this email with your password. We will never ask f=
or your password, and we strongly discourage you from sharing it with anyon=
e.



--=20
Obrigado,

Pedro Rijo
