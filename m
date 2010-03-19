From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 07:59:40 -0600
Message-ID: <b4087cc51003190659h3d619fdbgc57ce343ee0527a3@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> 
	<b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com> 
	<4BA36F5F.9080706@gnu.org> <b4087cc51003190543mafc403q6260a3774653e2d5@mail.gmail.com> 
	<4BA373C0.2070506@gnu.org> <b4087cc51003190603v259b833embb40b7360a07cf1f@mail.gmail.com> 
	<4BA3776B.5040706@gnu.org> <b4087cc51003190613y2fe32c26jd27cb009e64f197c@mail.gmail.com> 
	<873DD7AF-6D5C-4F5F-BDC1-1F26480D412F@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsckK-0001l2-TX
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab0CSOAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 10:00:08 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:48686 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0CSOAB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 10:00:01 -0400
Received: by fxm19 with SMTP id 19so615504fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=B760i3JpkNreE88+iE7NnXwtKlj/ai8+MIyIet2yUOA=;
        b=Ftfl5WUWG/pvcjJJJv+RntdF7l6m5XcS3pogQZ/ZxFugWoTmv3K7ieM0ljbc42PKWi
         mfakPgreYRFwxgEGK6eqUWyIGx0O0B+60rrYiyJ45H9qA/7jlfsTiuVVvIEMcjcYTUal
         +fR6+Fls6xrIE8RFOyogGdWyIfW5Y6zJ04M0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MwMIw/KFVksBYir0osa9qA9d+2iy6Pv7ZkSGjVylgTzh/nDpjDwgsvIj+sGJ7Qg8Wx
         wJVhOAHv2w7hvga89aw/R6SKzLOcRtJjxsjJWZ9gj+wYVtOe8h7UNE4yneyIXNSjCSVV
         GCbmWal6cWD60mGMtv7ci7z1S2K8iOzwosVcU=
Received: by 10.239.192.65 with SMTP id d1mr1653495hbi.197.1269007200202; Fri, 
	19 Mar 2010 07:00:00 -0700 (PDT)
In-Reply-To: <873DD7AF-6D5C-4F5F-BDC1-1F26480D412F@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142594>

On Fri, Mar 19, 2010 at 07:41, Wincent Colaiuta <win@wincent.com> wrote=
:
> El 19/03/2010, a las 14:13, Michael Witten escribi=C3=B3:
>
>> On Fri, Mar 19, 2010 at 07:08, Paolo Bonzini <bonzini@gnu.org> wrote=
:
>>> Maybe you have to define entropy. =C2=A0For human consumers, "Paolo=
 Bonzini
>>> <pbonzini@redhat.com>" has considerably less "entropy" than
>>> 8aacc35ffca0d34fccf8a750e84e3a81bdcb940b, as does even "Paolo Bonzi=
ni
>>> <bonzini@gnu.org, pbonzini@redhat.com>". =C2=A0For non-human consum=
ers, a good
>>> mailmap will do.
>>
>> As I've stated before many times, the SHA-1 is not necessary to the =
proposal.
>>
>> Please go read.
>
> Stop telling people to go read your idiotic proposal. It has _already=
_ been read with great attention, and multiple people have shown immens=
e patience repeatedly explaining to you why the idea is stupid. Your co=
ntinued trolling is really starting to grate.

I've shown immense patience repeatedly explaining why these
'explanations' are strawmen or based on misunderstandings and bad
assumptions.

It's true that I have been receiving perfectly valid complaints. The
problem is that almost all of them have nothing to do with what I've
been saying because people see 'uuid' and a few examples with hex
digits and then erroneously construct the rest in their heads.

> The overwhelming, sustained opposition to your idea should already be=
 enough indication that such a proposal will _never_ be accepted into t=
he Git codebase, so right now you're just wasting people's time.

I long ago gave up the notion that it would be included in the git code=
base.

Instead, I've been defending the idea, which is a simple but vast
improvement over the current system; had it been in place since the
beginning, a lot of trouble could have been reduced.

Indeed, the only thing that makes this great idea a bad idea is
COMPATIBILITY CONCERNS; that's it.
