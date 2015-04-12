From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Sun, 12 Apr 2015 19:51:29 +0200
Organization: gmx
Message-ID: <b1cc6ba927238fdaa68f685be42002c7@www.dscho.org>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
 <39e23864-b75b-4fef-ab90-3413e4e76900@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: rupert thurner <rupert.thurner@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBKHBVKUQKGQEOG7WBTI@googlegroups.com Sun Apr 12 19:51:39 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBKHBVKUQKGQEOG7WBTI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBKHBVKUQKGQEOG7WBTI@googlegroups.com>)
	id 1YhM2k-0006aj-4T
	for gcvm-msysgit@m.gmane.org; Sun, 12 Apr 2015 19:51:38 +0200
Received: by lbio15 with SMTP id o15sf17280416lbi.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 12 Apr 2015 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=AawxikQeinJl382pfMYrTncLgUmwtH3JQP+iKSdVcaU=;
        b=b/4M5FkWBHa4ZOBhYJP0w4wDbVOnkCWpw2GzTfBPb5ak40S5hz1VqY3W0hDm3S491U
         CGwBiRlLWmBY5QLWISt22yxHdHjTV9pRH0T6OqtLTO5Hpdl7w9nhCsGchKFGc4NkabgK
         MmdqcOdJDEd2/PNI9dKGv/zINM72Fy9oqPic5grxqs9DeUhRqmDMkQLiF63NXLFZgu31
         GGXxdgYJRWTkmag1IhjAKsvSr/p4xvLq9E5G4SvLC4uTPqtjCCApsyA6sOhh8dwmSyxe
         KHFOk760mvsy6dHquFrKqs20gBt8kM5ysjtdiT6RC64dpHX3wVZ64Kw8Y8m16u/SuBQB
         j48A==
X-Received: by 10.152.22.130 with SMTP id d2mr116079laf.7.1428861097273;
        Sun, 12 Apr 2015 10:51:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.29.36 with SMTP id g4ls632348lah.33.gmail; Sun, 12 Apr
 2015 10:51:36 -0700 (PDT)
X-Received: by 10.152.3.70 with SMTP id a6mr1610953laa.0.1428861096153;
        Sun, 12 Apr 2015 10:51:36 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id t6si429308wiz.0.2015.04.12.10.51.36
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2015 10:51:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M0xbD-1ZWiuS0lP5-00v6xD; Sun, 12 Apr 2015 19:51:31
 +0200
In-Reply-To: <39e23864-b75b-4fef-ab90-3413e4e76900@googlegroups.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:o4PXz2Wje17fNhIQ9aLpEBUpcocw5o/hodvpLa28wqrfV3Wa6+0
 gyLEPLC7Z27b2rbDxaI9gDutG0N0yLaj77jg5ZR6EqS0vGNMnJqhNUviAK9qNqkLvn4p67J
 8m6Yoj2YCYS1fQEOnde0g1VwuaZCM9GYm+T5EOQq6D3JNvqWjYIHrd6d7z3II9n/XHWrOsx
 dkCXWT55HviEkfBJPcUDg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267053>

Hi Rupert,

On 2015-04-11 10:37, rupert thurner wrote:
>=20
> three things i do not like it so much:
> * the old distinct icon is replaced by a new one which looks similar to=
=20
> many other programs, like google chrome. would it be possible to set the=
=20
> old icon?

Git 1.9.5 came with the Git icon already (the diamond with the branch in it=
) and now we simply have this "Windowsified". There was so much positive an=
d uplifting feedback about it at the Git Merge (and besides, I really like =
the new icon myself), it is unlikely to change.

> * the prompt is still as slow as before, calculating the branch name on=
=20
> pressing return without option to turn it off

There is no explicit option in the installer to turn it off, but you can ea=
sily edit `/etc/profile.d/git-prompt.sh` to adjust it to your liking.

If you think that more people would want to have an option in the installer=
 to switch it off, you should read https://github.com/git-for-windows/git/w=
iki/Making-an-installer, edit /usr/src/build-extra/installer/install.iss.in=
 after having a look at https://github.com/git-for-windows/build-extra/comm=
it/cbcf69b9 and open a Pull Request.
=20
> * it is talking german to me
>=20
> would it be sufficient to delete
> c:\Apps\gitwin\mingw64\share\locale\de\LC_MESSAGES\
> resp the whole locale directory to let it speak english?

Probably. But the canonical solution is to set the `LC_ALL` or `LANG` envir=
onment variables accordingly.

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
