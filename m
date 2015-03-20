From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Git for Windows 1.9.5.msysgit.1
Date: Fri, 20 Mar 2015 09:38:52 +0100
Message-ID: <18a96980-a7e7-4a72-bb87-55f3e3f05d95@virtuell-zuhause.de>
References: <550B55CF.4090701@virtuell-zuhause.de>
 <20150320011531.GA20149@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: msysGit <msysgit@googlegroups.com>,
 GIT Mailing-list <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: msysgit+bncBCL7JHHTPAIKRONPVACRUBCTTX3Z2@googlegroups.com Fri Mar 20 09:39:15 2015
Return-path: <msysgit+bncBCL7JHHTPAIKRONPVACRUBCTTX3Z2@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIKRONPVACRUBCTTX3Z2@googlegroups.com>)
	id 1YYsSP-00026G-Jf
	for gcvm-msysgit@m.gmane.org; Fri, 20 Mar 2015 09:39:05 +0100
Received: by wiwh11 with SMTP id h11sf3441455wiw.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Mar 2015 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:user-agent:mime-version:message-id
         :in-reply-to:references:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=LHwGPrzj4F22RkKZlr4be5ETX5QWDpGLSkliT85fzuM=;
        b=TScg/I+zaghAjyKliAl0pnXAUG7u+pLISCBXS/xArjVjwlc2HW5JiKkWWoyneeYVFd
         ds2DeSslDd5JHtEw43ITg4hWaHKISoKJ7JCoHlCzIC1R9gMRhcLqWBIpHmW4Gh0Hptxt
         bqVgVetPz/vocN+wTZt4sSeLLJSPFKKiiQlwWT4btClvi0aWc8qM98bULuftSMAoMPOD
         6NF+aKC2l2ULQSXcOokvow2TpxXFnUXNjFg5D/lIe0V39QcHjqyBry4UGnayJvoFYXCr
         TKJGy63ZLsRwAbpN2lCSj2n0N1WtjKYejt/GaLu3Dgi4HfWipx9rPcHKxnjqpFkyHkRT
         VptA==
X-Received: by 10.152.116.3 with SMTP id js3mr768711lab.26.1426840745178;
        Fri, 20 Mar 2015 01:39:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.6.68 with SMTP id y4ls400525lay.12.gmail; Fri, 20 Mar 2015
 01:39:03 -0700 (PDT)
X-Received: by 10.112.120.136 with SMTP id lc8mr9746321lbb.24.1426840743546;
        Fri, 20 Mar 2015 01:39:03 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id o3si74673wib.2.2015.03.20.01.39.03
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 01:39:03 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=80.237.132.163;
Received: from p5ddc2b9d.dip0.t-ipconnect.de ([93.220.43.157] helo=localhost); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1YYsSM-0003CS-VB; Fri, 20 Mar 2015 09:39:02 +0100
User-Agent: Trojita/v0.5-obs-fae83fd; Qt/4.8.2; X11; Linux; Debian GNU/Linux 7.8 (wheezy)
In-Reply-To: <20150320011531.GA20149@glandium.org>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1426840743;cf6c4d00;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265869>

On Freitag, 20. M=C3=A4rz 2015 02:15:31 CEST, Mike Hommey wrote:
> On Fri, Mar 20, 2015 at 12:03:43AM +0100, Thomas Braun wrote:

Hi,

>> the Git for Windows team just released the first maintenance release of
>> the Windows-specific installers for git 1.9.5.
>
> is it expected that there is no corresponding release on
> https://github.com/git-for-windows/git/releases ?

https://github.com/msysgit/git/releases/tag/v1.9.5.msysgit.1 is the=20
corresponding source code release. Binaries are available from=20
https://github.com/msysgit/msysgit/releases/tag/Git-1.9.5-preview20150319.

--=20
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

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
