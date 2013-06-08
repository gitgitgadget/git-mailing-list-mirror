From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 12:44:44 -0500
Message-ID: <CAMP44s1pSTZrv5hp85+N=Jx3ZevWSYo3BArT7oZKrftC-gnMeA@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 19:44:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlNC6-0003Zp-JW
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab3FHRor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 13:44:47 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35016 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab3FHRoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 13:44:46 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so989974lbi.6
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tynIVG3TcprCP5x94IV+HkUMadx7eEpvLUP1U6MqlhM=;
        b=0pPyxPjwOpsSXLtGtSnKsMXdMNYt19EgoUcI2CgadT0slzgACLl/wuTyJwG77eOCis
         RAMKgXTmYJfuTKF2DuIQ72EvQflEzSLI+GyCk67Hj11oA0p8TpbLhJi8fw+DeTHuCF88
         pDUkqEc5tQ5jZvS0XKiXtF2RyFMheNJjCXnLGPlP4K+reYD2SxglS1lo4Lzw8611uG8Z
         pAZtWSwJcEhKoJA95bodGnyWIj/EUIAGjsgohVVqlanj9fkCfU5hC5RKSzY85GYhEmMc
         IH2SqUxZj3A80oRTNOR4wDTBT9pbWB6qjnUVs7cskJ9q3vJCQ9hC0Nq9+r+3v1OMfzUJ
         enhg==
X-Received: by 10.112.16.163 with SMTP id h3mr3387488lbd.85.1370713484937;
 Sat, 08 Jun 2013 10:44:44 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 10:44:44 -0700 (PDT)
In-Reply-To: <20130608173447.GA4381@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226849>

On Sat, Jun 8, 2013 at 12:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> This has nothing to do with better strategy, it has everything to do
>> with gut feelings and tradition. Not reasons.
>
> I try to help you, and you insult me.  I don't think this is worth it.

I didn't direct that comment to you; you took the pellet and threw it
at yourself.

Moreover, following gut feelings and traditions without reason is not
an insult, that's what human beings do.

-- 
Felipe Contreras
