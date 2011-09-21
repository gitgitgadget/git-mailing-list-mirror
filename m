From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: mac osx
Date: Wed, 21 Sep 2011 11:44:36 +0200
Message-ID: <CAGdFq_hVy9Jsih6MiOYhQHsfnG-bSfV1zi+NY1iF8z0ruBc4Ng@mail.gmail.com>
References: <loom.20110921T002437-246@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: tom smitts <tomsmitts@ymail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 11:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6JMq-0001eO-7s
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 11:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab1IUJpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 05:45:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41013 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab1IUJpR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 05:45:17 -0400
Received: by ywb5 with SMTP id 5so984346ywb.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=xqRMNVKKWE1UJ1b4VGu4yw/ysgOk4ZDdkJOg/e5yBCk=;
        b=c3unbE09X/neLd9D2yns/lBPB44mMqJVDwWfbcxoujGjT3BTBb2beCObCPRpsVndk4
         59CBlNsrxPbpwb4d/DpzjsszY8Bkl4U/sTDDuljSWZXu7+SHHUTCnfuxD9PSDzWPxD8u
         WZLPtm3Z1yFoo7zWpPoOsVUBeqnqE/PE82V1w=
Received: by 10.68.59.102 with SMTP id y6mr1188382pbq.220.1316598316115; Wed,
 21 Sep 2011 02:45:16 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Wed, 21 Sep 2011 02:44:36 -0700 (PDT)
In-Reply-To: <loom.20110921T002437-246@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181834>

Heya,

[bcc: git list, let's take this off-list, but I do want the record to
show that I do not think this is the way we should communicate on this
list]

On Wed, Sep 21, 2011 at 00:40, tom smitts <tomsmitts@ymail.com> wrote:
> Do the git maintainers really think any mac users have
> =C2=A0a clue which git install package to download? =C2=A0You
> put some arcane chipset designation in the package
> =C2=A0name! =C2=A0Why make mac installers at all? =C2=A0Mac users
> know their operating system number, e.g. 10.6.7,
> and that's all. =C2=A0I doubt Windows users know any better.
> And I doubt you can find anywhere on a mac that says
> =C2=A0i386 or whatever the heck the other dumb
> designation is.

What value does writing your email in this way add? Wouldn't it be
much more productive if instead you had written something like this:

> Hi, I noticed that the mac installers (found here [0]) include a
> chipset designation (such as i386 or x86_64). In my experience,
> Mac users (as well as Windows users) are not familiar with these
> terms, and will not know which to choose. It would perhaps be
> better to rename the package to have a 32bit or 64bit suffix instead,
> which  these users are more likely to know.
> If this is the wrong place to report this issue, please feel free to
> forward this to the appropriate person.
>
> Thanks
>
> http://code.google.com/p/git-osx-installer/downloads/list

As you can see it's about as long as your reply, but a lot less
aggressive. It conveys the same information (the current package
naming is sub-optimal), but does so in a much friendlier way.

--=20
Cheers,

Sverre Rabbelier
