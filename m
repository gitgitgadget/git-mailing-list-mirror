From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Fri, 19 Apr 2013 20:29:12 -0500
Message-ID: <CAMP44s2dWNO2bcwzW=t5QEgQBNTEpBguwVUdkoFb6puhKV_3Yw@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<CABURp0riKhJ1p+06aKMCnBiupg3LyVCky5XRcPNLyaJDTkip9Q@mail.gmail.com>
	<CAMP44s2Yb+fSWYw0S7WuS-MEjKaSsnvndFw4ryZ8_Og6ioFcTQ@mail.gmail.com>
	<CABURp0pyAEppU7JL350vKtFQu_qBJ6YbzXTud+L7eEoPByGvYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 03:29:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTMcB-00010z-T1
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 03:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965365Ab3DTB3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 21:29:15 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:62335 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965311Ab3DTB3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 21:29:14 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so209687lab.21
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=GzAefIrmDW1TWm/o8M16iyXIJnif7A4P2lgZ039coXo=;
        b=fj2AatEtapLXI0mw90jEdfyeSY17q/wbdjvMlcYphuz8l6LzIGrugBcptQBrIfIR19
         Ff/rwxNL4WB+DiUnz0e8tgBkJKKx3BDDjl0l5TySJTA9lM1Wb9lyZv9U3rzJokAYMf16
         77JyzljfIqtx4iBf5ja0OQEgRHfsg4IsEwg0G+X3Xhkv+5m7EuQG1gM5XdrTRfmDK9qD
         bPkoo9JXW3e6IUKJOTKSGa8m3fxa4YKtNhXvIXotP0dvto69SSO9/BTB9hz0gabXV2bV
         6jHhUHtzM/OAbZGpfb2dHTxCVSHrjZYtTT8Vg+SxSck6JkICYRjblCISmTWp8fcCUPMe
         4LCw==
X-Received: by 10.112.139.226 with SMTP id rb2mr8203848lbb.12.1366421352474;
 Fri, 19 Apr 2013 18:29:12 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 19 Apr 2013 18:29:12 -0700 (PDT)
In-Reply-To: <CABURp0pyAEppU7JL350vKtFQu_qBJ6YbzXTud+L7eEoPByGvYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221829>

On Fri, Apr 19, 2013 at 4:07 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Thu, Apr 18, 2013 at 7:48 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>> If something is not hypothetical, it's real, which means it actually
>> happened, but then you said you never made the claim that it did. So
>> what is it?
>
> My claim:
>
>    I bisected to a commit whose commit message helped me deduce its entirety.

What a bold claim! That changes everything! Without your valuable
input this discussion would have gone nowhere!

This claim is absolutely worthless, nobody denies that somebody at
some point in time did bisect a commit and a read it's commit message,
and claiming what nobody denies makes as much sense as fighting the
wind.

Thanks for wasting all of our times.

> Your fanciful interpretation, which I denied:
>
>   "Show me one of the instances where you hit a bisect with
>   any of the remote-hg commits mentioned above by Thomas Rast."
>
>
> I have never bisected to any commit related to remote-hg, and neither
> did I ever claim to.  I do not know where you got such a ridiculous
> qualifier as this to append to my statement.

That's *EXACTLY* the topic you replied to. Thomas Rast pointed to
remote-hg commits, I asked if he hit an actual issue that required to
look at the commit message, or such issue was hypothetical.

Then you come along and say it isn't, Well, what isn't? If it's not
the *EXACT* topic we were talking about.

>> Either it did happen, or it didn't;
>
> It did.  Where "it" is my actual claim, that I bisected to a commit
> whose commit message helped me deduce its entirety.

So "it" is absolutely unrelated to what we were talking about, and
"it" was something nobody cared about, nor did help one iota to move
the conversation forward.

Thanks, thanks a lot.

> But also, it didn't, where "it" is your preposterous interpretation of
> my interest and/or experiences with remote-hg commits.
>
> You seem only to want to argue, Felipe.  I have neither time nor
> interest in pig-wrestling, myself.

No, I don't want to argue, specially with people that either a) deny
that they argued what they argued, or b) argue with pointless obvious
claims about something that is not being discussed. Whether it's
intellectual dishonesty, or plain madness, I'm not interested.

Hitting an issue that required anybody to look at the commit messages
of the commits that Thomas Rast mentioned, is a hypothetical
situation. *Period*.

Cheers.

-- 
Felipe Contreras
