From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Applicatioin of contribution for Git Chinese version
Date: Mon, 18 Apr 2011 09:57:17 +0200
Message-ID: <BANLkTi=68WR3EB4FnnS1uq6Px2NzWt0yog@mail.gmail.com>
References: <559debc.6920e.12f5f0bdfc0.Coremail.cyrus_evans@163.com>
	<BANLkTi=29fvnLYVnsjpYXfaB20=H6D6fcg@mail.gmail.com>
	<BANLkTintJ6FsYAQ1iV1kygwOdtsFtCs3EA@mail.gmail.com>
	<m362qexgb1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Cyrus.Evans" <cyrus_evans@163.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 09:57:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBjKt-00016o-Uk
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 09:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab1DRH5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Apr 2011 03:57:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61190 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab1DRH5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2011 03:57:18 -0400
Received: by bwz15 with SMTP id 15so3594758bwz.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AdOJBxzAXD/7gad/FIhUfUXW8e1yEflTTXjjgRBdJR0=;
        b=G5APjBLdlbB0QLEDKosgvJSVEN6HzVQaSom8qQ1nKuFbFKUTfE312+6Ef0kkLQv/J3
         HpmI/wCQSaOh0q8i1oXtyEwdoJYctBBBHtB00gYXR28gM5W7r7aoHlHNr4rVEmQ/GPsO
         H8N+ZtZcTftonESBnl4Xzi5+++q7DFVE/cWco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s5iRXMSQJk4KIgz/guf8Oaessy5KTO82WhGvLVAwy5cshHjCZ342DNJstgL7M/sxze
         79H1/+nTE5PSep8ExgCfK4ABvHcIIDOQH9TgeSmAl6tAmdVHb6yhgUj3/eZNVyMBxMdq
         4kzQNPjfHJHqN/Ia+DHfeDadJS5Fe7Qor7VoY=
Received: by 10.204.20.143 with SMTP id f15mr1884043bkb.173.1303113437292;
 Mon, 18 Apr 2011 00:57:17 -0700 (PDT)
Received: by 10.204.101.132 with HTTP; Mon, 18 Apr 2011 00:57:17 -0700 (PDT)
In-Reply-To: <m362qexgb1.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171740>

On Sat, Apr 16, 2011 at 19:22, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> Translating there will work once the Launchpad people review & accep=
t
>> the POT file I uploaded. I have no idea how long that takes.
>
> Why not use Pootle?
>
> =C2=A0http://translate.sourceforge.net/wiki/

Just because I knew about Launchpad and not that.

But as far as I'm concerned these web UI's are as interchangable as
the editors people use to edit *.po files. We could just upload the
POT template to whatever people want to use, then they can submit
their *.po files for inclusion.
