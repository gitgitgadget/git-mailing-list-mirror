From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 22:14:37 +0100
Message-ID: <AANLkTimzUFL0ByGcA1QRNL+br57ZY6OME4aFAT+ipaJV@mail.gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
 <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com> <4D3FFB0F.9070700@viscovery.net>
 <m2hbcvz8me.fsf@gmail.com> <AANLkTinKZfkK0uuyNJZf7f1hvfu5-LeSsxaE9fkQ2O5X@mail.gmail.com>
 <m2d3njz839.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 22:15:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiChk-0008BO-Tt
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab1AZVO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:14:59 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59771 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab1AZVO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:14:58 -0500
Received: by gyb11 with SMTP id 11so327931gyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 13:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=qPg6FAxKxXmbA72d06hUXGJVZDKOhwERNITLvEqD5Lg=;
        b=Qi9R6ilZT+5W/fLrjBdCXVLSh54mZ2AD1aHRg5GYm3GjlYA2Vy7zYT8WXrgkdakb5b
         dV5IPf/4Xf/zPNi0mjOagH450Tij15rSolTHdDyOQ+dLnUXzIJoip3qKVW5Jgdfz+6p9
         4jTlrkrGH9IcJdGsgQlQJxd51t7KpxeSDmgO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fu8olSfIlHIwjhiq08zHdr+pf4LDiD+XDzLa31EIKlWjU6UvZGosJU+Xt9kxs8ugQt
         MVf3zcDV51+V2XUw8vyojaHmTv6KkYGfW7Ob9I80mL9o50xHjiYLIax5mKVNlxd3Bmlx
         KDU2RQXzdqMvnyLak+PiR+svU+VYa4r5djefM=
Received: by 10.151.63.24 with SMTP id q24mr1644251ybk.385.1296076498018; Wed,
 26 Jan 2011 13:14:58 -0800 (PST)
Received: by 10.151.6.10 with HTTP; Wed, 26 Jan 2011 13:14:37 -0800 (PST)
In-Reply-To: <m2d3njz839.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165548>

Heya,

On Wed, Jan 26, 2011 at 22:08, Francis Moreau <francis.moro@gmail.com> wrote:
> Well, if I decided to set Mail-Followup-To, that do mean that I don't
> want you to do that !

Yes, but it makes it harder for us to do that. For example, now I had
to remove myself from the to line, add you, and move everybody else to
CC. In other words, please don't do it. Thanks :)

-- 
Cheers,

Sverre Rabbelier
