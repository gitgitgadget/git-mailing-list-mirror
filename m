From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH v2] part1: l10n: de.po: use imperative form for command options
Date: Sat, 25 Oct 2014 10:53:28 +0200
Message-ID: <F5BFA47C-29B9-46BE-997E-7EAF7371A095@gmail.com>
References: <CAN0XMO+BR4Tp1EOCPe-ajNyuHpkN1B36T3rzRdw1Z_tzsZH6Dg@mail.gmail.com> <1414173724-10104-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:28:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi71C-0002rA-HL
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 21:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbaJYT2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 15:28:50 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59479 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbaJYT2r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 15:28:47 -0400
Received: by mail-wi0-f170.google.com with SMTP id n3so3359380wiv.5
        for <git@vger.kernel.org>; Sat, 25 Oct 2014 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=JqMBQjVrtBktwMl28R2N+53oMmzNKtOfDVtFBLNQCrc=;
        b=ZV4itcI5o3yR59n7ouSYnxxCCzxfhqG147fwiGF4nEq9Ij5K6t8XXBBNyMatBuDkYZ
         f0ej0Zic8SwwRWywL2i2bVhDr32HgICPjFPxbXzKNJngTsIKvoq2D5H70RGiaityVy4v
         0Mn6dQhpJ/mweIjQKXyK1DioBSQqk43I4yAuPqYS0rPOY821E9/3VCPl/eQxRDm7+rVk
         M9nqqFbFB0OHbnvAItJSiNTOnbKgYJdZGDekDfUZZ1zXxe5uqq+HXIHzOa7wadKwpQla
         yTg2QaZigvp6a1ox+jJTFFaDjsb5b6eAvhhHwqt3LcD8esQfcOBxl7yE6rhPKuScGADG
         j44g==
X-Received: by 10.194.48.84 with SMTP id j20mr3416158wjn.35.1414227210463;
        Sat, 25 Oct 2014 01:53:30 -0700 (PDT)
Received: from android-b7bb6bce7d91de53.fritz.box (i59F4580E.versanet.de. [89.244.88.14])
        by mx.google.com with ESMTPSA id k10sm8154357wjb.28.2014.10.25.01.53.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 25 Oct 2014 01:53:29 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <1414173724-10104-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> #: builtin/blame.c:2514
> msgid "Show author email instead of name (Default: off)"
>-msgstr "Zeigt anstatt des Namens die Email-Adresse des Autors
>(Standard: aus)"
>+msgstr "Anstatt des Namens die Email-Adresse des Autors anzeigen
>(Standard: aus)"
> 

+msgstr "Anstatt des Namens die E-Mail-Adresse des Autors anzeigen
(Standard: aus)" is better.

All other strings are fine.

Phillip
