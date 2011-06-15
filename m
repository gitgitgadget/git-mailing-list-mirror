From: =?iso-8859-1?Q?Magnus_Kallstr=F6m?= <magnus.kallstrom@gmail.com>
Subject: Re: Re: Trailing spaces in branchname (git-svn)
Date: Wed, 15 Jun 2011 23:13:32 +0200
Message-ID: <58D5F1F8-CC94-4629-B476-91512ED35E0E@gmail.com>
References: <0014af8a-3b24-4398-88aa-7a3e460f2283@s11g2000yqh.googlegroups.com> <AANLkTinZnd0R8Rnv4kaiJAGP0qKEwgbU+nP=donmbEbp@mail.gmail.com> <12ada6de-4345-4259-b832-371a74df9775@l6g2000vbn.googlegroups.com> <BANLkTikaeXxRMJErAYy3-LSrvfNZXAbEEw@mail.gmail.com> <b8767de1-ab2c-4d2a-9024-9ad9b29c614d@j9g2000vbs.googlegroups.com> <BANLkTikgF53tKbUsJJznENAiW8Smm5ePPA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/alternative; boundary=Apple-Mail-78--847269397
Cc: msysGit <msysgit@googlegroups.com>,
 Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: msysgit+bncCK_3npOZGBCQwuTvBBoEtb565g@googlegroups.com Wed Jun 15 23:16:30 2011
Return-path: <msysgit+bncCK_3npOZGBCQwuTvBBoEtb565g@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f186.google.com ([209.85.216.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCK_3npOZGBCQwuTvBBoEtb565g@googlegroups.com>)
	id 1QWxRs-0003zL-EW
	for gcvm-msysgit@m.gmane.org; Wed, 15 Jun 2011 23:16:28 +0200
Received: by qyk10 with SMTP id 10sf993594qyk.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 15 Jun 2011 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:x-beenthere:received-spf:subject:mime-version
         :from:in-reply-to:date:cc:message-id:references:to:x-mailer
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=8h5m73IzkQxEUm/vOiGHuarFKLQW9HFkSTWtR1fv3Cg=;
        b=iLC3K6EgsPHbvwb2lRQGjFWkqpQtaJIY+y61oiiXnvZEwQI7uigDFBwl0TokWepeY3
         kelYdHKTAunugO9RuBSlB6dfYY9OaPC5+SJpVCICQ/fwfdbQkwB5bscKCpZneqpqUT3o
         1LgdwN1d2MkOUul/47kGCWhRi4M0y8MBx31f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:subject:mime-version:from:in-reply-to:date
         :cc:message-id:references:to:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        b=b0JtIDjk6w+JxBN4KTb+Qnt6PQfP886E6+14sm5nBirof9AqTanJIuzz0ddjxAoNEH
         8mfKxWJtCRjnXfbIpRCtHCF73LNq27ogDZPMtUrS/d+fswhwkJbA4ds1GxrXZX511Z/q
         lnyXYRwR+UnHPm2RmxGdTl5RrjLQUB3NWVeuk=
Received: by 10.224.75.7 with SMTP id w7mr11787qaj.8.1308172560177;
        Wed, 15 Jun 2011 14:16:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.175.74 with SMTP id w10ls260240qaz.0.gmail; Wed, 15 Jun
 2011 14:15:59 -0700 (PDT)
Received: by 10.224.204.5 with SMTP id fk5mr107322qab.25.1308172559518;
        Wed, 15 Jun 2011 14:15:59 -0700 (PDT)
Received: by 10.224.96.6 with SMTP id f6msqan;
        Wed, 15 Jun 2011 14:13:36 -0700 (PDT)
Received: by 10.52.178.103 with SMTP id cx7mr57171vdc.10.1308172416357;
        Wed, 15 Jun 2011 14:13:36 -0700 (PDT)
Received: by 10.52.178.103 with SMTP id cx7mr57170vdc.10.1308172416338;
        Wed, 15 Jun 2011 14:13:36 -0700 (PDT)
Received: from mail-fx0-f49.google.com (mail-fx0-f49.google.com [209.85.161.49])
        by gmr-mx.google.com with ESMTPS id ch6si724804vdb.2.2011.06.15.14.13.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 14:13:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of magnus.kallstrom@gmail.com designates 209.85.161.49 as permitted sender) client-ip=209.85.161.49;
Received: by fxm14 with SMTP id 14so855522fxm.8
        for <msysgit@googlegroups.com>; Wed, 15 Jun 2011 14:13:35 -0700 (PDT)
Received: by 10.223.92.146 with SMTP id r18mr83464fam.135.1308172415048;
        Wed, 15 Jun 2011 14:13:35 -0700 (PDT)
Received: from [192.168.0.101] (static-81.216.116.168.addr.tdcsong.se [81.216.116.168])
        by mx.google.com with ESMTPS id h1sm449396fag.35.2011.06.15.14.13.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 14:13:34 -0700 (PDT)
In-Reply-To: <BANLkTikgF53tKbUsJJznENAiW8Smm5ePPA@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
X-Original-Sender: magnus.kallstrom@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of magnus.kallstrom@gmail.com designates 209.85.161.49 as permitted
 sender) smtp.mail=magnus.kallstrom@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175852>

--Apple-Mail-78--847269397
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

(I hope I get it right now - previously I used Googles web-interface, =
and I just couldn't find a way to respond to all. Trying from my email =
client instead now... I have even read the 'Welcome post' again :) )

Unfortunately, the patch didn't work.

This is the error I get when it aborts:
Found branch parent: (refs/remotes/CR3533 s=C3=B6kning p=C3=A5 =
fakturabelopp ) be4dd98d152d82f098b90089f4df6a2d411d84e1
fatal: Unable to create 'd:/Dev/GIT/svk/KOB/.git/svn/refs/remotes/CR3533 =
s=F6kning p=E5 fakturabelopp /index.lock': No such file or directory
read-tree be4dd98d152d82f098b90089f4df6a2d411d84e1: command returned =
error: 128

The patch itself is probably working for other parts, and I even tried a =
similar patch back in March. I never managed to figure out where the =
call to the locking-function got it's path though.=20=

--Apple-Mail-78--847269397
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=iso-8859-1

<html><head><base href=3D"about:blank"></head><body =
style=3D"background-color: transparent; margin-top: 0px; margin-left: =
0px; margin-bottom: 0px; margin-right: 0px; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; " =
applecontenteditable=3D"true"><base href=3D"about:blank"><div>(I hope I =
get it right now - previously I used Googles web-interface, and I just =
couldn't find a way to respond to all. Trying from my email client =
instead now... I have even read the 'Welcome post' again :) =
)<div><br></div><div>Unfortunately, the patch didn't =
work.</div><div><br></div><div>This is the error I get when it =
aborts:</div><div></div><span =
id=3D"internal-source-marker_0.08648242522031069" style=3D"font-size: =
11pt; font-family: Arial; color: rgb(0, 0, 0); background-color: =
transparent; font-weight: normal; font-style: normal; text-decoration: =
none; vertical-align: baseline; white-space: pre-wrap; ">Found branch =
parent: (refs/remotes/CR3533 s=C3=B6kning p=C3=A5 fakturabelopp ) =
be4dd98d152d82f098b90089f4df6a2d411d84e1</span><br><span =
style=3D"font-size: 11pt; font-family: Arial; color: rgb(0, 0, 0); =
background-color: transparent; font-weight: normal; font-style: normal; =
text-decoration: none; vertical-align: baseline; white-space: pre-wrap; =
">fatal: Unable to create =
'd:/Dev/GIT/svk/KOB/.git/svn/refs/remotes/CR3533 s=F6kning p=E5 =
fakturabelopp /index.lock': No such file or directory</span><br><span =
style=3D"font-size: 11pt; font-family: Arial; color: rgb(0, 0, 0); =
background-color: transparent; font-weight: normal; font-style: normal; =
text-decoration: none; vertical-align: baseline; white-space: pre-wrap; =
">read-tree be4dd98d152d82f098b90089f4df6a2d411d84e1: command returned =
error: 128</span></div><div><span style=3D"font-size: 11pt; font-family: =
Arial; color: rgb(0, 0, 0); background-color: transparent; font-weight: =
normal; font-style: normal; text-decoration: none; vertical-align: =
baseline; white-space: pre-wrap; "><br></span></div><div><span =
style=3D"font-size: 11pt; font-family: Arial; color: rgb(0, 0, 0); =
background-color: transparent; font-weight: normal; font-style: normal; =
text-decoration: none; vertical-align: baseline; white-space: pre-wrap; =
">The patch itself is probably working for other parts, and I even tried =
a similar patch back in March. I never managed to figure out where the =
call to the locking-function got it's path though. =
</span></div></body></html>=

--Apple-Mail-78--847269397--
