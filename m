From: Miles Bader <miles@gnu.org>
Subject: Re: Git is exploding
Date: Sat, 29 Oct 2011 17:28:51 +0900
Message-ID: <CADCnXobzdqF3=4fac4V-ELEgD40J8zCsicGLRjh3KmSrt7kwTg@mail.gmail.com>
References: <CAA787r=jeBv9moineaJVY=urYzEX+d7n23ED-txAGhLS+OPbmg@mail.gmail.com>
 <8762j8jje9.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=D8yvind_A=2E_Holm?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Sat Oct 29 10:34:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RK4NJ-0004ws-0m
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 10:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab1J2I3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Oct 2011 04:29:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63656 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab1J2I3d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Oct 2011 04:29:33 -0400
Received: by eye27 with SMTP id 27so4087668eye.19
        for <git@vger.kernel.org>; Sat, 29 Oct 2011 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pKFjMwfnOtrjK9OsIZzu9ECzBEKB6iuSExJYg5lk/Do=;
        b=M2/u7tQIMapTBVjCW80063ETqD0VZ1krAfZ/L5HnZdYNujbowLdXA4eEL3G45Ox812
         aitJnyTMa8/aH9Ofd/QaDj2OmxYcIvZDCgYy0BFnGXNxjgoCQ1MxcilfOrxhRYUyTm1H
         B9jEUmTfNEMFMmoItT4F+oiVQxloXhOdxUwvw=
Received: by 10.14.16.5 with SMTP id g5mr577816eeg.101.1319876972196; Sat, 29
 Oct 2011 01:29:32 -0700 (PDT)
Received: by 10.14.100.76 with HTTP; Sat, 29 Oct 2011 01:28:51 -0700 (PDT)
In-Reply-To: <8762j8jje9.fsf@catnip.gol.com>
X-Google-Sender-Auth: pJqYA3WsOnP0PvlMYjUlfknw-qQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184449>

2011/10/29 Miles Bader <miles@gnu.org>:
> That the sharpness of that graph is pretty amazing though; what
> happened in 2010Q1?

Actually, now I realize what happened:  that's the date the Debian
"git-core" package was renamed "git" (the "git" package used to be
"gnu interactive tools")!!

-Miles

--=20
Cat is power. =A0Cat is peace.
