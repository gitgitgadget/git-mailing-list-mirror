From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v4 5/7] i18n: am: mark more strings for translation
Date: Wed, 25 Jul 2012 19:01:33 +0800
Message-ID: <CANYiYbFZ+kbYFdjedY1EBa9gy+7JDiTOQ2hPAG42zJaxdmphFg@mail.gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
	<b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343188013.git.worldhello.net@gmail.com>
	<915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
	<79fe36e1c66cec02eb54c48390d59bb1714c4736.1343188013.git.worldhello.net@gmail.com>
	<aea1284d5d0d441c8c85af3961d8c9062c2412e0.1343188013.git.worldhello.net@gmail.com>
	<1493bd09efd0ba6e1d56500305d989047da245ec.1343188013.git.worldhello.net@gmail.com>
	<500FC378.5090706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 13:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StzLe-00038x-UK
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 13:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab2GYLBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 07:01:35 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48232 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab2GYLBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 07:01:34 -0400
Received: by gglu4 with SMTP id u4so521541ggl.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3wKO0ftwbI9MoftpGfGy8WGMzuXSjOx2YNzY7XAR9WA=;
        b=BXqSoaLa0p4Kps4rG79QQHqK4ZFR195lktEzOXHsAjTOfLXUj/mSpyxoblPw29yA/b
         hZbu0xaBnaENhsznqwAgaFRdSJHqVeczxvIXTiEca0h2tCGPSzNaKMQUP/RmAdi0GcUz
         1Nrpk0DzcFsGfFakNF/aSKo8thAzOK12MFoqbSF6skyXpsigfeSVNdUSbNSzVwsiQnXF
         vAswfJyWWU3MHw+2uPVnmT+bRB8skSmzksfFrUMBPZVxna1syaUWycCgNaDLKkrP2UFp
         yu0FCd4UJbUVE+0lwdxAGuWV+t47QNPNluIEyWMoe3NDX62AeLMRmg3nbToUE8NDRSJ5
         z+8A==
Received: by 10.42.163.4 with SMTP id a4mr4548021icy.27.1343214093254; Wed, 25
 Jul 2012 04:01:33 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Wed, 25 Jul 2012 04:01:33 -0700 (PDT)
In-Reply-To: <500FC378.5090706@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202146>

2012/7/25 Stefano Lattarini <stefano.lattarini@gmail.com>:
>>  * Second, if there is a positional parameter ($1, $2,...) in the
>>    message, we could not use eval_gettext either. Because
>>    eval_gettext may be a wapper for gettext, and the positional
>>    parameter would loose it's original context.
>>
> ... here you should s/it's/its/.

OMG. You find what some grammer/spelling checking website hasn't.
If there are no other serious problems, I won't make noises (send
another series of patches) to this list, should I?

-- 
Jiang Xin
