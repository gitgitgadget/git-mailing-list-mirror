From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: 3rd release candidate of Git for Windows 2.x, was
 Re: Release candidate of Git for Windows 2.x is out
Date: Sat, 20 Jun 2015 17:21:52 +0200
Organization: gmx
Message-ID: <4e82ca915d0746e477438ed69a21102a@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
 <1081c3a3-65d7-4065-9cf5-a88d966347b2@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
 git-for-windows@googlegroups.com
To: Jon <jon.forums@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBGEKS2WAKGQE4XNBXVI@googlegroups.com Sat Jun 20 17:22:01 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBGEKS2WAKGQE4XNBXVI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBGEKS2WAKGQE4XNBXVI@googlegroups.com>)
	id 1Z6Kan-0001qi-7Q
	for gcvm-msysgit@m.gmane.org; Sat, 20 Jun 2015 17:22:01 +0200
Received: by wggz12 with SMTP id z12sf38831015wgg.0
        for <gcvm-msysgit@m.gmane.org>; Sat, 20 Jun 2015 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=8S2+iKfQKACUR5qvgF8ggd4uGDZ9GWEuLx8FsQH+R8c=;
        b=RgRsSbAaXPv5L7eRRmTp1bI62nUlqTc0Fn1yIa6Y+U2UM9j2QFQSdpPgDIUdoS/7+B
         0owAPaMe5nu+CtBo7oP0aUGyfmMlX4SqwgYEskWm50CTjcyso5YyUn5HkmGu+qgRubg/
         I9RmhsUBzASayfpRU9gqfnRTR2Gi4GkU/PZJrJjmJQntBQciWMBvANnoZplHf66MpMHI
         2+UAzRBo6G66XBELIXz0ns5rYHDBsLfM6dp5ZPkIbvKcKwO7qDa2wNb+14PJJCOgEqkl
         zOcmP6YN65uWu87nCyP0MyYg2AD4ktniX5HSDhusaiRPTH11/dTNA6LyBQFWnZ54 
X-Received: by 10.152.87.170 with SMTP id az10mr159100lab.29.1434813720703;
        Sat, 20 Jun 2015 08:22:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.165 with SMTP id p5ls12433lal.68.gmail; Sat, 20 Jun
 2015 08:21:59 -0700 (PDT)
X-Received: by 10.112.118.162 with SMTP id kn2mr20211801lbb.22.1434813719627;
        Sat, 20 Jun 2015 08:21:59 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id gt9si442104wib.2.2015.06.20.08.21.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2015 08:21:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mbxdm-1ZNRln1tlG-00JJpS; Sat, 20 Jun 2015 17:21:53
 +0200
In-Reply-To: <1081c3a3-65d7-4065-9cf5-a88d966347b2@googlegroups.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:arNoQD/UAq1ezUVI1Fgs/MpA3RRWyFEMhg9hIkoZi2sLBl3qH/v
 X0gluSi/bqaTABgY1g1tq7fVbfE4ptTI2Kmt1joEKNxi1DDzN7dimizHkct0UI0Az+0DbQz
 1vxbeewnGJFLEKzwg5pIU/BTo/ABXtOTDn/muTiHfGIk33ilOFP2YloOr+GJyF8H94Elq0r
 ovw4W7uI4Fi7rntggX0gA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272231>

Hi Jon,

On 2015-06-20 16:59, Jon wrote:
> On Saturday, June 20, 2015 at 10:16:09 AM UTC-4, Johannes Schindelin wrot=
e:
>>
>> I just uploaded the 3rd release candidate for the upcoming Git for Windo=
ws
>> 2.x release. Please find the download link here:
>>
>> https://git-for-windows.github.io/#download
>>
>> Lots of changes since the first release candidate (v2.4.2, I was too
>> swamped to announce the second release candidate -- v2.4.3 -- I publishe=
d
>> Friday last week, my apologies). Please find them in the release notes:
>>
>> https://github.com/git-for-windows/build-extra/blob/master/installer/Rel=
easeNotes.md
>=20
> 1) Why are there two ssl/certs trees? (e.g. - one is used by git-bash.exe=
=20
> and the other git-cmd.exe and cmd/git.exe?)

Please keep in mind that Git for Windows is a hybrid collection of pure Win=
32 executables and MSys2 executables (MSys2 is a stripped-down Cygwin provi=
ding a POSIX emulation layer on top of the Win32 API[*1*]). They are separa=
ted into the `/usr/` and the `/mingw64/` directories, respectively (`/mingw=
32/` for 32-bit). An example for a pure Win32 executable is `git.exe` while=
 Perl and Bash are MSys2 executables. In general, we avoid MSys2 as much as=
 possible: while it provides a nice POSIX emulation layer, it comes at a no=
ticable performance penalty.

So whenever we can get away with using OpenSSL compiled as pure Win32 libra=
ry, we do so. Cloning via HTTPS falls into that category.

When it comes to `git-svn` -- something that is needed by many users, still=
, and indeed the motivation for the most prolific contributor helping me wi=
th Git for Windows 2.x -- it is not that easy, though: `git-svn` is a Perl =
script, our Perl is an MSys2 program and therefore uses OpenSSL compiled as=
 MSys2 library.

That is the reason why we have separate ssl/ directory structures. One for =
MinGW (i.e. pure Win32) programs and one for MSys2 ones.

> 2) Why are INSTALL_DIR/usr/ssl/certs/ca-bundle.crt and=20
> INSTALL_DIR/mingw64/ssl/certs/ca-bundle.crt different?

We simply use the packages provided by MSys2. The MinGW/MSys2 ca-certificat=
es packages are sometimes out of sync, and that is what you are seeing here=
.

Now, theoretically it would be possible to reconcile the different ca-certi=
ficates packages into a single one. The correct way to go about this would =
be by contributing to the MSys2 project: that way, not only Git for Windows=
 but really all MSys2-based projects benefit from it.

Ciao,
Johannes

Footnote *1*: https://msys2.github.io/

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
