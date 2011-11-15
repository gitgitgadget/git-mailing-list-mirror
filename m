From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Git, Parrot, Perl6, Rakudo for G4 MAC
Date: Tue, 15 Nov 2011 09:51:00 -0800
Message-ID: <CAE1pOi0fqzoz+Af8PaSORuW45UqDAEmqtKW3w4qYH-275BdUzw@mail.gmail.com>
References: <loom.20111115T112500-386@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Greg <greggallen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:51:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQNA4-0005KT-FG
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062Ab1KORvD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 12:51:03 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51335 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab1KORvB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 12:51:01 -0500
Received: by ywt32 with SMTP id 32so3732453ywt.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6aiI7T3+CytGWSsxs3O3OYFx/fNmWjKCyuFgo133VlU=;
        b=siAHA/uzhWsrLE9aU54EvcclrUkT0/NokeJ3fr9Q66VW0sHn+J68tZQt7FTLbh49Pb
         P4d4iDoirHq+Cl0LYCGHR7tmxXQbuzaB4jN0+3wVbOC4qpFe0shtweceI8KWslSeOBT7
         zoxda1nE92i0DMpjBeMYw5075vPCM4T4ZIqTc=
Received: by 10.101.118.3 with SMTP id v3mr8420130anm.4.1321379461031; Tue, 15
 Nov 2011 09:51:01 -0800 (PST)
Received: by 10.236.61.41 with HTTP; Tue, 15 Nov 2011 09:51:00 -0800 (PST)
In-Reply-To: <loom.20111115T112500-386@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185476>

On 15 November 2011 02:36, Greg <greggallen@gmail.com> wrote:
> Could someone please assist me in locating the resources to "GIT"
> =C2=A0this stuff going on a G4 MAC PPC? =C2=A0I
> keep getting weird bugs.
> Need me to be more explicit? =C2=A0Ok - it says gcc v3.3 isn't compat=
ible, and a
> bunch of other sheet!

GCC 3.3 is from May 2003, I suggest you upgrade to a more recent GCC
(probably 4.6).

> I already have Perl5.10.1 working fine, and performing
> numerous marvelous tasks, so I (perhaps
> mistakenly) thought it would be an easy addition.

Perl 5.10.1 is from August 2009. Presumably less of a problem but,
again, you should probably upgrade to something more recent.

(Please note that I don't know the minimum requirements in this regard
for Git. It's just that your tools are old to ancient. :-) )
