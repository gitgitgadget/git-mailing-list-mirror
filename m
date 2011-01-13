From: David Borowitz <dave@bwitz.com>
Subject: Re: HTTP push not respecting .netrc
Date: Wed, 12 Jan 2011 16:48:12 -0800
Message-ID: <AANLkTik4v3Gf48RtqQtqNt5ocdCuqSZqPpBzx4RifyEp@mail.gmail.com>
References: <AANLkTik84-zRwi+0dGGFoTUrj6Zr3bxO=fE9P_3MuZdZ@mail.gmail.com>
 <AANLkTi=4cE711TtqE0E-05s9Pk72C8OymNf_-5NhrfXS@mail.gmail.com> <7vy66p1vn3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 01:48:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdBMo-0005ba-4y
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 01:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353Ab1AMAsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 19:48:35 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59139 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319Ab1AMAsd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jan 2011 19:48:33 -0500
Received: by wyb28 with SMTP id 28so1197144wyb.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 16:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dDeDA2KKAkbWCRfZHsuTnPk4vxEwegpy+x+CMwOiS40=;
        b=FtJwgmsZ96oXLg7rd8lqjjzHrm2KNzWUf1W4Gs8FkNdcSw9Gs9TiElhUOBFD9Yqjwm
         IKAnitR2ot3HvZ3BqYsWYBa8AjjLoSveYozFZ8h6KWlcLmpFyMa1bKVCFYRRU3hXMNfY
         gBsCqW/9c50fCK3Seu4RI9EImHxQSO/TLqkCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=uZzefajjsN6b3tsMTboVMhC0JtJTuLZT9vp1icR0FC0lOCsaRPVSf/ghpwQ8AdMOMb
         KDdJt29bV8+JFY8a6Yfz6DXT9nJpbpWoa/LHSbXD7GwkQkNEXm0WLAu4hKbwUkNxZ/Fn
         rvY8iVuDawkNeUwksEWdN6Qe/aTeoXtwQJwtg=
Received: by 10.216.27.202 with SMTP id e52mr1379358wea.75.1294879712264; Wed,
 12 Jan 2011 16:48:32 -0800 (PST)
Received: by 10.216.79.6 with HTTP; Wed, 12 Jan 2011 16:48:12 -0800 (PST)
In-Reply-To: <7vy66p1vn3.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: lXYyqqrD3c18T1hHvRItALKNxN8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165030>

On Wed, Jan 12, 2011 at 16:42, Junio C Hamano <gitster@pobox.com> wrote=
:
> Has this been resolved to satisfaction? =A0Just being curious...

I went on vacation, came back, and it magically worked (or maybe I
typed something else); you know how these things can be. I'll
definitely use those tips and respond on this thread if it happens
again.
