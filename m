From: Martin Langhoff <martin@laptop.org>
Subject: Re: cvsimport still not working with cvsnt
Date: Sun, 30 Jan 2011 13:19:00 -0700
Message-ID: <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
References: <4D0ED5EC.9020402@burntmail.com>
	<20101220213654.GA24628@burratino>
	<4D112586.2060904@Freescale.com>
	<4D119015.6020207@burntmail.com>
	<4D2AB63D.7040803@burntmail.com>
	<AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
	<4D2FEF49.8070205@burntmail.com>
	<20110114074449.GA11175@burratino>
	<7v8vynnokt.fsf@alter.siamese.dyndns.org>
	<4D450655.5090501@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 21:19:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjdjq-0006pr-Q5
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 21:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab1A3UTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 15:19:04 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46581 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab1A3UTD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 15:19:03 -0500
Received: by fxm20 with SMTP id 20so4971357fxm.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 12:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LLLLWLPptH4wo2bpxeOQt/MT9qO3dHi572xn9Bj3pVw=;
        b=YaspZUM4mcBovh9LVInNslUe13PAoEO8opHbBcFa0aRio2ylzhw8EDUiaVHTyEFKai
         9aFoRvjnnidNPZdAM7Pgw7iX5DSmgiPNMsMVWNUyzWehl7ZprQiJM1zaI+uNyAYXuUev
         Bixc08witXXM5+h/nvWKCd3LYREuRbFa6BfEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=e8e0O39x0nOEthfe5zkGH17HtfKj86VVs5PFeOnkNCKSW6XezBcv8mg1V2kUN2ATrq
         e7QwcDFMqL0Xx1XtikkbTBIFQnDrOq9fBzV7FxOBzV997vqJBQ6DxstvqVHzCT2KTo1a
         T46l1QpvHQbhiMlJdCRhPj4yF0eWdlaZoC4Rw=
Received: by 10.223.114.14 with SMTP id c14mr5079425faq.103.1296418741174;
 Sun, 30 Jan 2011 12:19:01 -0800 (PST)
Received: by 10.223.107.202 with HTTP; Sun, 30 Jan 2011 12:19:00 -0800 (PST)
In-Reply-To: <4D450655.5090501@burntmail.com>
X-Google-Sender-Auth: PWSlMUD2P95Iv0TtYzuMua-nhBk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165698>

On Sat, Jan 29, 2011 at 11:33 PM, Guy Rouillier <guyr@burntmail.com> wr=
ote:
> That was my original inclination. =A0As no other opinions have been p=
osted
> since your message, here is my amended patch, incorporating Martin's
> ideas and dieing if the script finds both CVS and CVSNT password file=
s.

ACK! Thanks!


m
--=20
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
