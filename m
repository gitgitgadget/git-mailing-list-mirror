From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH] remote: fix typo
Date: Fri, 18 May 2012 19:16:02 +0200
Message-ID: <CAN0XMOJoW0jZSYYZv0rWqJTEbCRBjDogq3iJ96SeYnpU9_Ab5g@mail.gmail.com>
References: <1337359561-17337-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 18 19:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVQmw-00008g-5V
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 19:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999Ab2ERRQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 13:16:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42440 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933048Ab2ERRQD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 13:16:03 -0400
Received: by yhmm54 with SMTP id m54so3102726yhm.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jDwgNV23/6bd3RjYEO6R3P/y/QX13LXlBexRXQtfjK0=;
        b=p8w9MvbhuDhe17PHUWkqgrjouZMVGS1H1vkIJV7MmxPCOf4yl9wdf3dEbCxFOMwW4C
         8v5soRymNggaVFBAg6eWDu3wne9+UbQ4tY+JQgK8dZgv7yo5w9AViS9X8kE/mwejdQhd
         aV2jK32hp2ojq0/YAym5XfIWYVSl0mCDBTH7pwpuBNO3mKRDt7G1p4Jv/l84kfajAzq0
         KkAzxCEJOfEK85fzp5ZVJ87r9Ib8bKt6hHKCKwdSQaOy3UT9n3ehunZMOo9N15o/Q3qb
         YUD8b3xxGA9sA+USHJT28eSfGxel+5z1xSWswn+r3duP7vng1YLyEvZcEsJUpZ/G/uoR
         +BuQ==
Received: by 10.236.109.229 with SMTP id s65mr13399196yhg.10.1337361362340;
 Fri, 18 May 2012 10:16:02 -0700 (PDT)
Received: by 10.146.218.6 with HTTP; Fri, 18 May 2012 10:16:02 -0700 (PDT)
In-Reply-To: <1337359561-17337-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197963>

On Fri, May 18, 2012 at 6:46 PM, Ralf Thielow
<ralf.thielow@googlemail.com> wrote:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 warning(_("Not updating non-default fetch respec\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 warning(_("Not updating non-default fetch refspec\n"

Oops, probably it's not a typo, sorry
