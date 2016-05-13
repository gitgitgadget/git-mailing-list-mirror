From: =?UTF-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
Subject: Re: bug report
Date: Fri, 13 May 2016 15:41:13 +0800
Message-ID: <CABKuJ_RrOhT+FVb9PNKhBs1ATJmLWhD757oyx+AvrCGNvT1nFw@mail.gmail.com>
References: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
	<CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
	<CABKuJ_QZHTRcPWbwv1FSXEijxOpXameo-JJuZREGyA5daLbKLQ@mail.gmail.com>
	<CAFZEwPP32vWrCA9H+JbFineodDtGx2_bTjGy-nZ9KW2v8bP5vQ@mail.gmail.com>
	<CABKuJ_SEK-t93sCmj6aFSAbk8muX_ocQx6ZQZV3ZrNmvVmvDQA@mail.gmail.com>
	<CAFZEwPMe2W2R2GghMnyQ4BLyvm00oHEweNSZYrqn+=9BhSazvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 09:41:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b17ip-0007H5-Au
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 09:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbcEMHlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 03:41:15 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33684 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbcEMHlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 03:41:14 -0400
Received: by mail-oi0-f42.google.com with SMTP id v145so158103425oie.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 00:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=xm8OwlFD8FgU71T/ybKCyGp+o/b7vxuvUinsNgpQf1w=;
        b=WmWAML4yUdYDyuI4d8wjnRDSerY8NPe+39ZDub6kbxGoxLzOv0OzhbX1d4lgDm7itC
         kEKm78UtTK3thUjh0Ve2BMqLZOnh37s5caMWmmdBdpwOfFTVXpAkHNHu2qOn+Eh8YSep
         no6Dij8iCpT1bfK9x7QMa+Dw/7Se5duO7Dfi4QsyatC3xfgqmzSQm5xOlLZYbXYR4u90
         B9hbRYm/Vv9cseRLA34rQtQqmTTwtdk1LXhOXjPEYSbgWgED7rAOrPmDbLQP/N2Kbcvv
         QZ/ztiPeoPaeGNPayXfxMaRsL+acm+V2Yj3b+uwju6cljXK1QSRjFbMUGLd2D1+KbVo7
         l1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=xm8OwlFD8FgU71T/ybKCyGp+o/b7vxuvUinsNgpQf1w=;
        b=aXk21VL0XIJ2lfE80QPZiLfWxy3z7anPABPdsmanHLKvpxTEgoUcBEGnuQXwuIHHkv
         4suqrm6w4xJfZc5Vlu6sf+kwpVKKGHV3bXdWd7TbQ6WOu/WGc3YJ8Qg6zi25i9qfhSgR
         EAOMIoY+0T6kgBmGB4oTs5US6pteToKn3b8hcMn/F7Mf7yR5CSB+d3I8rQWiWJVEa/x5
         8naSZtTsWJ3z6ss9akVQYT6bwEE33cZI8oq6nwJ9YjtOY8lN5ttDEq7cHpbyElXUnHKI
         V44ehe/8cirB2ubxfr+EWvBr893RlbEHenAvVTYPAAsIvl2lx7VTMcMNLBo3T9/tEFSQ
         qW0Q==
X-Gm-Message-State: AOPr4FXR7sVkhgt23iI9/L9p+r6LE/kPj7z8/YRTYdo+E/Xr98fEBIM0UxBpsLQEKz32n9mKBirhwv2ltIH0+g==
X-Received: by 10.202.173.209 with SMTP id w200mr8361667oie.67.1463125273752;
 Fri, 13 May 2016 00:41:13 -0700 (PDT)
Received: by 10.202.46.8 with HTTP; Fri, 13 May 2016 00:41:13 -0700 (PDT)
In-Reply-To: <CAFZEwPMe2W2R2GghMnyQ4BLyvm00oHEweNSZYrqn+=9BhSazvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294515>

It does not warn me in this case. I replayed it again, below is my proc=
ess:

$ mkdir bug_test
$ cd bug_test/
$ git init
Initialized empty Git repository in /home/libenchao/tmp/bug_test/.git/
$ echo 'hello' > README.md
$ git add README.md
$ git commit -m 'Add README.md'
[master (root-commit) 9cdb3a8] Add README.md
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
$ git checkout -b A
Switched to a new branch 'A'
$ echo 'world' >> README.md
$ git commit -a -m 'Add one line'
[A 6f0b0a3] Add one line
 1 file changed, 1 insertion(+)
$ git checkout master
Switched to branch 'master'
$ git checkout -b B
Switched to a new branch 'B'
$ echo 'world' >> README.md
$ git commit -a -m 'Add one line too'
[B d89cf11] Add one line too
 1 file changed, 1 insertion(+)
$ vim README.md                        # in this line, I modify line 2
'world' to 'git'
$ cat README.md
hello
git
$ git commit -a -m 'Modify one line'
[B a674427] Modify one line
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git checkout master
Switched to branch 'master'
$ git merge A
Updating 9cdb3a8..6f0b0a3
=46ast-forward
 README.md | 1 +
 1 file changed, 1 insertion(+)
$ git checkout B
Switched to branch 'B'
$ git rebase master
=46irst, rewinding head to replay your work on top of it...
Applying: Modify one line
$ cat README.md
hello
git
$

2016-05-13 15:10 GMT+08:00 Pranit Bauva <pranit.bauva@gmail.com>:
> On Fri, May 13, 2016 at 12:27 PM, =E6=9D=8E=E6=9C=AC=E8=B6=85 <libenc=
hao@gmail.com> wrote:
>> Yes, you got the right understanding of my problem.
>>
>> You are right, the git behavior is quite correct. But I met this
>> problem in my practical work:
>>
>> My colleague added a method but I didn't know. I also added the same=
 method.
>> Then I found that I didn't need the method actually, so I deleted it=
=2E
>> My colleague merged to the master before me. When I wanted to merge,=
 I found
>> conflicts with master. And I rebased to current master. And That met=
hod was
>> deleted finally without any warning or information.
>
> I am quite sure that there would be an output to show that there are
> conflicts and it would be suggesting you to first resolve the
> conflicts and there would also be markers in the file like ">>>>>" an=
d
> "=3D=3D=3D=3D=3D=3D" and the file would be marked with "both modified=
". After you
> resolve the conflicts, you can add the file by using git-add and then
> "git rebase --continue" to proceed. If you find out that there is som=
e
> problem, then you can always use "git rebase --abort" to abort the
> rebase process and get to the initial state *perfectly* without any
> glitches.
>
>> Do you think Git should output something to warn the user or I just
>> use Git in a wrong way ?
>
> It does warn. I don't know how it got missed in your case. This is
> quite a common problem and even I have faced this quite for quite a
> lot of times now and it always did warn me.
>
>> Thanks.
>
> I will recommend you reading this article[1]. I know its a bit of a
> long read but it will help a lot.
>
> [1]: http://tedfelix.com/software/git-conflict-resolution.html
>
> Regards,
> Pranit Bauva



--=20
Benchao Li
School of Electronics Engineering and Computer Science, Peking Universi=
ty
Tel:+86-15650713730
Email: libenchao@gmail.com; libenchao@pku.edu.cn
