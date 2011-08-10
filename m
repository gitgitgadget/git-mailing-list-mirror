From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2011, #02; Mon, 8)
Date: Wed, 10 Aug 2011 04:48:10 -0700 (PDT)
Message-ID: <m3ty9p1oaa.fsf@localhost.localdomain>
References: <7v8vr3v7az.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 13:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr7Gj-0007bW-B0
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 13:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab1HJLsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Aug 2011 07:48:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab1HJLsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2011 07:48:12 -0400
Received: by fxh19 with SMTP id 19so817535fxh.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=XuwAXrU5S8RO/IqNVxbM0NC1zEqD0dbDm9ccAkz7vMQ=;
        b=QQcquZNjUT99Hl5wxUxo8K9b1tla9Hh1C/kaYcF2M+b03mp8lIlRANYiuo2T+Yc1oi
         RH5lmT1BvfUbOF4GB9j0Yf2s+oOEmm6RTmpxRGCP0TVEiHz6ybGBBH11viXU1uqDUzxw
         t97HlHisnUlusNV1a7hjWosYnLMD0G8ixwm2A=
Received: by 10.223.15.81 with SMTP id j17mr3167184faa.20.1312976890978;
        Wed, 10 Aug 2011 04:48:10 -0700 (PDT)
Received: from localhost.localdomain (abvd137.neoplus.adsl.tpnet.pl [83.8.201.137])
        by mx.google.com with ESMTPS id x13sm687448fah.5.2011.08.10.04.48.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 04:48:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p7ABlg27012230;
	Wed, 10 Aug 2011 13:47:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p7ABlQi4012226;
	Wed, 10 Aug 2011 13:47:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8vr3v7az.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179064>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Graduated to "master"]

> * jn/gitweb-config-list-case (2011-07-31) 1 commit
>   (merged to 'next' on 2011-08-01 at 9268738)
>  + gitweb: Git config keys are case insensitive, make config search t=
oo
>=20
> * jn/gitweb-system-config (2011-07-24) 1 commit
>   (merged to 'next' on 2011-08-01 at 4941e45)
>  + gitweb: Introduce common system-wide settings for convenience

What happened with "[PATCH/RFC 0/6] gitweb: Improve project search"
series from 29.07.2011?

  http://thread.gmane.org/gmane.comp.version-control.git/178132

Should I clean it up more to have this RFC series included in 'pu'?

--=20
Jakub Nar=EAbski
