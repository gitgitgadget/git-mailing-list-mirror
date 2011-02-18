From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git clone NonExistentLocation
Date: Fri, 18 Feb 2011 11:16:38 +0100
Message-ID: <AANLkTinAALcC4O2atwAbYfz8BUnwO+z9E9b48mkVAMjj@mail.gmail.com>
References: <4D5CE3E7.5030101@atlas-elektronik.com> <4D5D1715.5020707@drmicha.warpmail.net>
 <4D5D1A04.4090107@atlas-elektronik.com> <4D5D1BCB.3010003@drmicha.warpmail.net>
 <AANLkTin3Pf4XD_gbwxPzW4uff9SbDWJdGug6jM_SHDo+@mail.gmail.com>
 <4D5D5275.5070501@drmicha.warpmail.net> <20110218040152.GA25466@sigill.intra.peff.net>
 <7vd3mp6ftp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 11:17:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqNOv-0000ew-1F
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 11:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1BRKRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 05:17:20 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60738 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab1BRKRS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 05:17:18 -0500
Received: by gyb11 with SMTP id 11so1523753gyb.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 02:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=bSOJpPu/CJL1Nux1xRPklVY/tmwDeN3t2bJCJ3JwQxg=;
        b=nB2QNZNishTJtOCa0SG7xjRJziULbTWfJ33yWZ45TTAXmz4VouuC64X4CVYDCFnumD
         r+3JzAuFDMiLyC9X7T+Glb2MFXXca5XpAf1Q60sDwra+jivJb1m1QmFbmKn8RuzOPbgI
         uW+tpT1F1H+2BfS00Nvg2BFwC732XWdrvIqws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i/67w84SzwOKZUAHDrsGZNdooN6eFTds1QAkXmBaYYS0hj6ad4B/5FGNv71r+giKG8
         egz51sA2B+fk6sictnTZBf1J3vkQXA2gYmXCK/cQ9g3/ruo5RtjKYeElhdTfSJgli6sc
         MprbRo2+Idudy3hLe5OjfBk3y/T8D86xFysFs=
Received: by 10.150.100.11 with SMTP id x11mr814610ybb.419.1298024238112; Fri,
 18 Feb 2011 02:17:18 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Fri, 18 Feb 2011 02:16:38 -0800 (PST)
In-Reply-To: <7vd3mp6ftp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167193>

Heya,

On Fri, Feb 18, 2011 at 07:02, Junio C Hamano <gitster@pobox.com> wrote=
:
> IOW, wouldn't the fix be more like this? =C2=A0Your new test script s=
eems to
> pass with this.

Thanks for fixing both.

--=20
Cheers,

Sverre Rabbelier
