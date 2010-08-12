From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 15
Date: Thu, 12 Aug 2010 07:46:23 -0500
Message-ID: <AANLkTinZ22fjSDyQqz=ht2mZNCW01BarY6y=QSYtaCk9@mail.gmail.com>
References: <20100812063145.GB3311@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 14:47:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjXBe-0003Hn-Ce
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 14:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793Ab0HLMqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 08:46:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47084 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933743Ab0HLMqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 08:46:45 -0400
Received: by gwb20 with SMTP id 20so382012gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8FGZOt+DpnnOmZLZdCJQCfMNdMvV0IFkvprkQwugAks=;
        b=ePuC6onoUri3Bur6KFIPE94X+0GWWyAVnnZ2xhwXyCeb+2FZbksoMOOdMpXtvA1T8m
         /gXC5Y5k4Dn/K5DEV5zcSLirYlJosz3yXYdFmtAjjaobhzKyi1hO/C3UrDz+BaUzHot/
         cFS4s2+VuBlCFz7trDP9dASRIzmhLNJeGbIdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZFpJqPro9UqG/gnWcIk8qWvejd9v4bIUSN4zczHaTAznfFTNj6Ces6jriXzM5yOC/z
         dhn5g/ZMwQQnRnLQFxiKj2s4FUg0AkszG6O3hFx/wWYYdfo/5dJz3Nv86cBKNRk+NOHs
         cuQyhi06q41pnmvd1sjkQFKqkcOorWAJqBRXU=
Received: by 10.150.11.12 with SMTP id 12mr217471ybk.213.1281617203707; Thu,
 12 Aug 2010 05:46:43 -0700 (PDT)
Received: by 10.151.46.3 with HTTP; Thu, 12 Aug 2010 05:46:23 -0700 (PDT)
In-Reply-To: <20100812063145.GB3311@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153371>

Heya,

On Thu, Aug 12, 2010 at 01:31, Ramkumar Ramachandra <artagnon@gmail.com=
> wrote:
> Thanks for reading. Oh, and do tell me if there's anything in
> particular you'd like to see in that large final GSoC update email.

I think it's good to have a detailed description of all the work
you've done so far, how all the parts interact, what needs doing, who
is going to be doing that, and when.

> * It'll look the the ending credits in a movie with tons of people to
> =C2=A0thank. Everyone wants to skip it, but is made to go through it =
all
> =C2=A0the same :)

Ha! Looking forward to that :P.

--=20
Cheers,

Sverre Rabbelier
