From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion v2
Date: Sun, 24 Jul 2011 15:41:38 +0530
Message-ID: <CALkWK0mXFkAW6dy=aAoWuJp90LshxnWap6PvzE2yOk6YuNJE3g@mail.gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com> <7v62mx967w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 12:12:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkvfK-0001Gd-DV
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 12:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab1GXKMB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 06:12:01 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:63352 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1GXKL7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 06:11:59 -0400
Received: by wwg11 with SMTP id 11so706767wwg.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=etyZOoHXvU6F70AdVJJUN200tQ4up6g1+Ae3xY4twVE=;
        b=xsSphfegYkbAcljuVtiVYlojSRXq7u3XXEP4v2UgVrNEje4Y5F4nE89E5P8ZxnIeDe
         J+xyoTVO3TKtwmTODu4w7lzwLVNbxVljsvg/WE0g7Ki0M26UPb7FNnqIjiJkRC2tisJ6
         i9QhgnGYxNy5BoTikYOCkgmGrN0BMtUlRVB0o=
Received: by 10.216.155.134 with SMTP id j6mr2982795wek.81.1311502318124; Sun,
 24 Jul 2011 03:11:58 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Sun, 24 Jul 2011 03:11:38 -0700 (PDT)
In-Reply-To: <7v62mx967w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177736>

Hi Junio et al,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> Mid-term is over, and I'm disappointed that I'm behind schedule -- I
>> haven't been able to get the Sequencer merged yet. =C2=A0The reviews=
 have
>> been incessant as ever, and I spend most of my time chipping
>> everything to prefection. =C2=A0On a positive note, the series looks=
 like a
>> beautiful work of art now; I never imagined that it could be this
>> beautiful :)
>
> Applying these to the same base commit as the previous series was que=
ued
> and comparing the result does show this round is indeed nicer. Haven'=
t
> started nitpicking the log messages, though ;-)

Apart from the config.c patch, and the "Please, " nit (both of which
I've corrected now), this series seems to be more-or-less ready.  I'll
re-post this series with these two details corrected for your
convenience shortly.  I've started building my post mid-term work on
top of it -- if some other minor details come up before it gets
merged, I can rebase quickly and continue.

Thanks.

-- Ram
