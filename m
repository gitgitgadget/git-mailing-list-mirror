From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: bug report
Date: Fri, 13 May 2016 10:53:52 +0530
Message-ID: <CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
References: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 07:24:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b15Zz-0004q3-OP
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 07:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbcEMFXz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 01:23:55 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34607 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcEMFXy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 01:23:54 -0400
Received: by mail-yw0-f182.google.com with SMTP id j74so93565311ywg.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 22:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=S9bbTt8hSU5kei9DZxo+bSCzHR11ZzIii25UXGuDtA0=;
        b=q+7ao+iL5NV0jCv27vBandnI6iD3+1fuRaybubk1bKP66wguDp9kQKXXjdVcboAWoO
         MlFQvBUvXwmV9dYWtqvhbZ/JHZfQi7Im1uOlJZqtZ0OagMoBWEa2D0hrOPUc7mqpvib8
         yeW/Aup5AGUFYjqkWfDD4TlvJrqetC1hboCwbIHzbUlEMTSTICdkrTW2c42Q/RNhZgf8
         P8wm38ROw2dAXj0O/sspkr2qmJ/vRx+2BO9UwvAVK/n7CELLLM0ctghiuvFxGty5Kuka
         MuCy5GMsUd5NWvJQW9zVQ+g/Km3Vy0VnOTsH03Du0JdLiGuyAs44gFenZPoVbc5fuL1P
         XhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=S9bbTt8hSU5kei9DZxo+bSCzHR11ZzIii25UXGuDtA0=;
        b=CvncWD0YycKKGG8WQJVsLPTmlIzTCihUixu6ZcH9E5J/SQ8uN6acPCCqZ6I3Zo3T30
         8Yr3JT+h1vGhjvdIkwE8oX8lqatTY1qZ+AUAK2jhLYBWopr2x5Lna4WhZW92LSa+3MeL
         rVdOqXF/AvAVjFoyT83GBYo8IFQxIhur7DapEJXkSSWRxuWtSL68a2DJ4ppwJEqUbFCt
         RSr34rP1j9OoVTp4pDBHjaNkHfTqpduipM11usMqNLOUZwtAO7Z68B/9riBreKniY9NO
         9F9dgklAoyVSO2POBfPiRv+AeIaqqW58mg00+zZvDs9nVTom7HFdE/VqmKzJUNw8wGuE
         p2tg==
X-Gm-Message-State: AOPr4FVqXXSqCcKs8YFH+s05+SBdtWXZeKSYjRUPNIPHdR9AUeHFkEXqCiw5cFTh8KuDkYqhm3kNM1oJvwUzxw==
X-Received: by 10.13.198.5 with SMTP id i5mr7193736ywd.263.1463117033036; Thu,
 12 May 2016 22:23:53 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 12 May 2016 22:23:52 -0700 (PDT)
In-Reply-To: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294501>

Please mention the version no of git you are using and your system.
I am answering according to git 2.8.1 Lubuntu 15.04

On Fri, May 13, 2016 at 10:34 AM, =E6=9D=8E=E6=9C=AC=E8=B6=85 <libencha=
o@gmail.com> wrote:
> Hi all,
>
>       Yestoday when I worked using Git, I found a bug. It's about
> rebase. Or I don't know if it is a bug, maybe that is Git. Below is m=
y
> problem:
>
>       There is a master branch, and we develop in our own branch.
> Let's simplify this: there are two branches created at the same commi=
t
> point at master. Then branch A add a function X. Branch B add funcito=
n
> X too (yes, they are very same). Then branch B modify function X to
> function Y.

What do you mean by this? Did you amend the previous commit, or
introduced another separate commit ?

>       Branch A finishes it's job first and merged to master
> successfully and happily without any conflicts. When branch B wants t=
o
> merge to master, he finds that master has updated. So branch B must
> rebase to the current master. Then problem happends: git rebase
> successfully without any conflicts. But branch B cannot see function =
X
> from master (or branch A), only its own function Y.
>       I think that's because Git is based on file instead of patch.
> But I think Git can report it in this situation.
>       How do you think ? Thank you anyway for maintaining this amazin=
g software.

Well I tried to reproduce the problem. I did the following steps:
$ mdkir test_repo
$ cd test_repo
$ git init
$ echo Hello >hi
$ git commit -a -m "C1"
$ git checkout -b A
$ echo Bye >hi
$ git commit -a -m "C2 - A"
$ git checkout -
$ git checkout -b B
$ echo "Bye." >hi
$ git commit -a -m "C3 - B"
$ git checkout -
$ git merge A
$ git checkout B
$ git rebase master

This shows that some merge conflicts needs resolving. Did I follow
your steps or I missed something? It would be better if you could
reproduce your steps like I did so as to make things more clear to us.

Regards,
Pranit Bauva
