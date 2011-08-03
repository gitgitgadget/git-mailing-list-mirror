From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH rc/histogram-diff] Make test number unique
Date: Wed, 3 Aug 2011 20:20:58 +0800
Message-ID: <CALUzUxoe9atOZ+NKMASxGswGCJqfP1v4GDEpm6XMvdJc=ghMYg@mail.gmail.com>
References: <4E38F7EB.3040400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 14:21:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoaRe-0000E9-BI
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 14:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab1HCMVB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 08:21:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51380 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab1HCMVA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 08:21:00 -0400
Received: by fxh19 with SMTP id 19so613299fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=h1SPNcueQ/l1gYqWks/ghlnNu8nf9hyN+cI8Iz+Cg2I=;
        b=u24qh2QkpqR24EHDscSgArtIcCTT48F+LjNe0A4Kx7OMGMI6DvBbTUAUiQ/jYjNX0+
         TTPo1dfiFMimddME4CY4/mNu72r5GtyTw85CPo8j0+oRTdf3gxe3BbUmdmjrXdODKpGP
         cudnEW+gBPbkEBR5IsyZnD/QFfwOKd+nCQWzs=
Received: by 10.223.101.7 with SMTP id a7mr9825996fao.141.1312374058771; Wed,
 03 Aug 2011 05:20:58 -0700 (PDT)
Received: by 10.223.87.66 with HTTP; Wed, 3 Aug 2011 05:20:58 -0700 (PDT)
In-Reply-To: <4E38F7EB.3040400@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178562>

On Wed, Aug 3, 2011 at 3:25 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> From: Johannes Sixt <j6t@kdbg.org>
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> =A0...9-diff-histogram.sh =3D> t4050-diff-histogram.sh} | =A0 =A00
> =A01 files changed, 0 insertions(+), 0 deletions(-)
> =A0rename t/{t4049-diff-histogram.sh =3D> t4050-diff-histogram.sh} (1=
00%)

Thanks for catching this.

--=20
Cheers,
Ray Chuan
