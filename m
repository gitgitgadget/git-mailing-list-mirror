From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Multi-line commit message changed to a single one
Date: Fri, 13 Jun 2014 15:40:53 +0200
Message-ID: <CABPQNSbBugkr-BVph3zxmaE5jjfuoagmmr1c9ivGOyMuTkbSRg@mail.gmail.com>
References: <b1056272-4b49-439e-a071-88b4262066bb@googlegroups.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>, GIT Mailing-list <git@vger.kernel.org>
To: jese.jlf@gmail.com
X-From: msysgit+bncBDR53PPJ7YHRBDP75OOAKGQEU3LBHMI@googlegroups.com Fri Jun 13 15:41:42 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBDP75OOAKGQEU3LBHMI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f190.google.com ([209.85.192.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBDP75OOAKGQEU3LBHMI@googlegroups.com>)
	id 1WvRja-0005GQ-Vc
	for gcvm-msysgit@m.gmane.org; Fri, 13 Jun 2014 15:41:35 +0200
Received: by mail-pd0-f190.google.com with SMTP id v10sf316619pde.7
        for <gcvm-msysgit@m.gmane.org>; Fri, 13 Jun 2014 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=kqKI7MgiC6oF3rVegoRTFA2HRZIZU1NCv7R0Mj72+fU=;
        b=Y4VmYYlOk59+H3iveYzmIV6hPgHc+/S5j/F63sZo+L9l4RKeLpNMumPWnh4J03o0/f
         bvqDFjjsEHtdUKe7d14/2rxy5ygyNZQsTm/tLsBKfBzXZ3KAvBWa6HL1HyxAMJGEzALS
         KOLEaDu888okTeX28bp6OzxHVI//6vnY05H13UCOMARqW91B2+yzDgEK0hXyKwpwszi5
         YwdZs0/jKBszGMk1qe/L266npTD2vdJi3M9EpgC5928ZBSYaH7xIoiRdki6+qTgipenY
         GuG3+bxzDTq2X7DSWfWmdYZz94g+K+N7geD5/Gmo2o4dvdxKqQ4PUP3HYn02C0CsF+Yf
         0Sog==
X-Received: by 10.140.102.163 with SMTP id w32mr2713qge.39.1402666893882;
        Fri, 13 Jun 2014 06:41:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.105.54 with SMTP id b51ls3495044qgf.48.gmail; Fri, 13 Jun
 2014 06:41:33 -0700 (PDT)
X-Received: by 10.236.138.113 with SMTP id z77mr168512yhi.25.1402666893352;
        Fri, 13 Jun 2014 06:41:33 -0700 (PDT)
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com [2607:f8b0:4001:c05::22a])
        by gmr-mx.google.com with ESMTPS id ha2si93191igb.1.2014.06.13.06.41.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 06:41:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22a as permitted sender) client-ip=2607:f8b0:4001:c05::22a;
Received: by mail-ig0-f170.google.com with SMTP id h3so1554670igd.5
        for <msysgit@googlegroups.com>; Fri, 13 Jun 2014 06:41:33 -0700 (PDT)
X-Received: by 10.43.125.199 with SMTP id gt7mr3415810icc.70.1402666893189;
 Fri, 13 Jun 2014 06:41:33 -0700 (PDT)
Received: by 10.64.227.43 with HTTP; Fri, 13 Jun 2014 06:40:53 -0700 (PDT)
In-Reply-To: <b1056272-4b49-439e-a071-88b4262066bb@googlegroups.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22a
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251597>

On Fri, Jun 13, 2014 at 1:44 PM,  <jese.jlf@gmail.com> wrote:
> Hi,
>
>      Here is a simple script to show my problem. I don't know if it's a
> wrong operation (from me), a wrong configuration/parameter, or either a bug,
> but I don't get what I expected.
>      From a git repo (#1), I created a commit message containing two lines.
> Then I created a patch (git format-patch) and copy/paste it to another git
> repo (#2). When I import this patch (git am), the commit message is modified
> and both lines are "merged" to a single one.
>     Screenshot providen (repo1 : two separated lines, repo2 : a single line)
> with .sh script to reproduce the whole test-case.
>
> If someone could tell me what is wrong... Thanks in advance

This isn't unique to Git for Windows, I just tested on Linux and the
same occurs.

What seems to happen is that git format-patch puts both lines in the
subject of the e-mail, as you can find described here:

https://www.kernel.org/pub/software/scm/git/docs/git-format-patch.html

"By default, the subject of a single patch is "[PATCH] " followed by
the concatenation of lines from the commit message up to the first
blank line (see the DISCUSSION section of git-commit(1))."

So, this is entirely intentional, it seems.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
