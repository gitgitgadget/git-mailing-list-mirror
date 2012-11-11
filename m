From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sun, 11 Nov 2012 12:56:48 +0530
Message-ID: <CALkWK0mpzc8jXs5=HhO0Bk78UgwKt+JGOThB6z_4AnEYmz_=+w@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: =?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 08:27:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXRxO-0007YZ-Ry
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 08:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab2KKH1L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 02:27:11 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:54685 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2KKH1K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 02:27:10 -0500
Received: by mail-wi0-f170.google.com with SMTP id hm9so1540853wib.1
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 23:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ljuaCEPASSrqL4Szqa+qqtPUZbEYkliGMdZ8pcg1VzU=;
        b=Ls4g1+AAAn74AwEv8Mr1DxErxYT2SIhVZPGLoOaHlXuNVTysBKD85T6Vrm/lbUjdqk
         r1LEeYRBMFFWSNnAEba6HrGxPzzfk8Lks72OjFUzZ5gRKe3tLPGMRoCNJsKo7lOazspY
         wQG2Pefq/YKDEpD4JkUDN+8nmoEN4Dmv+hlSyT0MzkkV3JpfGxs8C4g06HVNj9UKMC6I
         vBTNKvaSGSdkA9Iz12tonInUVIZWK161uUBL6F5hJUVi3OxUC8hZZXn2CJeUznxp+K88
         ezRcQCLxzy/D2uoQGuR2HlqMX0SAC4SeAIVZPFHYpYKMhBKDBF/UmykeTnPvjKfNiL92
         BsQQ==
Received: by 10.180.95.201 with SMTP id dm9mr9838889wib.3.1352618828686; Sat,
 10 Nov 2012 23:27:08 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sat, 10 Nov 2012 23:26:48 -0800 (PST)
In-Reply-To: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209326>

Deniz T=C3=BCrkoglu wrote:
> I have spoken to Shawn Pearce (gerrit project lead, google) and he
> said he is OK with hosting the gerrit instance.
>
> I would like to hear your thoughts on this.

I personally think email is by far the best interface for patches,
reviews, and discussions.  Git patches are very high-volume, and not
everyone can read everything.  People should have the flexibility to
choose the client they'd like to use to read patches and follow-ups;
the freedom to use a scriptable client like Gnus is very important to
me. Primarily, I want people to be able to:
1. Choose what to read, by scripting Gnus to score email that they'd
likely find relevant.
2. Try out new patches on the list, by assigning one keybinding to
git-am a series.
3. Display email the way they like.  Many email clients have features
to run filters through emails.
4. Read patches/ follow-ups offline, while travelling (on a phone, for
instance).  The GMail app, for instance, downloads mails for offline
viewing.
5. Interact with other lists seamlessly (the kernel list, for
instance).  Email is a universal interface on which lists can be CC'ed
easily.

I'm not attacking a specific web interface, but I don't see how any of
the following would be possible even with the most advanced web
interface.  Besides, nobody has made a proper case for using one.
Therefore, I'm strongly opposed to the move.

Ram
