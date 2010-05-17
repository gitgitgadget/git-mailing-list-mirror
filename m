From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 22:11:22 +0800
Message-ID: <AANLkTinoTsoX-BzWj1pBFg8k6seDBMmwqC9Gm3sg1hz3@mail.gmail.com>
References: <878w7ieu4p.fsf@thor.thematica.it>
	 <4BF12C96.9030802@drmicha.warpmail.net>
	 <buofx1qhgum.fsf@dhlpc061.dev.necel.com>
	 <4BF14500.30806@drmicha.warpmail.net>
	 <87hbm6tydr.fsf@thor.thematica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Mon May 17 16:18:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE19J-0004EM-F7
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 16:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab0EQOSW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 10:18:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64732 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab0EQOSV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 10:18:21 -0400
Received: by gwaa20 with SMTP id a20so482389gwa.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sx6KQy16LK17CCP1pA9j3n4kDLSkYZM4SLR72CpR7A4=;
        b=UnYQRjCxQbof3LDHe2TSLW48DVYjWgrhFUeantP6QrKaIaKIl2i+PDsQHY8E7hCJP6
         4Alfh8S5CMb+DbzlTEwnvXPKafXJS9lDliXNPkvymgVSKOO1ovnW0R5qbpYhoT2X/H6k
         3IYkJDSiuroo16rjHr+S2R+39dXy+sPD2yxVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Po8q3Dpnb14rjAwuZvdXdPB4SxA2U+aA+fb7styi5IUFGkgMjsmRyCU1YvvLmV0/hd
         USIu5urI9DK9iZ7io+qwyp6QHGNsN6uT6ozLO9G8mD6eBLdSXPlZQVxG+66aT/TpYHad
         p2btYqpZ9TU/ML44FLPCJZWQ/qlXZJJHKeWhE=
Received: by 10.231.79.131 with SMTP id p3mr246258ibk.27.1274105483125; Mon, 
	17 May 2010 07:11:23 -0700 (PDT)
Received: by 10.231.13.194 with HTTP; Mon, 17 May 2010 07:11:22 -0700 (PDT)
In-Reply-To: <87hbm6tydr.fsf@thor.thematica.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147239>

On Mon, May 17, 2010 at 10:07 PM, Giuseppe Scrivano <gscrivano@gnu.org>=
 wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Well sure it is, just as I wrote. So do you suggest that the file ha=
ndle
>> should depend on the use case? Care to implement?
>
> Thanks for your comments. =A0I will fix my patch accordingly and rese=
nd it.

While you're at it, please take a look at

  http://github.com/git/git/blob/master/Documentation/SubmittingPatches

for your next re-send.

--=20
Cheers,
Ray Chuan
