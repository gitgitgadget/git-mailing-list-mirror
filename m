From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 10:46:41 -0400
Message-ID: <AANLkTinGedXLX_rZTtx6CeDonQ0dbsN2BBSqPcs258Yg@mail.gmail.com>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net> <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net> <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 15:47:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2PLE-0006KZ-FO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 15:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957Ab1CWOrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 10:47:05 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39478 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914Ab1CWOrB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 10:47:01 -0400
Received: by mail-yw0-f46.google.com with SMTP id 3so3380911ywj.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Emts8ic4eK+m9wfFTNuOiFY+YP93TCYMqF+u4aHzftQ=;
        b=ewqTgRTZE5xmHAcM9vN3psFIy4YeXCeaHW+EA0SnmriFo3nXLAcHiyPrS/Mz9XTO/W
         9MKNsPk4ecesa9RL63k5gY6cNNwH6r6uT1VJ6OjxiVInfkHizWMc7/Q2G73LbQfSjkE9
         uZzRzu2R8Ul9s5B3SsAq4o59TT4JtAWK4SEG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HswuP84z8PKy/zI2BQpfaeeJA05GSm/OtCiq6KyITa+uSR85w8bxXQVvH/yDuS9zbJ
         NIyRDZ6gk6qdSLPCuG2CcCAGhq6BOyPcMYoz5K6bRg+iGTzoaF6m217maBUm/dYDiO0s
         +uESJ1x/ooBEGUJRDG5OkUe4HHovGmeIi0y1I=
Received: by 10.90.247.28 with SMTP id u28mr2096465agh.117.1300891621297; Wed,
 23 Mar 2011 07:47:01 -0700 (PDT)
Received: by 10.90.74.2 with HTTP; Wed, 23 Mar 2011 07:46:41 -0700 (PDT)
In-Reply-To: <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169837>

On Wed, Mar 23, 2011 at 10:09 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Because --with-tree nor ls-files is the tool that was designed for.
>
> If you want to find out about a branch, why aren't you using "ls-tree=
 -r"?

Thanks! Tab-completion wasn't showing it, so I never saw it.

happy happy



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
