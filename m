From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question 
	about announcing it
Date: Sun, 5 Jul 2009 22:15:54 +0300
Message-ID: <94a0d4530907051215h755f634bkfd043d88289df29e@mail.gmail.com>
References: <200907030130.24417.jnareb@gmail.com>
	 <94a0d4530907031619x3d1296eenf9198b4ab5e43f67@mail.gmail.com>
	 <200907050040.21991.jnareb@gmail.com>
	 <94a0d4530907041653n46c082e2ta5141e917f5bd84f@mail.gmail.com>
	 <7vprcfj83z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 21:16:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNXBz-000644-G7
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 21:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbZGETPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2009 15:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbZGETPw
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 15:15:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:12415 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZGETPw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 15:15:52 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1073073fga.17
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zcP48+rkjiVJuTiXrJxcVkV3RhyeKO1PVcrT7TBmk9k=;
        b=gWShftOihaGUQsBa7JyacyTFspr47HgmO2djAQJLAGdd+nFhnqMM4kkVjbJDkxLGi7
         9wdotPIHw2mk8WWFKV3xIZMCVM/JPgsAqdEWrCOQN6rEY682/QbiUNlcDSWmyRP9tchD
         bBdts91iag02sWe+/thmT55BJiH1ppDsODQVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pUIblSnGnDIHSOBzL0Ht1C43fNkbKUxDB/aCDIbInR2R14Xx1EWCVI13s3UbUjJuU9
         xKBzIh4AjltZEDQhd1ebfhuYiafCcbIvhfZgbyVTDIXW6wPgZJrSBNVQ7OkjbnuqnefK
         4CV0N8/uFaOl6PbYpPV/zt5P/jXOJYR/ip4jA=
Received: by 10.86.92.13 with SMTP id p13mr1767883fgb.43.1246821354968; Sun, 
	05 Jul 2009 12:15:54 -0700 (PDT)
In-Reply-To: <7vprcfj83z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122750>

On Sun, Jul 5, 2009 at 9:30 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I guess Junio's blog is the most official one ATM,...
>
> Sorry, don't.
>
> =C2=A0- Even if you are pretending to be a git community member, you =
are merely
> =C2=A0 a phoney if you are not reading it.
>
> =C2=A0- If you want to be up-to-date with what is happening in the co=
mmunity,
> =C2=A0 you should be reading it. =C2=A0Any important announcement alw=
ays will
> =C2=A0 appear there.
>
> That would be an official blog. =C2=A0I do not use mine that way, and=
 nobody
> has to follow it in order to function better in the git land.
>
> It's like expecting Linus to announce the kernel release in his blog.
>
> Not going to happen. =C2=A0The official channel of this community has=
 always
> been this list.
>
> I'm OK if somebody declares that he will use his blog to relay import=
ant
> announcements from this list, to help blog minded people to follow it
> instead of reading the list.
>
> But that won't be me.

I know there's no official git blog, I've tried to change that, but so
far that hasn't happened. IMHO for now the most popular git blog(s)
should announce the survey, I'll announce it at gitlog.wordpress.com
but it is far from being popular.

I understand your position for not making your personal blog the
official one; I wouldn't do that on my personal blog either
(felipec.wordpress.com) that's why I created a separate blog for that,
where you, or anyone else, can do official git posts instead of on
their personal blog.

Cheers.

--=20
=46elipe Contreras
