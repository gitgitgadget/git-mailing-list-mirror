From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Sun, 31 Jul 2011 16:37:58 +0300
Message-ID: <CAMP44s3y0GX6ofa6Am-ioDyf9AEjKJofsHQLU0L9P4nnQ4C+4w@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com>
	<4E2DE708.8050805@cisco.com>
	<201107261237.43140.jnareb@gmail.com>
	<4E2EAFA6.90803@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 15:38:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWDd-00039R-G5
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab1GaNiB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 09:38:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65087 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1GaNiA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 09:38:00 -0400
Received: by fxh19 with SMTP id 19so3699736fxh.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Au9iMwS42CzkXBoiE3ziIr7nERblTaIkDsTJGE6bnzI=;
        b=LNoKgfE1EaBQa5UO/2IZwg9/7mUVBqpbRJcddQgYHMsqwFJgUGQsAgY6/Fw3y3F0It
         B/LyUCv/3vVtjyv8nhnHdhW4T2+tzrVn3Pn0BPSpjldbLGylIRl4/U3HN7yoZsbgu7ii
         wDcwWgdCWBbi4LAY8kdp8Isfhyy6V+Ied9TMQ=
Received: by 10.204.144.198 with SMTP id a6mr928566bkv.87.1312119478837; Sun,
 31 Jul 2011 06:37:58 -0700 (PDT)
Received: by 10.204.56.15 with HTTP; Sun, 31 Jul 2011 06:37:58 -0700 (PDT)
In-Reply-To: <4E2EAFA6.90803@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178249>

2011/7/26 Phil Hord <hordp@cisco.com>:
> On 07/26/2011 06:37 AM, Jakub Narebski wrote:
>> On Mon, 25 Jul 2011, Phil Hord wrote:
>>
>> bridges (git-svn, hg-git, git-p4, etc.)
>> I think they are included in "two-way interaction with other SCMs",
>> but perhaps that should be made more clear.
>
> I think I just overlooked that one.
>
>>> IDE integration (Eclipse, Netbeans, etc.)
>> This isn't strictly _git_ feature, and is in "12. What kind of Git t=
ools
>> do you use?" anyway.
>>
> Yes, it's not a git feature. =C2=A0But I'm curious how successful any=
 IDE
> integration is (as opposed to a GUI, for example). =C2=A0I haven't se=
en any
> that use enough of the power of git yet, so I have been disappointed.=
 =C2=A0I
> suspect others have also, but I'm hopeful.

I also think this is important, in my blog I've seen a bunch of people
mentioning that Git's integration with IDE's is not as good as
Mercurial. Putting this in the already existing list of tools would
not cover missing IDE's being integrated, I think this should go into
"20. In your opinion, which areas in Git need improvement?"

--=20
=46elipe Contreras
