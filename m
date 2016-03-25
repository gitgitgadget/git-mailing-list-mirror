From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] Proposal
Date: Fri, 25 Mar 2016 12:42:39 +0800
Message-ID: <CAKqreuwFbObbMf_Lc6Lc01zrdGZf2qCTwgeD+db_CwebS_iDrg@mail.gmail.com>
References: <CAKqreuwbGC1=42V2ZnTj53z76sgGcqfzjjrD7SP2AeuHJo9etQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 05:42:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajJaA-0006cM-0v
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 05:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbcCYEml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 00:42:41 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35412 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcCYEmk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 00:42:40 -0400
Received: by mail-oi0-f54.google.com with SMTP id h6so30838003oia.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 21:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=lEPAf8halqp6UpOcW6AwxE7R8GBjyApvLCfhtEpY7qA=;
        b=0o1YRKl78MYwb1SEWoJzOkqRNXR70cRwf/0e0x7DZ6UaJnVjUpTXQlKAqTW2GbjxSv
         Pb2P3T3ZeVuDvBv/WvZFl/UUt/OwTLYyQkI/DImznDBJVp4OAvfAxB4dS7YbukBOwvxQ
         CMXwg48ALsBu3o9sfPezWpF3JCqLrWLtOlnP5S1BAcJUKvChhin+UYeTlu+8iEyrCg5j
         dAlTjuG0XOTJ4EBuwTHxUuZ7McQdeDYY4eOt54i4qSVKUMOhmS3GBC0dnl7VZWq2RmVG
         01wePum9kG8W+TZDDXuD+e8e4ph1pvDzsuBHaRdoujn2bE5uvSM9JLzx0sGp6LXxsFu1
         mIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-transfer-encoding;
        bh=lEPAf8halqp6UpOcW6AwxE7R8GBjyApvLCfhtEpY7qA=;
        b=Pkju1MZqAu9G5IJHg7tLndsjsonatkCSGY+EBzri1tonkPTGSeptgfxZuoJCKGuPPp
         CYPmJO9BA3nGzIaAU+cLEt27gClWWTm0WG9kZmscBcPsD8qgxL/ApMiyVz08LgWkksi6
         96/SgdhLBfEyollgMSBUbQjkl9/rEJjkl3r+2J1jSk4s3OBtKbw2Aw44P/5CFa2Svgrn
         4OuexGSRyWCGex/g7S6F7OGiU4H+0AUqDHnW2q7ZA5LY6v8toKoGil070IvDF+Vr2pNj
         P2XQf0MpDhmGyAb5eD+Xyuv2AQnmVIoPI8TlYV5aBpmR8RclkTDyTLoEBipah1LRzzQQ
         biUA==
X-Gm-Message-State: AD7BkJKKXoXJw8Y/AkrPVKausnAQYMAqEsra5o2uRLlFiwYW47xsADvBgS6rbNVMpI/5HWxWZG+JwiDdRK9XPw==
X-Received: by 10.157.49.116 with SMTP id v49mr6268280otd.97.1458880959455;
 Thu, 24 Mar 2016 21:42:39 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Thu, 24 Mar 2016 21:42:39 -0700 (PDT)
In-Reply-To: <CAKqreuwbGC1=42V2ZnTj53z76sgGcqfzjjrD7SP2AeuHJo9etQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289845>

There is an interesting idea as an idea for GSoC of 2008, is it still
proposable?

https://git.wiki.kernel.org/index.php/SoC2008Ideas#Restartable_Clone

2016-03-25 11:45 GMT+08:00 =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.=
com>:
> Hi,
>
> I'm proposing to take part in GSoC as a developer of git.
>
> Here is my [Draft](https://docs.google.com/document/d/1zqOVb_cnYcaix4=
8ep1KNPeLpRHvNKA26kNXc78yjhMg/edit?usp=3Dsharing).
>
> I'm planning to refactor some part of git. Following is what I'm inte=
rested in:
>
> - port parts of =E2=80=9Cgit rebase=E2=80=9D to a C helper
> - =E2=80=9Cgit status=E2=80=9D during non-interactive rebase
> - etc interesting during the development
>
> If time allow, I'd like to also improve git-bisect, for example:
>
> - convert =E2=80=9Cgit-bisect.sh=E2=80=9D to a builtin
> - etc
>
> Sorry for toooo late. I was so busy these days. sorry again.
