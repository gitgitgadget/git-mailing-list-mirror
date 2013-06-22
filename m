From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 13/16] t/t5505-remote: test multiple push/pull in remotes-file
Date: Sat, 22 Jun 2013 13:11:30 +0530
Message-ID: <CALkWK0kK+4sk6ULjMh1_BYN9_xFcoB0WaSih2ekfc6XawWFJBA@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <1371813160-4200-14-git-send-email-artagnon@gmail.com> <CAPig+cSYC4Qv8n_Ly0kWbKho77eJsGxiKZgRCE9XR668vZ92wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 09:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqISc-00033u-U3
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 09:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab3FVHmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 03:42:11 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:64902 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab3FVHmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 03:42:10 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so21311688iej.15
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZorXOGrjcNGBlNsNbrX/G3eJ4WtpKxwlG/aZhOzuHso=;
        b=znniHRWL+Ep2XNw66mZegJ9OiLggeZxmMwYVa9Jq7mGfQBtRlK1y+9kb2lDBLczxjF
         K5GBxtK+r6/QaMjHONPJCpP2dtwDS61GX+YUHyx7dUXtuYUR31t6NhgsuIbRVMcsdm86
         9JCcIgkekw1XCSBuEdeuMfpEJr9cKpScUXnz8wRRIot1+r5qUov3MDf2qOyA2U1POvzw
         XXLkb+2e42FtklgLIKutbbZW+po3C20ikBUMC+FS9xEJFJzWSVA/Yd7/XtErYm2wiwRR
         QB7a+bQb9B6B6782K9n48Od7ISwTnlmd3ai97pyoqDUBNPL7KrhuCcA5sUdYgNO08b+d
         ga6Q==
X-Received: by 10.42.190.74 with SMTP id dh10mr7704836icb.35.1371886930341;
 Sat, 22 Jun 2013 00:42:10 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 22 Jun 2013 00:41:30 -0700 (PDT)
In-Reply-To: <CAPig+cSYC4Qv8n_Ly0kWbKho77eJsGxiKZgRCE9XR668vZ92wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228676>

Eric Sunshine wrote:
> Broken &&-chain.

Good eyes, thanks.
