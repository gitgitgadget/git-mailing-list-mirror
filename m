From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: Release candidate of Git for Windows 2.x is out
Date: Tue, 09 Jun 2015 14:04:56 +0200
Organization: gmx
Message-ID: <56c307e1fd6320e55cc8a62f28f70f8f@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <aa3467c7-bf83-4ccb-be64-929b944806ba@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysgit@googlegroups.com, git-for-windows@googlegroups.com,
 git@vger.kernel.org
To: Qb <tholag@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB2VM3OVQKGQEKNYYO3I@googlegroups.com Tue Jun 09 14:05:04 2015
Return-path: <msysgit+bncBCZPH74Q5YNRB2VM3OVQKGQEKNYYO3I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB2VM3OVQKGQEKNYYO3I@googlegroups.com>)
	id 1Z2IHA-0006Se-B8
	for gcvm-msysgit@m.gmane.org; Tue, 09 Jun 2015 14:05:04 +0200
Received: by wibbw19 with SMTP id bw19sf3408519wib.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 09 Jun 2015 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=gZE6Pp3qfBee1ojtPgOKRw3Gr8molb9azQFcJNweevk=;
        b=Mi/iMa7RNxPbXtSNXuk6vXUDmYQCxSFqX2W5BwnktVcvyl2dMRoRvah5rjb3Fczhq0
         iCjmV350XZjIU0ujB4fffInVyNxLGfWACW7nN93IlZZuIpZtlCDzMWaeFJSXkmPEYkE6
         jFgcA732ekNDesd9u4kU0Q8M2UVXZhJ+rHWlxShHoflPVjYkdHlzpDhtcFGhYvmOaEdj
         UVFc81sRRkwDwVyFpZs/fyC5HDBtPaq1KkPEpPnS3bOeEQ2lJyVc7HHU2EZ2Kk3v/9pT
         HEK5DmCkFa/sfHp25SgEWostdhDXV8sP6VgmisGOjqY7xW2iEkTwMOrmgFVl+IrGdNRu
         S7Ow==
X-Received: by 10.152.43.14 with SMTP id s14mr218246lal.28.1433851499015;
        Tue, 09 Jun 2015 05:04:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.205.107 with SMTP id lf11ls57380lac.65.gmail; Tue, 09 Jun
 2015 05:04:57 -0700 (PDT)
X-Received: by 10.112.142.67 with SMTP id ru3mr20502638lbb.1.1433851497674;
        Tue, 09 Jun 2015 05:04:57 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id q10si82596wiz.0.2015.06.09.05.04.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 05:04:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M23zf-1ZLcRP22zD-00u1xV; Tue, 09 Jun 2015 14:04:56
 +0200
In-Reply-To: <aa3467c7-bf83-4ccb-be64-929b944806ba@googlegroups.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:21kKTd0mmprHBDxun7mJ4dUcmQWiKdxrVp++uQnt3u27lKDZ70G
 t0e4BxhNFIOHYXp14QeuMtxqhg0QKrv9aAwpBqFyu6k5iYLYMmhekTjRQvrmtLojrP9vvdn
 kGnG8JMTa/eF9ZfB6/B9VjF0igbG8DiDfcAny/D+oNwW5H9gpoZqM316TEBC9r1B7lZsm7A
 73Ctj/ikxJbvZM/q5pOWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:60dUBmeRIlY=:rSeesW/6IPtMx/X5+BUepg
 ZCYbQ8A/9K3m/XJ0o28kMyEVmQ5k4a9+W6oHxpuJKVZApJFIsMGWGeEN/VZtDch9OMULMfrEx
 FsMIkQU8+xWQFV9kMyf25gCGKiAGee/NUeReBtlJmzMeIT0fhoATeDbTNvbHLDHUdSfpiy2QP
 M3w9fVV91r3nrMSuaDuUz2qwbIrOv2dX9yLiJWz/t8yEasWyH1qha9ZcC0nbSY76jvnIheOw7
 nCwF/woFZYIIVyg93YuYIi28Sao4h6kRnI5F+OHUcMHPQTo93yV3qtg4heQDOVBeiP7GoruRd
 eMs/ICkgAMCsGBMuErV+hNbkot8TZQ4S0MWvPSSgLmN+habgfOhRTnfy8TnbfejIyR4smpB3v
 ns1J0qZFFQW1gUfiKVQ6PJNsi/ZRa8HBYLf2Hshi1YXRuV1NSogfZnhMRTk16aTU5BQC7RHvf
 GATPj2UjWnxBvcNbsWAZg5/xw5/ICzG/7Yv3405uBkuyDmaXN7STQxsrSBFrYNHPyOx2t//Py
 m2jljhggZ5ueSGXlu490dwdQJlSleVTtiDI18mWVdX7Bn7i/5XYamZPpX8h/6Wyl7KCeEkvis
 5fsYpbuvVcSsbd4sGMQS1QREOUi/BQeiOPzBKx/u7UENJutPKrvdDTn+R6x6+lDy5ICgCOtU9
 xM09ZYTSkYUqSquQQ3KmsBlXwjDWgSaQbg8nYT2v7saR1gQ3xw7EXOiARRI7u2olWufU=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271168>

Hi,

On 2015-06-09 10:43, Qb wrote:

> I'm trying the release candidate on Win 8.1. Everything's working now, but 
> when I clone a repository
> 
> git clone http://...../name.git CustomFolder
> 
> it creates CustomFolder with the checkout files, but the .git folder is 
> created inside CustomFolder\CustomFolder\

I cannot reproduce this behavior.

This is what I did to test:

1. install Git-2.4.2.1-release-candidate-64.exe (default options)
2. run Git Bash
3. git clone https://github.com/dscho/images.git octocats

This results in a correct checkout: `$HOME/octocats/.git/` exists and contains the local repository.

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
