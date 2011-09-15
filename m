From: Joshua Stoutenburg <jehoshua02@gmail.com>
Subject: Re: Anybody home?
Date: Wed, 14 Sep 2011 22:04:56 -0700
Message-ID: <CAOZxsTrsi5mNdm8OgvfXyYwj1T4Vw3HfQGN-5Dsb+QnX0nz4ag@mail.gmail.com>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
	<CAMOZ1BtpzsxGLzrZs2YbNP174mm3vfLCteencKSepDR329jjBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 07:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R449z-0000NU-Iz
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 07:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab1IOFE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 01:04:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54203 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab1IOFE5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 01:04:57 -0400
Received: by eya28 with SMTP id 28so167611eya.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 22:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hs0WNh34zui+8eqJg2J5Lic2FEyVRW2UjyLazufPTb0=;
        b=eMmPrQ/SwCOwjuIu4kuG7BHepnzdX0Gzy/PQy42V0uQBLWaG+9U9c1ZEu1MlpIfD3h
         WRBNMzEu+bby0+2AHqRfLHcM8ZzFeOoPnWZPm11LDrBRbSSKc5aqPJNV96lxuBe5pgKO
         TfHZAxFe6mKmXmk8cDmvOPD2iTa1hZmuIsSJI=
Received: by 10.213.16.141 with SMTP id o13mr259268eba.91.1316063096252; Wed,
 14 Sep 2011 22:04:56 -0700 (PDT)
Received: by 10.213.16.195 with HTTP; Wed, 14 Sep 2011 22:04:56 -0700 (PDT)
In-Reply-To: <CAMOZ1BtpzsxGLzrZs2YbNP174mm3vfLCteencKSepDR329jjBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181438>

On Wed, Sep 14, 2011 at 9:48 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Thu, Sep 15, 2011 at 04:24, Joshua Stoutenburg <jehoshua02@gmail.c=
om> wrote:
>> Hey guys, I'm pretty stoked about git -- coming from subversion.
>>
>> I'm having a hard time understanding clearly how to set up a git
>> server and configure my local machine to pull and push to it.
>>
>> I've been reading the git book pdf. =A0But I think I must have misse=
d
>> something. =A0I feel stranded.
>>
>> Any help appreciated. =A0Many thanks.
>
> Could you please ask a specific question about a specific issue of co=
nfusion?
>

There seems to be a plethora of documentation on git from various sourc=
es.

See what I mean:
    http://git-scm.com/documentation
    http://progit.org/book/
    http://gitref.org/
    http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
    http://www.kernel.org/pub/software/scm/git/docs/everyday.html
    http://git-scm.com/course/svn.html
    http://hoth.entp.com/output/git_for_designers.html
    http://eagain.net/articles/git-for-computer-scientists/
    http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
    http://www-cs-students.stanford.edu/~blynn/gitmagic/
    http://help.github.com/
    http://www.kernel.org/pub/software/scm/git/docs/
    http://refcardz.dzone.com/refcardz/getting-started-git

Which source makes the least amount of assumptions and offers all the
juicy details for configuring git on the server, and git on the local
machine, without any fluff?

I'm looking for a solid guide. Not a novel. Not a pamphlet.

Being new to git, I can't tell which source to go with.  Perhaps
someone with greater experience could point me in the right direction.

Thanks again.

--Josh
