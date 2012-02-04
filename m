From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Sat, 4 Feb 2012 23:05:31 +0200
Message-ID: <CAMP44s1ZPQJzHzYj7e4Kj3Cu+qq0Q3uKrwsE=xS7BmmSqd3gSw@mail.gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
	<20120204201218.GF22928@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:05:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtmnh-0005SQ-6U
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab2BDVFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 16:05:34 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58278 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753928Ab2BDVFd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 16:05:33 -0500
Received: by lagu2 with SMTP id u2so2395823lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 13:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FR17DD+f8zaB77uCBTY42grKhOM4hlbiEk0d1ueaKLw=;
        b=EA4LrOcsDCYS5Pev7YC10Zc3jBKTAn4Ku/k4EFaW7otZi25YOsZWDdu8Vx9L8PvRCB
         Hb+hPPUnzWCnouewzMCZ6N6LgON+WxSTSF4d7fUMqpdYt2dribB+7eQgpttZMVuII1q0
         rpsN3kD1b5oU7JTS5KrUjRxtAf3aUomCbfZLk=
Received: by 10.152.125.20 with SMTP id mm20mr1722653lab.6.1328389531882; Sat,
 04 Feb 2012 13:05:31 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sat, 4 Feb 2012 13:05:31 -0800 (PST)
In-Reply-To: <20120204201218.GF22928@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189909>

On Sat, Feb 4, 2012 at 10:12 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> Similar comments to the last patch apply here. =C2=A0This time the pa=
tch
> is even more mysterious, since it seems to touch a number of test
> assertions, even while I assume not all of them relate to whatever
> this is supposed to check for.

Title: mailmap: add simple name translation test

--=20
=46elipe Contreras
