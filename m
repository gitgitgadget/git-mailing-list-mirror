From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 1/4] contrib/diffall: change comment to reflect actual
 reason for 'cdup'
Date: Tue, 13 Mar 2012 13:49:35 -0400
Message-ID: <CAFouetiuTdg7htiJL_oHX=Z+yDsq+hmRWtCNWtYAS-pLm91ZaQ@mail.gmail.com>
References: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 18:49:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Vqv-0002Xr-MU
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 18:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758951Ab2CMRtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 13:49:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51990 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758268Ab2CMRtf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 13:49:35 -0400
Received: by iagz16 with SMTP id z16so1064377iag.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=357swH3oWD3YBfA0D24YQafWujjEg4LxdzZpWb2c5x0=;
        b=m2P3UK9FY/1KEP6INIwwJzvkOj13Ci+ynU6bjJq2pjezsTEss+rs2GyBfv5NLGT5Dn
         GEXkvzIOldJTQeUiltjRHt5Du1ykAx6rmS+pPdZHCO+Ys5xAoUUDAZoRN6dG9m7CUKGj
         jkPCiihkdGoINc0l5cjiKYiFx3IVKzRPNgJn5MW7qCZW9Xz1y3WlMFXYFEo2q91qFuHG
         JH+JVVmSynPTJanPF0LfMPP3j2bJy1oUpYLxyit+FhoTvWIeNdFWgw14W8/5I9ZE64kh
         W3Qt9LvNwI7FQztwDfO9FNmPaVCk2PdMK4GQWa5J5oqEf/rm5EAaPxowi3fEzYu8fzG/
         MrPA==
Received: by 10.50.140.106 with SMTP id rf10mr6213467igb.36.1331660975299;
 Tue, 13 Mar 2012 10:49:35 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Tue, 13 Mar 2012 10:49:35 -0700 (PDT)
In-Reply-To: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193045>

On Tue, Mar 13, 2012 at 1:45 PM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> The comment from an earlier commit did not reflect the actual reason =
this
> operation is needed.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
> =C2=A0contrib/diffall/git-diffall | =C2=A0 =C2=A04 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)

Junio - I had a typo in your email address when I sent this patch
series.  Sorry for the confusion.

Best regards,
Tim
