From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: Sorry, completely off-topic. I've a mailer problem (was: Re:
 removing a commit from a branch)
Date: Wed, 4 May 2011 23:28:57 +0200
Message-ID: <BANLkTi=CE3aTqN+eSDwRuqvioLYtHG-z_w@mail.gmail.com>
References: <BANLkTimtpvVRU=1iCbrteyHixaWGuVKDjQ@mail.gmail.com>
	<alpine.DEB.2.00.1105041014480.16939@ds9.cixit.se>
	<4DC192A0.6010808@dirk.my1.cc>
	<4DC1A519.3070907@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Wed May 04 23:29:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHjd6-0003b3-On
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 23:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865Ab1EDV27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 17:28:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64559 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab1EDV26 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 17:28:58 -0400
Received: by pwi15 with SMTP id 15so699612pwi.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tXWhJiHfvnJxHLQFmDpgS5L3p8gbGs+V0/WBd7p6PdY=;
        b=Dt7tI9mGGO+oUtpDQzFYDt7bB/YGzgQnpLt3L3rjPtAameDjYuzOB7iyyCHqotIiMD
         pjTzU/XiNYxOEjUxJe71hs3OqGzcGeYlUksLTmehfNvRoY2Xko8Sw3txgzBWazVn3o4A
         fYap+xnzzwZbNXj7t7OXLc64EEeh5zVnHObcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=cOopfac2DAoZhmAWdUNdvkwePHqB9zn/lkQYGo4IJx1i3cl5Br5fJWaWujZs3dp4dt
         HNUKP84Pm2qmrKGGzRM3mLMxursZznxGNfEL1/JB1M+Qjm/EPS2gp50o85NKsk2CxR2C
         GVeAXdunuKW8aJnLEnKTijOswm/GPjdP7lC68=
Received: by 10.143.20.18 with SMTP id x18mr903560wfi.31.1304544538138; Wed,
 04 May 2011 14:28:58 -0700 (PDT)
Received: by 10.142.192.8 with HTTP; Wed, 4 May 2011 14:28:57 -0700 (PDT)
In-Reply-To: <4DC1A519.3070907@dirk.my1.cc>
X-Google-Sender-Auth: N7e8eymRsaFipuq6VCZN8eL1gI0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172770>

2011/5/4 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>:
> Sorry, I know, this is no Thunderbird board, but I guess other people
> use this client as well.
>
> When I write a message, it wraps at col 72 (or so). When I see my pos=
t
> in the list, it isn't wrapped at all. Only one long line per
> paragraph. That's inconvenient for the list and I'd like to avoid
> that. How do YOU do that?
>
> I'm using Mozilla Thunderbird 3.1.10 for Windows (which is the latest=
,
> I think).
>
> Again, I'm sorry about posing such an off-topic and non-git question,
> but probably someone has the same prob (or -- even better -- has had
> resolved it).

There is a section on how to set up Thunderbird and other mail clients
in Documentation/SubmittingPatches in the git.git repository which you
can read here:

  http://repo.or.cz/w/git.git/blob_plain/HEAD:/Documentation/Submitting=
Patches

Regards,
=C3=98yvind
