From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 22:03:22 +0100
Message-ID: <AANLkTinKZfkK0uuyNJZf7f1hvfu5-LeSsxaE9fkQ2O5X@mail.gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
 <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com> <4D3FFB0F.9070700@viscovery.net>
 <m2hbcvz8me.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: francis.moro@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 26 22:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCWq-0006YO-Rb
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394Ab1AZVDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:03:43 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54062 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab1AZVDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:03:43 -0500
Received: by gyb11 with SMTP id 11so324051gyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 13:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=jXRaMJy9uoqfgQX8Gc+hCbpuYqk0Q4b4BeLmG1XXKp8=;
        b=NZVEammyAWSnAWIGQhhWWUjc6M661wJNEmmMY9WX0qBsMHfdLRf794lNI+Y+ZOfF1r
         vm54GGAUHGOR5SY9sUY57KEJFze+lYB4bgOmHGY4pndRiwXksFOx2rhwLvUo43st/vpQ
         ZZ81CEUD9l17xNf7rwR+jSmVU/YgucMQKpi1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kBnkQfFcgD1rRa6y9Q0slTZR4+Jj9uf2jzNUahMrP3LSBsOgqJVAK4zbNwxLjN5o8N
         FuuNRkoF9CW8cUoJwwPjeWHuqMn7ujqsbc2Qo21fDbE7QdaBLcGJZh1zH8cPJn5vMtft
         iwoBzGJSd3/DwWNbN51BlUc6enBMmHWzS4wno=
Received: by 10.150.203.19 with SMTP id a19mr1731739ybg.328.1296075822431;
 Wed, 26 Jan 2011 13:03:42 -0800 (PST)
Received: by 10.151.6.10 with HTTP; Wed, 26 Jan 2011 13:03:22 -0800 (PST)
In-Reply-To: <m2hbcvz8me.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165546>

Heya,

On Wed, Jan 26, 2011 at 21:56, Francis Moreau <francis.moro@gmail.com> wrote:
> Just out of curiosity, I'd like to know why, since it has no annoyance
> for those who are replying to my emails.

We keep everybody on CC who's interested in the thread here, and
usually reply directly to the person whose email we respond to. In
this case, I had to manually edit the TO line to be just you, and move
everybody else to the CC.

-- 
Cheers,

Sverre Rabbelier
