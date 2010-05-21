From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking extra
Date: Fri, 21 May 2010 16:16:48 +0000
Message-ID: <AANLkTikS3CdBDvyB5yTr6lcSJrXYvpD0y4LbkvSB06oG@mail.gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 21 18:16:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUu7-0003Zi-EM
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab0EUQQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 12:16:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55377 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab0EUQQs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 12:16:48 -0400
Received: by iwn6 with SMTP id 6so1339498iwn.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EC0YwLiluyKl6eAkL21l6nt7BUOn4RYkPoIUboAJ0Rw=;
        b=K38M7BWDUEdQ+F0/eeIxMBRMgj/CIc1vduOx4sYa0eTGhq+H+yFrbS4GJuTIVBadm7
         qi8WIjm7Vg0IsowqPgLenjzXFxtr58LSW/3FH+6LMNUqitusLIwATDKDpSXN5Jz8oNDd
         fGiprVaVfRvcO+RzKjBWelh3+ABPQUXu553nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W3ADGWoNnWnJpXd1oYW77iv9uxduFkR0iUgbfSb4AwxIOGrXxE4kgQp1JUul3eJw6L
         BkwdaWzjEoCsVhDrcVVDbG4ZmvzIjdl3U7vl9/QIqT2LxzKOIXdUT+xBJ7yELXecKB9P
         IeHGAijEQxbdJdp3ancg7GDY/TNfxMg79/FC8=
Received: by 10.231.154.202 with SMTP id p10mr1753544ibw.31.1274458608124; 
	Fri, 21 May 2010 09:16:48 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 21 May 2010 09:16:48 -0700 (PDT)
In-Reply-To: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147480>

On Wed, May 19, 2010 at 14:33, Junio C Hamano <gitster@pobox.com> wrote=
:
> I am aware of the following topics, that are probably all worthy of
> inclusion at some point, but am unclear in what status their discussi=
ons
> are. =C2=A0I'd appreciate it if people can help me come up with a lis=
t of
> topics that are fully discussed, and if patch submitters of these top=
ics
> can re-send the final "to apply" copy.
> ...
> =C2=A0* (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) cvsserver updates

When I originally submitted this in 2008 you seemed to be willing to
let it go in as-is. But arguably it's better if this were to be
squashed into one patch. It's more readable, but some history will be
destroyed along the way.

I don't care either way, but I can submit it in squashed form on
request.

Thanks.
