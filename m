From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Wed, 3 Aug 2011 18:40:13 +0200
Message-ID: <CACBZZX5-KrzZ+WptqX__W9GBE8LxY24fSXSth3JpiJyDbrzN-Q@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 18:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoeUb-0001Ox-Q6
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 18:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab1HCQkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 12:40:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59030 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab1HCQkP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 12:40:15 -0400
Received: by fxh19 with SMTP id 19so815364fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rfnD8fHzxIeXEz075gnDKrWYHla4UxgU5ajJdNJ05V4=;
        b=PeHzJtRmtlrdJHpJNSm6o0xL2vvuOX7OyRZDxYO7HwopFXbvx7rnen99ZlxpJ4lvNt
         5oB7tQskEKUT3EqJ/kTkMxAzbQNjjycOtpBOI2ntv4Knp72xhh+QT3BODhpvZqxwiDm+
         Dc4lG8ptI6pi/jY4QK2+0iD8oaA2hybLoAclk=
Received: by 10.223.36.89 with SMTP id s25mr10457569fad.19.1312389614060; Wed,
 03 Aug 2011 09:40:14 -0700 (PDT)
Received: by 10.223.48.81 with HTTP; Wed, 3 Aug 2011 09:40:13 -0700 (PDT)
In-Reply-To: <201107252233.02088.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178593>

2011/7/25 Jakub Narebski <jnareb@gmail.com>:

> =3D=3D=3D 16. Which of the following Git features do you use? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ localization of command-line messages (i18n)

It's probably better to move this to some "would you like i18n"
section. Nobody can use i18n at the moment, there's just a skeleton
implementation of it.
