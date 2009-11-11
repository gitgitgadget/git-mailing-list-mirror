From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: gitk : french translation
Date: Wed, 11 Nov 2009 02:10:15 +0100
Message-ID: <9f50533b0911101710q2f1ed9a4i7b682988a0983ef8@mail.gmail.com>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com>
	 <9f50533b0911101005j4839bd93ld69edfa94241c755@mail.gmail.com>
	 <20091110204742.GA27518@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Guy Brand <gb@unistra.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Nov 11 02:10:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N81j8-0002TW-4q
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 02:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960AbZKKBKM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 20:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbZKKBKM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 20:10:12 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:47198 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473AbZKKBKL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 20:10:11 -0500
Received: by ewy3 with SMTP id 3so691039ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ut6IucZ47xLDzAqvXb/IEzVwmj1+T+dXh/uvAgZdFA8=;
        b=wcfcjJ1nevFrfd22OxCG/M3EcjNJYE2hbM/HKmmpi9U6Qlx5zN8p123vQvRrGvEOeD
         mwcrrYFR/uOlG+j0GXjO9fhy4iVF3FJ3m2MTcQXL2iWROeAvzS6HREind0KepMWlYmHa
         ZammaqZAWbdvBNgUgWU1rMJ2J5hSMTOHlx2TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MEJL7Ba2JVjd2vkpWrA9bDu0eazCOucudn21okp7hn0sc13lr90kSBavptO5OHQpp0
         qWDPKrzJNlp3r8ImSgj+5p5bWHGH03CU/c/XY1P5/sRYN2dTQdHl1Pkv3CtXEhPpoEZu
         cCBbjjaKjWl+pqgX6Z9m9i2IH1arcCyy0H7Rc=
Received: by 10.216.90.18 with SMTP id d18mr240008wef.225.1257901815940; Tue, 
	10 Nov 2009 17:10:15 -0800 (PST)
In-Reply-To: <20091110204742.GA27518@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132606>

2009/11/10 Nicolas Sebrecht <nicolas.s.dev@gmx.fr>:
>> commiter : auteur du commit : commiteur
>
> Why not "commiteur" for gitk too?
It's ok for me.
>> Check out : R=C3=A9cup=C3=A9rer : charger
>> to cherry-pick : Ceuillir
>> Diff : Diff=C3=A9rence : Diff
>
> See comment at the end.
>
>> Soft (Reset) : Douce :
>
> L=C3=A9ger ?
Souds better. I will make the change, except if someone has a better
proposal.

>> I prefer to translate "Diff" by "Diff=C3=A9rences" _especially_ when=
 we are
>> talking about the action of making a "diff"
>
> You don't explain _why_. We had 3 points in favour of the "diff" term=
 in
> french in this thread (keep Git's commands consistency, rough
> translation and english word more used even by french people as for
> "patch"). I have another argument to use "diff" now: keep consistency
> with 'git gui'.
I see now that I have no good reasons to prefer "Diff=C3=A9rences".

>> translation of "cherry-pick". For this one we could use "<translatio=
n>
>> (<english-word>) ..." as suggest previously.
>
> I'm fine here.

Thanks for your comments.

Emmanuel Trillaud
