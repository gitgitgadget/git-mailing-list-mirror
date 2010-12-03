From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: BUG: git pull --rebase on detatched head prints a lot of usage warnings
Date: Fri, 3 Dec 2010 20:05:33 +0100
Message-ID: <AANLkTin-9pb7cxsAvDqWj3So47_zq5co9TZRWux9ezxz@mail.gmail.com>
References: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com> <20101203190050.GB14049@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 20:13:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POb4N-0005DZ-5g
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab0LCTNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:13:17 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65174 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab0LCTNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:13:16 -0500
Received: by yxt3 with SMTP id 3so4467907yxt.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 11:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=2cDhIS+k9sXd0mDEBdtpCO+i/xL+/N94n8HbHYBh9Y0=;
        b=xymOHJnuAyDPecu/wv5Xj6MZkKl6chO0/vLYFjYHiklQHXWDQlwPYu+HoLfgC5mYh6
         2DtX8TivRkaEp5ZBt3YMgxMvIed53Pib+9Teu1vYA0tgajsspQtG0AoWzSZTrdM502jo
         8rGFAVevaftbmHNh6uwyI7+R5v+ky6PeFM2gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ElH6cxiMiFGmYo0EyCK0SDshBZJBcfp3DUgH+eaN4hKgfqv1IsF9tajOAtiF3o7PWM
         wrKfRI4cajwzSndWsZ44aUVGF2/yFDZMRgfsRSf6vbw9b9HJQat4g1T1tmSl42CtuAlF
         ng/MZhma+Yty64k3PHSmOE/UKD1Elad4qXwqQ=
Received: by 10.150.190.14 with SMTP id n14mr4247215ybf.416.1291403153855;
 Fri, 03 Dec 2010 11:05:53 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Fri, 3 Dec 2010 11:05:33 -0800 (PST)
In-Reply-To: <20101203190050.GB14049@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162829>

Heya,

On Fri, Dec 3, 2010 at 20:00, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Does the following take care of it?

Yes.

Tested-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
