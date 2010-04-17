From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Sun, 18 Apr 2010 00:07:16 +0200
Message-ID: <n2kfabb9a1e1004171507r3f51d18bq3ff60831370f9b10@mail.gmail.com>
References: <cover.1271432034.git.grubba@grubba.org> <874ojbqnry.fsf@jondo.cante.net> 
	<86ljcnclvu.fsf@red.stonehenge.com> <87eiid6fjc.fsf@jondo.cante.net> 
	<86eiidan59.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 00:07:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3GB9-00049A-VS
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 00:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0DQWHi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 18:07:38 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:58947 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab0DQWHi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Apr 2010 18:07:38 -0400
Received: by bwz25 with SMTP id 25so4264953bwz.28
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=usxIePb0v5yh8tGBBOY77Yuidddqq+y8w3+uG2xWxVQ=;
        b=rlyTdS4XQiElteAbFPTvi+TW3VGWJW5Kz+Ltn5oP/4L/JFNtSdYbpmdFBttNU3049c
         87yJrOUbLSgPK4SE2ih4PtB4e5euuCWUy2+HhbHpsOdlUJkyIDKPxBaYggf9k04gKMPB
         dP6jAkFyW8wsE4XzT/OMjlazEyh0QBx5tDEnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KIesUzMe4csulP5mSJ9ziAOY936XjLc3KJR8rhDal5CIxvJko+apPkWgjJuhBB1pxb
         DVdJauFJ1Nv8HdOcrWWZZwmU0yV/2GatTgJk44mKWKP8HoysQ6TdzCqT5uubn1EO5ZUB
         0f1rKFlhUy4E1Io8Fgm9RYno3mSOWSnSDKLlA=
Received: by 10.103.168.14 with HTTP; Sat, 17 Apr 2010 15:07:16 -0700 (PDT)
In-Reply-To: <86eiidan59.fsf@red.stonehenge.com>
Received: by 10.102.237.8 with SMTP id k8mr2227214muh.41.1271542056124; Sat, 
	17 Apr 2010 15:07:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145186>

Heya,

On Sat, Apr 17, 2010 at 21:34, Randal L. Schwartz <merlyn@stonehenge.co=
m> wrote:
> Yes, once it's already *in* the program. =C2=A0But I bet you had to *=
look
> them up* to add them.

Yes, but once they're there nobody has to look them up. It's moving
the problem from having to look up what it means on _and_ write, to
just write.

--=20
Cheers,

Sverre Rabbelier
