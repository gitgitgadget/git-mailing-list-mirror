From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH 2/5] Not all vendor diffs support GNUisms (resend)
Date: Sat, 12 Jun 2010 09:24:02 -0700
Message-ID: <AANLkTin6rVO9n0NmTjCrxjDR9NL7ITal913MpGaCGjEV@mail.gmail.com>
References: <20100311163039.GB7877@thor.il.thewrittenword.com>
	<4B994324.9060400@lsrfire.ath.cx>
	<20100315050943.GA22128@thor.il.thewrittenword.com>
	<4BD45874.9010700@lsrfire.ath.cx>
	<20100425152130.GA27695@thor.il.thewrittenword.com>
	<4BD46BCA.3010308@lsrfire.ath.cx>
	<20100426165010.GB28004@thor.il.thewrittenword.com>
	<4BD5E2BC.3000106@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:24:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTVE-0002Kq-Ey
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab0FLQYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 12:24:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46584 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0FLQYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jun 2010 12:24:03 -0400
Received: by wyb40 with SMTP id 40so2096068wyb.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a1cC6izH+D4h6PoMHf4AG7A6+aaI0r21OCOqGZX4Nfg=;
        b=T/a1bwnInGX08jYoEYgwMsLzPKZ6wVYv77i/7NIfcqu6NzdLGnSq6pRIURHFFQsSEO
         ScUHv7i1UUSVb1Bl8L2XcCNVR94Zb4F+7Wr7LTl82crbkhi5FDYGZ08+TCYRZJfcG5vz
         icPwWHY4Hu8VEs5veWLpJl4eMaM45dSagHMSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ukqcfcgws6feLCfaX1coBUOAb+4tM9B6Oz8NNOsCGmKiN68ZwnQ0K+u8kOn1IJBquF
         TrtG9pFE2+JdAZRYoUlgdrmOE/xng+J9juuG03X/mrc+qfoIPPhgJDgTS13LyMkUX/v6
         Bc4hkbnbkZrVpHJEq2+w8EGGep7v0ZzbS7tTI=
Received: by 10.216.85.147 with SMTP id u19mr517053wee.109.1276359842632; Sat, 
	12 Jun 2010 09:24:02 -0700 (PDT)
Received: by 10.216.23.71 with HTTP; Sat, 12 Jun 2010 09:24:02 -0700 (PDT)
In-Reply-To: <4BD5E2BC.3000106@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149012>

Hey,

On Mon, Apr 26, 2010 at 12:00 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
>>
>> http://git-scm.com/download still shows 1.7.0.6 as the latest releas=
e,
>> or is 1.7.1 not considered stable?
>
> I guess the release is just too fresh and Scott hasn't come around to
> updating the website, yet. =C2=A01.7.1 is the current stable version.
>

I realize this is a rather old thread, but I didn't see it before.  I
don't actually maintain the version by hand - it is updated
automatically when Junio cuts the maint branch.  It took him a bit
longer to cut the maint branch after 1.7.1 was released, so the site
wasn't updated until then.  FYI.

Scott
