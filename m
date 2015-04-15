From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Wed, 15 Apr 2015 11:46:17 +0200
Organization: gmx
Message-ID: <0a22af8a5207eb8f888b65c6bad3e888@www.dscho.org>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
 <00ecdadf-8bcb-4ade-a2fd-46d866a66be8@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Vitaly <vitalyster@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB3PGXCUQKGQELOPV3PY@googlegroups.com Wed Apr 15 11:46:25 2015
Return-path: <msysgit+bncBCZPH74Q5YNRB3PGXCUQKGQELOPV3PY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB3PGXCUQKGQELOPV3PY@googlegroups.com>)
	id 1YiJtm-0001d1-VB
	for gcvm-msysgit@m.gmane.org; Wed, 15 Apr 2015 11:46:23 +0200
Received: by lbiv13 with SMTP id v13sf12287868lbi.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 15 Apr 2015 02:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=/kAl3qKNkn/NJI8fPNuPEeo2W1KURHJH+IOt3Njy9kM=;
        b=qTxb5nUUOmU6egIyLi4cd13WyCDzolfZBJEv2ed4hujaAWHJlyafzVddE5E65JMj5s
         dgQ4aae7s9pFzvan/HINTpdBs/dEayLI6mmEK7evQJIj4Z1KwXwCe2EffmmQqli2SmGc
         2zMw0pa5wuEggWjqL7iNUq8cEMyS0lmSVraAm3ViU+UDUu94Zugiz3twB33pWdo6iaQ7
         3OocXQ34ZtGNJAb07ChlFabk+JxKqQ/SikY6O/9QMYcXA2L4WPTgX14Bcwr+uDQME/G5
         Ag4oA/zbXGJ3u1uHlqoFDwH1Jmg9C6o2jiz0j191qVWGaHFKL7y87dZCLir6VRNjl/F6
         fD2A==
X-Received: by 10.180.126.41 with SMTP id mv9mr157656wib.0.1429091182157;
        Wed, 15 Apr 2015 02:46:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.75.226 with SMTP id f2ls309996wiw.33.gmail; Wed, 15 Apr
 2015 02:46:21 -0700 (PDT)
X-Received: by 10.194.241.200 with SMTP id wk8mr3213461wjc.7.1429091181583;
        Wed, 15 Apr 2015 02:46:21 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id ec7si265119wib.3.2015.04.15.02.46.21
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2015 02:46:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MdrK9-1Z1MBg3CDV-00PdmO; Wed, 15 Apr 2015 11:46:17
 +0200
In-Reply-To: <00ecdadf-8bcb-4ade-a2fd-46d866a66be8@googlegroups.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:YvLi13/MPWkSd8RjAsa/3DtCoKTL/iwePRUaaZHh+KT5Tp+GPzk
 NlTFkqSKRiWj2ajuTSwFMI1AxQvkeHEhWImA02usnkOH5PhEBUnnuuaaasiJE619/SmE985
 kaeH4z00zGR0vHf5gR/7pU6SfOE6lGDnVq+Pe5azH7Eqd/FYJESSKTQ9rPYV6EA1Rb1R61T
 yyciR0v1t0s/dtAnbET5w==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267194>

Hi Vitaly,

On 2015-04-15 09:17, Vitaly wrote:
>>
>>  feel free to give it a spin: https://git-for-windows.github.io/#download
>>
> 
> I have installed msysgit 1.9.4, installing git for windows 2.3.5.8 (into 
> default localtion and with "use from Windows command prompt")

Which version, 32-bit or 64-bit? PortableGit or regular Git?

> and call "git --version" still give me  msysgit1.9.4

And the path was not adjusted at all? That would be strange indeed.

> I have delete gfw 2.3.5.8 and msysgit 1.9.4, install gfw 2.3.5.8 once again 
> (and check "use from Windows command prompt") and now I have:
> C:\>git
> error launching git:      .
> 
> I see C:\Program Files (x86)\Git\bin in my PATH (from old installs?), but 
> did not see this directory (bin) under Git installation

There is explicit code to modify the PATH environment variable when you choose the "from Windows command prompt" option: https://github.com/git-for-windows/build-extra/blob/4fdceef37514d1b35d524a8752ccf4e7ad778f60/installer/install.iss.in#L1163-L1177

Just to make sure, you are certain that the PATH variable is not touched, even if you reinstall (without uninstalling Git for Windows first)?

Ciao,
Johannes

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
