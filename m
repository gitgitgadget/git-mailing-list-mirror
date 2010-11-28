From: Bond <jamesbond.2k.g@gmail.com>
Subject: Re: how to git with google code
Date: Sun, 28 Nov 2010 10:06:49 +0530
Message-ID: <AANLkTimSdCOqC_nyLi4FsHPcJ+L9CnYzFK5OyQBoWUC7@mail.gmail.com>
References: <AANLkTi=5muNrriBoU0ZGnMqQUOjrJAvwLfyYO07-Ad3m@mail.gmail.com>
	<4CEFCE5E.1050003@drmicha.warpmail.net>
	<AANLkTik_HMVsHuvA00ZCcGJaOS_m8Tipq_fDyLucG9wN@mail.gmail.com>
	<AANLkTi=kuAkJSeJAWYQokOM2NFo08_98Eoodw_cz_c0r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 05:37:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMZ0e-0006Sf-Je
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 05:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab0K1Egv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 23:36:51 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52914 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab0K1Egu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 23:36:50 -0500
Received: by iwn5 with SMTP id 5so508163iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 20:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UsvX1a0Ps3kZRy9C3BiY1RKzquaI6z24wTVJUUl/zWA=;
        b=mFXhY9ddsHcBlXntWNHWQAopaBbeL5bGn1rjrAJZ+ghjS9c2XkoinHWRXlo+rc4gkw
         jBK0QiWNn780xfKMBOAOE/qHRRVEoTNm5JLFI9yu8y0gD0tSr2ZJ8mm57Z1Jp2l+W6pr
         2ivYF0kH2pKIMhYZlEug+W/r1je6v/iPJ6DdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gOEm+I5yYIi++dIJy0TKvwoyCAO8gIMNNGmxsxiMB83tvDF6mUyG4P9MvvvlrZnA4J
         l3Rv1mV+j625VSFEDabd41tGmqPAsrDKgAPgiVFsJBehNJklF/Zi1DsOC7H4sA7ttzQu
         RbtHh3+fFpm3CGmjARbHHWWKdh0mqvj/XMPoA=
Received: by 10.42.222.138 with SMTP id ig10mr1194185icb.65.1290919009315;
 Sat, 27 Nov 2010 20:36:49 -0800 (PST)
Received: by 10.42.166.202 with HTTP; Sat, 27 Nov 2010 20:36:49 -0800 (PST)
In-Reply-To: <AANLkTi=kuAkJSeJAWYQokOM2NFo08_98Eoodw_cz_c0r@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162334>

On Sun, Nov 28, 2010 at 9:57 AM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
> Hi,
> You can take "official source tree" and "Git-capable server" to be
> your git repo that you git init-ed in your first post. But it's empty
> isn't it? So, just skip the "git fetch" step. That leaves:
>
> =A0$ git svn clone ...
> =A0$ cd trunk
>
> Then go on from there.
What do I do from that is what I asked in first post of this thread?
