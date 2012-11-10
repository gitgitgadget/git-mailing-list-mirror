From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sun, 11 Nov 2012 00:40:09 +0100
Message-ID: <CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: =?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 00:40:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXKf5-000667-DK
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 00:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab2KJXkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 18:40:11 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61131 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab2KJXkK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 18:40:10 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5188127obb.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 15:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Qe8zbI/ofsA9xy/8hVLhEOJrEtEF9nuOF6osMwcIigI=;
        b=i8+GhYwGmximS+Dfm3ixmt66Q71k898hy3eev+qoKoe8ODDMcvjZfnSRnR8LuS5XOq
         BrQtvWFJNCR1UHDLjRU42rjQPXfYBZq61aNcbEyIvEJmzAWZT7hfON9e8j0UmSV78KGi
         L8k3EctCZYKExdCSFvwCPI2ecfVa55BLA0/NTxXfFBEjFaLHRj6DnNfpHuoNhTznNIiP
         QgHLB+VjnD2N5H/doDiuGnnDeCIyJxdLlePEZnwo3KWQWnXHds/XDDc1ocRGaG+FjVPR
         UxPeQN8UrMhYDhFxnGjs7pCZp8Xqo2A7pCz9qA00a8KMWrg9nscxN/G7Ixi5I/U/hEID
         oBCw==
Received: by 10.182.10.6 with SMTP id e6mr11938706obb.16.1352590809744; Sat,
 10 Nov 2012 15:40:09 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 15:40:09 -0800 (PST)
In-Reply-To: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209314>

On Sun, Nov 11, 2012 at 12:19 AM, Deniz T=C3=BCrkoglu <deniz@spotify.co=
m> wrote:

> This is my first mail to the git mailing list. I have been following
> the list for some time now and I would like to suggest moving the
> reviews out of the mailing list, for example to a gerrit instance, I
> believe it would improve the commits and the mailing list. I have a
> filter on 'PATCH', but I feel I miss some of the discussion, and
> things that I would be interested in.
>
> I have spoken to Shawn Pearce (gerrit project lead, google) and he
> said he is OK with hosting the gerrit instance.
>
> I would like to hear your thoughts on this.

Personally I think reviews on the mailing list is far superior than
any other review methods. I've even blogged about it and all the
reasons[1]. Gerrit is better than bugzilla, but it still requires a
web browser, and logging in.

I love to be able to just hit 'reply' with my favorite MUA, comment
inline, and hit send.

Cheers.

[1] http://felipec.wordpress.com/2010/01/19/why-bugzilla-sucks-for-hand=
ling-patches/

--=20
=46elipe Contreras
