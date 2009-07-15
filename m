From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: More 'shortlog' statistics models?
Date: Wed, 15 Jul 2009 10:56:13 -0700
Message-ID: <fabb9a1e0907151056q61f73957yd7dda7a199914af7@mail.gmail.com>
References: <alpine.LFD.2.01.0907141852400.13838@localhost.localdomain> 
	<7v8wiqfj60.fsf@alter.siamese.dyndns.org> <m363duukvb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 19:56:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR8ij-0002Sp-Rh
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 19:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbZGOR4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 13:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbZGOR4h
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 13:56:37 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:59718 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbZGOR4g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 13:56:36 -0400
Received: by ewy26 with SMTP id 26so4238656ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zZWDcObxn1l5kyyhmamFsxJZRPzckzzcq+P29PKwzr8=;
        b=epXcCOEBgFe5brBgkEavp61tgAJZHAZST0IHQzu4zm5+uxFt/gNQYjAj7EE9DBqyHO
         g130fanpZzuh7nM8uWVaH0dFC+L1Yqt/u2wmfCzIb+F7rWLwykEYe1WYcKfrKCk36tka
         7DPwtX/ARUsUb+IZc8uiT0UAOsa52r6fBTdnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sQScBQgWuDVqrnMtsSpkVSPTl5cCTdi97ZgtVe4VlCq899kd57I4O23M4Ml8wLhYr/
         jRtbKXhdRjfTQ9XAOwjBsIb+rVTMYk3bhvLsstt/BrprQOJIEQKTnHkTc6o1Q6y5NY8s
         +FJkqNbQHaq1KJJJMWvPT5H5KVk4bVxiHCZ8I=
Received: by 10.216.72.206 with SMTP id t56mr2115108wed.31.1247680593128; Wed, 
	15 Jul 2009 10:56:33 -0700 (PDT)
In-Reply-To: <m363duukvb.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123329>

Heya,

[message not culled as I suspect Jakub's reply didn't make the git list=
]

On Wed, Jul 15, 2009 at 06:38, Jakub Narebski<jnareb@gmail.com> wrote:
>> Wasn't one of the GSoC project about git statistics? =A0Or was it a =
topic of
>> last year?

That would be me indeed, as Jakub said :).

> It was topic of last year GSoC, see http://git.or.cz/gitwiki/SoC2008P=
rojects
> It was decided[1] that it would be better for it to remain separate
> from git (for support for other SCMs).
>
> =A0http://repo.or.cz/w/git-stats.git
>
> CC-ed Sverre Rabellier (student for this git-statistic project)
>
> [1]: http://permalink.gmane.org/gmane.comp.version-control.git/90691
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git

Not sure what happened but you addressed me (and my old address at
that) and the git list in one line, not seperated by a comma. Thanks
for the plug regardless :).

--=20
Cheers,

Sverre Rabbelier
