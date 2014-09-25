From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH 3/7] part3: l10n: de.po: use imperative form for command options
Date: Thu, 25 Sep 2014 21:45:59 +0200
Message-ID: <5f9996e2-43a4-4f04-95ff-bc9ff3499dc1@email.android.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com> <1411146770-8508-4-git-send-email-ralf.thielow@gmail.com> <54214A4D.8080904@gmail.com> <CAN0XMO+z-PbcLWO-OS04LeALzDvS5kXsnEB=hZTRGAWhTBVC0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?ISO-8859-1?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
	=?ISO-8859-1?Q?Magnus_G=F6rlitz?= <magnus.goerlitz@googlemail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 21:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXEzQ-0004Xl-OS
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 21:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbaIYTqE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 15:46:04 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:45323 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaIYTqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 15:46:02 -0400
Received: by mail-wg0-f45.google.com with SMTP id x13so8177172wgg.16
        for <git@vger.kernel.org>; Thu, 25 Sep 2014 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=MnbWAckYBa0Ig4bGCF8+GXmknVEXTWPQeV7AvqMSYQE=;
        b=aED5seR0WeZXUuw8t63NiEhvsNz6DMvR6Oi4nk7F4+C5WwVvNei3LhvA1NThw1ckqp
         SRWYX0tFrZCyHwd4asKDg/mVjM5AcoGhwxLfL2pUtzxvKds+NQt7YmboUFHvv585BPBn
         7Cx44DxWs3Mg4BVbFQifdgbLz2dkx1LljRFxrYgLpGCuDdtURwdVu2PqQomvodwaDkSb
         Bo3JIKBitavOT66EGP03D4OuVCrB8NEwu8Sv8W641NO8M12HZBDn+PCydwaW+NVJETiV
         OjERVLA1ctfLA0C5op6twoO+pdzEcVPxaaYwt16VTysMT7zND757hVD0sBikXdIFEyFi
         mtvg==
X-Received: by 10.180.75.229 with SMTP id f5mr21415616wiw.81.1411674361245;
        Thu, 25 Sep 2014 12:46:01 -0700 (PDT)
Received: from android-b7bb6bce7d91de53.fritz.box (i59F45BC3.versanet.de. [89.244.91.195])
        by mx.google.com with ESMTPSA id pk9sm3761871wjb.16.2014.09.25.12.46.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Sep 2014 12:46:00 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAN0XMO+z-PbcLWO-OS04LeALzDvS5kXsnEB=hZTRGAWhTBVC0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257494>



Hi,

>You send a patch for the comma before "um" (thanks for that). I'll
>rebase
>these patches on top of that before applying, so the comma will be
>added
>then.
>

Okey, thanks.

>>
>> Maybe its better to use =C2=BBStream=C2=BB instead of =C2=BBStrom=C2=
=AB in general?
>>
>
>What about "Datenstrom"?

Yeah, that would work.

Phillip
