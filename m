From: "Peter Klavins" <klavins-ooduxAEi7gXtt0EhB6fy4g@public.gmane.org>
Subject: Re: [ANNOUNCE] qgit2.1rc1_win.exe
Date: Wed, 26 Dec 2007 22:22:39 +0100
Message-ID: <fkugn8$d2s$1@ger.gmane.org>
References: <e5bfff550712240113y4acdaa11y3483705172a5980e@mail.gmail.com>
Reply-To: klavins-ooduxAEi7gXtt0EhB6fy4g@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"; reply-type=original
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Dec 26 23:20:49 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7ecJ-0007Rl-3m
	for gcvm-msysgit@m.gmane.org; Wed, 26 Dec 2007 23:20:47 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1125920wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 26 Dec 2007 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:in-reply-to:x-msmail-priority:x-newsreader:x-mimeole:cc:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=A6/EWiMViF81OL/abnN1PaQMJquNxWxvbuMfuzncH74=;
        b=DPqCxUqFcbdPQyac3gqMDu9MAJgDYqy9BE4cP2LSc5qAAtNAKO2i2MPEJfL8XVi2krYiz2tKu59lCU1v2vbjxDy7o7p37RYjnyN91RCgC+wllJLGMf2r0gDInFezgs9b0FV9ubX8CiU6pcXfbMN0EdFBznUaMZMWxuuQXw9a/Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:in-reply-to:x-msmail-priority:x-newsreader:x-mimeole:cc:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=FC1w1bLfIMSqe6vsu4sCDL5VDGeIgyuDELXf7UuBEi4OHp0DWCFSxfuey4WRUFkx6dIBbPTDPunMhioyjOBjGa+VjOI+fSVMv0aoh/ZHf7hgNccvr12fJ4i9DAcCDNADnX9YhaW32T5+s5xQ2ePi4kT2G5MDxKANmyE0kZHmLL8=
Received: by 10.114.107.19 with SMTP id f19mr244293wac.26.1198707621986;
        Wed, 26 Dec 2007 14:20:21 -0800 (PST)
Received: by 10.107.94.14 with SMTP id w14gr1282prl;
	Wed, 26 Dec 2007 14:20:21 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.193.1 with SMTP id q1mr3841176waf.27.1198707621808; Wed, 26 Dec 2007 14:20:21 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id h71si8146958nzf.3.2007.12.26.14.20.20; Wed, 26 Dec 2007 14:20:21 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from root by ciao.gmane.org with local (Exim 4.43) id 1J7ebb-0001jm-5B for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Wed, 26 Dec 2007 22:20:03 +0000
Received: from 217-133-15-180.b2b.tiscali.it ([217.133.15.180]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 26 Dec 2007 22:20:03 +0000
Received: from klavins by 217-133-15-180.b2b.tiscali.it with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 26 Dec 2007 22:20:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: 217-133-15-180.b2b.tiscali.it
In-Reply-To: <e5bfff550712240113y4acdaa11y3483705172a5980e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16545
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69246>


> You can find an auto-extract zip file with a version of qgit built for
> Windows (Vista).

I found it a bit obscure as to how to rebuild qgit from scratch on Vista, so 
just for the record:

# Set up VS2008
1. Install Visual Studio 2008

# Set up Qt4
2. Download qt-win-opensource-src-4.3.3.zip from 
http://trolltech.com/developer/downloads/qt/windows and unzip into directory 
(e.g.,) C:\qt-win-opensource-src-4.3.3
3. cd C:\qt-win-opensource-src-4.3.3
4. configure                 (takes significant time, around 10 minutes from 
memory)
5. nmake                     (takes over an hour on a Core 2 Duo 2 GHz, 
consumes 2 GByte of disk)

# Install git and use it to get qgit4 source
6. Download Git-1.5.4-rc1-preview20071221-corrected.exe from 
http://code.google.com/p/msysgit/downloads/ and install (default directory 
C:\Program Files\Git is fine)
7. Open Git Bash from Start menu, set up Src directory (e.g., mkdir Src, cd 
Src)
8. git clone git://git.kernel.org/pub/scm/qgit/qgit4.git        (to get qgit 
sources into Src/qgit4)
9. Exit Git Bash shell

# Build and run qgit
10. Open VS2008 command prompt, ensuring that VS tools are on the PATH by 
test invoking 'nmake'
11. Add qmake to path with PATH=C:\qt-win-opensource-src-4.3.3\bin;%PATH%
12. Add git to path with PATH=C:\Program Files\Git\bin;%PATH%
13. Navigate to qgit4 directory (e.g., cd C:\Users\<you>\Src\qgit4)
14. qmake              (to preprocess with Qt4)
15. nmake              (to build debug version)
16. bin\qgit             (to run qgit to browse qgit4's own repository!)

------------------------------------------------------------------------
 Peter Klavins 
