From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Wed, 29 Apr 2015 17:40:48 +0200
Organization: gmx
Message-ID: <de8efc157fa301ffbe3cecd8f5c04fdc@www.dscho.org>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
 <bf54ac53-8550-404c-afb2-d0d7257eb4dc@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: rupert thurner <rupert.thurner@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBAXXQOVAKGQETWZEIEI@googlegroups.com Wed Apr 29 17:40:52 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBAXXQOVAKGQETWZEIEI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBAXXQOVAKGQETWZEIEI@googlegroups.com>)
	id 1YnU6V-0002nw-UO
	for gcvm-msysgit@m.gmane.org; Wed, 29 Apr 2015 17:40:52 +0200
Received: by wibbw19 with SMTP id bw19sf21711124wib.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 Apr 2015 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=cNoYgcNcBkFfOBNfZWgQ1AMHHo+a1PVVgWU2OEcih9U=;
        b=cP9NozMq9+GuFf1aMkfq3QAvucle2ZKD8kSY8fvNkrF/xOjo+pQQKoxV4Cs26w1qxz
         NmrfHErBFQRA9cHJfVnKoQDpMsfn6o4EmpvfafLL0JXF9+a1V3dVfUTHliCVuHg1L7x9
         pvs49ibiGPw/hlhsgBo/m9IMUFr6B5bOKghDD9bh0O7G5g6Sn6lBHzuyym6S2j3t+yIK
         3rTUfjArBThHx0W5r/mmTZUjpnaa38AZXGdO2/1tvmKW1qqEB8YO66glf47ik3JEo345
         ojtAQSEgJOMVVXJb2QYKV1fbPLMYCyN01ocLOUf06+zJgmA06dN7nrxylpEGd3SPz6LF
         U1zw==
X-Received: by 10.152.26.132 with SMTP id l4mr269598lag.42.1430322051435;
        Wed, 29 Apr 2015 08:40:51 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.194 with SMTP id v2ls280811lag.59.gmail; Wed, 29 Apr
 2015 08:40:50 -0700 (PDT)
X-Received: by 10.112.219.200 with SMTP id pq8mr13604353lbc.7.1430322050116;
        Wed, 29 Apr 2015 08:40:50 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id k2si818453wif.0.2015.04.29.08.40.50
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 08:40:50 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LmNHK-1ZN5lr0Zve-00ZzVB; Wed, 29 Apr 2015 17:40:49
 +0200
In-Reply-To: <bf54ac53-8550-404c-afb2-d0d7257eb4dc@googlegroups.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:OkCBw/YFaAR9MrwRorM/ubEROUumbJO/qYpERuu7qh8FSR5+dUN
 MwbSokl+5Kgwb8fh3v8uViXigW0zDRcO1vTlb2ULbossMs4DClYxdBwLc0AuroRwQU3BqJR
 gNZoN8YDdOCqSDqgAtn+glSL/AtFkj3Z3IrJx3GEJznvk+BhwcIQkYbP/tmdzO0NeX/pAB8
 aDtM0ov+4unaff+dBPAWQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267974>

Hi Rupert,

On 2015-04-29 17:23, rupert thurner wrote:
> On Friday, April 10, 2015 at 1:43:30 PM UTC+2, Johannes Schindelin wrote:
>>
>> during the really exciting Git Merge conference, the Git for Windows
>> developers had the opportunity to meet and we managed to whip out a
>> *really* early beta of the upcoming Git for Windows 2.x series.
>>
>> Please keep in mind that we not only changed our entire development
>> environment, but that this change also affects end user installations qu=
ite
>> a bit: as parts of Git are still written in shell and Perl, we have to s=
hip
>> a shell and Perl interpreter, too, which are naturally plucked from the
>> development environment.
>>
>> Of course that implies that there are probably still quite a couple of
>> rough edges. Nevertheless, if you want to have a *really* early glimpse =
at
>> the upcoming major release, feel free to give it a spin:
>> https://git-for-windows.github.io/#download
>>
>>
> after using it now for a couple of weeks every week or so, on windows-7,=
=20
> git-receive-pack.exe hangs from time to time and cannot be killed any mor=
e.=20
> i start it either with
>   git fetch --all -p
>   git push
>=20
> it looks like it does not take any signals at all. no ctrl-c in the mintt=
y,=20
> nor a kill via sysinternals process explorer. up to now only reboot helpe=
d,=20
> but pretty sure i miss something here.

Please, it is really, really crucial that you specify precisely what versio=
n of the package you talk about. It is tempting to say something like "wind=
ows-7" or "I used Git for Windows", but please keep in mind that this is ha=
rdly specific. Windows 7 can be anything between 32-bit and 64-bit, with or=
 without service packs, in administrator mode or user mode. Git for Windows=
 is even worse because we bundle packages into a single installer. However,=
 from the way you describe things I imagine that you used a version of the =
installer. The installer contains a file that lists the individual package =
versions, therefore it should be good enough to specify which version `git =
version` reports.

Please make a point of including all of this information in your bug report=
s to make it easier for the people who you ask for help.

Ciao,
Johannes

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
