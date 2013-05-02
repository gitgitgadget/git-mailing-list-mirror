From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v2 0/2] Remove the CYGWIN_V15_WIN32API build variable
Date: Thu, 2 May 2013 22:52:47 +0200
Message-ID: <20130502205247.GA26005@paksenarrion.iveqy.com>
References: <5182BD49.1070603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu May 02 22:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY0QK-0002BO-VG
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 22:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761942Ab3EBUsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 16:48:11 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:45597 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761785Ab3EBUsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 16:48:10 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so948349lab.14
        for <git@vger.kernel.org>; Thu, 02 May 2013 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f24k2OnKsDOrNVFrBgcFeJrZiEdHUjre8MzGpi/pEtA=;
        b=WG6+OnN4GDq1/ncWDpSzzO7pALyGWi6/SzaUeeas0stt5JqSTL4WoR0onwdIQTvq2q
         Jc7sV/DjPoV1gVmMvdv3x9Fp7mDxrh38uyWq5Qq4BoHxDBX1GNmFrdlQ9okhTsA2jY9H
         /ijKWY9jya6dXiv4/vlDfgFqKefkBPAoKyCNR3mnwcfFFmuTgq+UShdfPQ4XQnP+fa5q
         OkzkHLbnE59RFgelAVVEUUlczPtgOgQ6tp+ejt7F3/OsfT0E7HXXl2GawfxC/72O5IJb
         qedXDiNTPd1jx0mjJmTEEhZokxXbiOnX9DDSanVNZH2iQoqPFqoU30W+8QD2LCwu/wHl
         7pig==
X-Received: by 10.112.138.228 with SMTP id qt4mr3214694lbb.106.1367527688090;
        Thu, 02 May 2013 13:48:08 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id u6sm3272575lbe.4.2013.05.02.13.48.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 13:48:07 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UY0Uh-0006q9-Fu; Thu, 02 May 2013 22:52:47 +0200
Content-Disposition: inline
In-Reply-To: <5182BD49.1070603@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223264>

On Thu, May 02, 2013 at 08:23:53PM +0100, Ramsay Jones wrote:
>=20
> Hi Junio,
>=20

I'm not sure if this is a request that's valid or not. But for me it
would be appriciated if you could send patch-series as a reply to the
first e-mail in the patch-series. The way git send-email does.

That is:
If your first e-mail has the header "Message-Id: X" all following
e-mails in the same patch-serie has the header "In-Reply-To: X" set.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
