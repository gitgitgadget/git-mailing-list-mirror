From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] i18n: bundle: mark git-bundle usage for translation
Date: Thu, 22 Jan 2015 13:10:35 +0600
Message-ID: <CANCZXo4F8xWv4Z3_E281NHK3eAm-DChDCrjRCEoeO70T==+XAw@mail.gmail.com>
References: <1421867023-31730-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqiofzx2fi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:10:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEBub-0004sv-NG
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 08:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbbAVHKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 02:10:38 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45601 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbAVHKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 02:10:36 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so23218282obc.6
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 23:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OYBbUPMV6Fd0EaIJeWcQn6PpP+pTgvdffoIRp+Qxf8s=;
        b=vkuNU/4941B3ybUlSyoLfh61VAa7pmUemfx4jqCInggqtBfD0QymArDlFRy+ncIZ6f
         QUraA/TDZGQEcU19UaiPCjaWI2BJ8WHYMe63dJMZ599Zc8mZ66CZfyCLk0eGxnvT93sL
         jM76A5XzG1+imuNBNT4U4rnOcXs6C6kyMABfpHm34LhZkQZWzziYbS8RrWQD4NxCrL0n
         zYCu4JBn9mA9s5vUKhwWiSgeuihzdZ5jkUWvlWGf71pA27PqCiQtwHqY0eIoDCUcnPc1
         xZo8JH/lR22hJgs7rYiWp5BTLUJJ9hVZjzFpidiPMP2m3mIUGj4RJIYVB7hBuvhTgJW1
         P7IA==
X-Received: by 10.182.27.241 with SMTP id w17mr3533obg.14.1421910636078; Wed,
 21 Jan 2015 23:10:36 -0800 (PST)
Received: by 10.182.26.116 with HTTP; Wed, 21 Jan 2015 23:10:35 -0800 (PST)
In-Reply-To: <xmqqiofzx2fi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262802>

Ok, understand.

How to be with it? Resend after 2.3?

Thank you.

2015-01-22 3:13 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Thanks, but please hold this off until the 2.3 final is tagged.
>
> It is way too late for anything that is not a regression fix at this
> point in this cycle, and changes that affect i18n are the last thing
> we want to take late in the cycle because l10n people need time to
> update the translations.



-- 
_________________________
0xAX
