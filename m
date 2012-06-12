From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re:
Date: Wed, 13 Jun 2012 01:51:50 +0200
Message-ID: <CABPQNSZHTF36ssj8DKUedWJ3TR-WMp7wD6SWSF8ji3uf_2OanA@mail.gmail.com>
References: <395382583.32740.1339535566411.JavaMail.mail@webmail16>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: rohit sood <rohit.s@lycos.com>
X-From: msysgit+bncCOPdven-DxC_rN_-BBoEFQ2opw@googlegroups.com Wed Jun 13 01:52:41 2012
Return-path: <msysgit+bncCOPdven-DxC_rN_-BBoEFQ2opw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxC_rN_-BBoEFQ2opw@googlegroups.com>)
	id 1Seasy-0005Pz-QL
	for gcvm-msysgit@m.gmane.org; Wed, 13 Jun 2012 01:52:32 +0200
Received: by yenq6 with SMTP id q6sf85215yen.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 12 Jun 2012 16:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=87mFHR3gvn82geEEi0oxUjs11Y37R/f0vIlIjzgzjqA=;
        b=kcBzWes1DQ4M3kH/G/11rL93qxDlbdwzEYV/jqp8Mn+EGi3WteewaplZRJ2nwBXenL
         upd5tbLjibvAfhAdTZajkZuLeE+YY+kiLEmMUbsp4S4bEAuSjnXMY9Aa/I3fEh5NpqVh
         hzHICxfRFaI02xL3qOhBclACVD1BF2koE+cvQ=
Received: by 10.68.235.37 with SMTP id uj5mr799489pbc.13.1339545151985;
        Tue, 12 Jun 2012 16:52:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.68.132.136 with SMTP id ou8ls17397207pbb.9.gmail; Tue, 12 Jun
 2012 16:52:31 -0700 (PDT)
Received: by 10.68.238.65 with SMTP id vi1mr13298892pbc.7.1339545151193;
        Tue, 12 Jun 2012 16:52:31 -0700 (PDT)
Received: by 10.68.238.65 with SMTP id vi1mr13298891pbc.7.1339545151180;
        Tue, 12 Jun 2012 16:52:31 -0700 (PDT)
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com [209.85.160.41])
        by gmr-mx.google.com with ESMTPS id tf10si2985735pbc.0.2012.06.12.16.52.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 16:52:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.160.41 as permitted sender) client-ip=209.85.160.41;
Received: by pbbrp2 with SMTP id rp2so1653383pbb.0
        for <msysgit@googlegroups.com>; Tue, 12 Jun 2012 16:52:31 -0700 (PDT)
Received: by 10.68.132.166 with SMTP id ov6mr44417131pbb.24.1339545150834;
 Tue, 12 Jun 2012 16:52:30 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 12 Jun 2012 16:51:50 -0700 (PDT)
In-Reply-To: <395382583.32740.1339535566411.JavaMail.mail@webmail16>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.160.41 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199870>

This message should probably go to the msysGit mailing list. Included in CC=
.

On Tue, Jun 12, 2012 at 11:12 PM, rohit sood <rohit.s@lycos.com> wrote:
>
> Hi,
> =A0 When trying a remote install of the git client using winrm on a Windo=
ws 2003 box, I get the following error :
>
> 2012-06-12 14:59:05.476 =A0 Line 852: Creating symbolic link "E:\apps\pro=
d\Git\libexec/git-core/git-whatchanged.exe" failed, will try a hard link.
> 2012-06-12 14:59:05.523 =A0 Line 852: Creating symbolic link "E:\apps\pro=
d\Git\libexec/git-core/git-write-tree.exe" failed, will try a hard link.
> 2012-06-12 14:59:05.570 =A0 Line 852: Creating symbolic link "E:\apps\pro=
d\Git\libexec/git-core/git.exe" failed, will try a hard link.
> 2012-06-12 14:59:05.679 =A0 Message box (OK):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Unable to configure th=
e line ending conversion: core.autocrlf true
>
> I use the Git-1.7.10-preview20120409.exe executable .
> I am attempting to script an unattended silent install of the executable =
with the following options using Opscode Chef :
>
> options "/DIR=3D\"#{node['GIT']['HOME']}\" /VERYSILENT /SUPPRESSMSGBOXES =
/LOG=3D\"#{ENV['TEMP']}\\GIT_INSTALL.LOG\""
>
> Please advise
>
> thanks,
> Rohit
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
