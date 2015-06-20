From: Robert Dailey <rcdailey@gmail.com>
Subject: Re: Re: 3rd release candidate of Git for Windows 2.x, was
 Re: Release candidate of Git for Windows 2.x is out
Date: Sat, 20 Jun 2015 15:50:21 +0000
Message-ID: <CAAScX1bTct9EQcHqG1MFUaPey=e14EJh-86dCq+PXeEqmq9CZg@mail.gmail.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <b085dab2e617742b690ccb99ba4a3076@www.dscho.org> <1081c3a3-65d7-4065-9cf5-a88d966347b2@googlegroups.com>
 <4e82ca915d0746e477438ed69a21102a@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=20cf302ef58829c28d0518f500d9
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com, 
	msysgit@googlegroups.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>, Jon <jon.forums@gmail.com>
X-From: msysgit+bncBCKNPCNAWECRBSEXS2WAKGQEDVMOJZY@googlegroups.com Sat Jun 20 17:50:34 2015
Return-path: <msysgit+bncBCKNPCNAWECRBSEXS2WAKGQEDVMOJZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCKNPCNAWECRBSEXS2WAKGQEDVMOJZY@googlegroups.com>)
	id 1Z6L2P-0002Cr-SJ
	for gcvm-msysgit@m.gmane.org; Sat, 20 Jun 2015 17:50:34 +0200
Received: by ykp9 with SMTP id 9sf38141046ykp.1
        for <gcvm-msysgit@m.gmane.org>; Sat, 20 Jun 2015 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-spam-checked-in-group:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe;
        bh=Whn/oztSQUKjXZTGOdEdyy01NfYh5Z3sCB7kdT5gdlE=;
        b=oS/eH6x7C6NI4R74x53pjJIaDtkCbX2o0/a1TmXDo+4cbRZD5ILPsIjBmGu2i9OY53
         1LF9pYfL5KRNkEQBPcEC9lex2fkuxOeshYG8k6xhVe9j/bRGuIVN51kIvz4MOcynA5Z1
         vucsveqhU5nc1xbwtARRR3AQZ/WtWGhVXviLIgxyYOrJ5ACckNJRO4uaKunJ5rSyL4HF
         VZaCM2063GnhZ4az45x+Ek+TtgH5JqcnH8JJ1kIR8DNjjgu4FaHK9a/TWteteFcNfNLa
         nx7dweRZFXsPswIEIBpr3kRXQ3Na/9RarRCIfN2k9YS+K412lyEFqOTEj1hcPM7Iswtm
         4uSw==
X-Received: by 10.50.66.141 with SMTP id f13mr172445igt.4.1434815432869;
        Sat, 20 Jun 2015 08:50:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.41.149 with SMTP id p143ls1594442iop.1.gmail; Sat, 20 Jun
 2015 08:50:32 -0700 (PDT)
X-Received: by 10.42.132.65 with SMTP id c1mr19709980ict.7.1434815432506;
        Sat, 20 Jun 2015 08:50:32 -0700 (PDT)
Received: from mail-vn0-x22a.google.com (mail-vn0-x22a.google.com. [2607:f8b0:400c:c0f::22a])
        by gmr-mx.google.com with ESMTPS id z9si145987vdj.0.2015.06.20.08.50.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2015 08:50:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of rcdailey@gmail.com designates 2607:f8b0:400c:c0f::22a as permitted sender) client-ip=2607:f8b0:400c:c0f::22a;
Received: by vnbg190 with SMTP id g190so1653977vnb.11;
        Sat, 20 Jun 2015 08:50:32 -0700 (PDT)
X-Received: by 10.52.5.2 with SMTP id o2mr17490164vdo.97.1434815432341; Sat,
 20 Jun 2015 08:50:32 -0700 (PDT)
In-Reply-To: <4e82ca915d0746e477438ed69a21102a@www.dscho.org>
X-Original-Sender: rcdailey@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of rcdailey@gmail.com designates 2607:f8b0:400c:c0f::22a
 as permitted sender) smtp.mail=rcdailey@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272233>

--20cf302ef58829c28d0518f500d9
Content-Type: text/plain; charset=UTF-8

 Let me add a question to this: how does one add new certs? If there are
multiple files. I have an issue open for this but still no information.
Thanks in advance.

Sorry for top post, replying on my phone.


On Sat, Jun 20, 2015, 10:22 AM Johannes Schindelin <
johannes.schindelin@gmx.de> wrote:

Hi Jon,

On 2015-06-20 16:59, Jon wrote:
> On Saturday, June 20, 2015 at 10:16:09 AM UTC-4, Johannes Schindelin
wrote:
>>
>> I just uploaded the 3rd release candidate for the upcoming Git for
Windows
>> 2.x release. Please find the download link here:
>>
>> https://git-for-windows.github.io/#download
>>
>> Lots of changes since the first release candidate (v2.4.2, I was too
>> swamped to announce the second release candidate -- v2.4.3 -- I published
>> Friday last week, my apologies). Please find them in the release notes:
>>
>>
https://github.com/git-for-windows/build-extra/blob/master/installer/ReleaseNotes.md
>
> 1) Why are there two ssl/certs trees? (e.g. - one is used by git-bash.exe
> and the other git-cmd.exe and cmd/git.exe?)

Please keep in mind that Git for Windows is a hybrid collection of pure
Win32 executables and MSys2 executables (MSys2 is a stripped-down Cygwin
providing a POSIX emulation layer on top of the Win32 API[*1*]). They are
separated into the `/usr/` and the `/mingw64/` directories, respectively
(`/mingw32/` for 32-bit). An example for a pure Win32 executable is
`git.exe` while Perl and Bash are MSys2 executables. In general, we avoid
MSys2 as much as possible: while it provides a nice POSIX emulation layer,
it comes at a noticable performance penalty.

So whenever we can get away with using OpenSSL compiled as pure Win32
library, we do so. Cloning via HTTPS falls into that category.

When it comes to `git-svn` -- something that is needed by many users,
still, and indeed the motivation for the most prolific contributor helping
me with Git for Windows 2.x -- it is not that easy, though: `git-svn` is a
Perl script, our Perl is an MSys2 program and therefore uses OpenSSL
compiled as MSys2 library.

That is the reason why we have separate ssl/ directory structures. One for
MinGW (i.e. pure Win32) programs and one for MSys2 ones.

> 2) Why are INSTALL_DIR/usr/ssl/certs/ca-bundle.crt and
> INSTALL_DIR/mingw64/ssl/certs/ca-bundle.crt different?

We simply use the packages provided by MSys2. The MinGW/MSys2
ca-certificates packages are sometimes out of sync, and that is what you
are seeing here.

Now, theoretically it would be possible to reconcile the different
ca-certificates packages into a single one. The correct way to go about
this would be by contributing to the MSys2 project: that way, not only Git
for Windows but really all MSys2-based projects benefit from it.

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

--20cf302ef58829c28d0518f500d9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
</p>
<p dir=3D"ltr">Let me add a question to this: how does one add new certs? I=
f there are multiple files. I have an issue open for this but still no info=
rmation. Thanks in advance.</p>
<p dir=3D"ltr">Sorry for top post, replying on my phone.<br>
</p>
<p dir=3D"ltr"><br>
On Sat, Jun 20, 2015, 10:22 AM=C2=A0Johannes Schindelin &lt;<a href=3D"mail=
to:johannes.schindelin@gmx.de">johannes.schindelin@gmx.de</a>&gt; wrote:</p=
>
<blockquote><p dir=3D"ltr">Hi Jon,</p>
<p dir=3D"ltr">On 2015-06-20 16:59, Jon wrote:<br>
&gt; On Saturday, June 20, 2015 at 10:16:09 AM UTC-4, Johannes Schindelin w=
rote:<br>
&gt;&gt;<br>
&gt;&gt; I just uploaded the 3rd release candidate for the upcoming Git for=
 Windows<br>
&gt;&gt; 2.x release. Please find the download link here:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://git-for-windows.github.io/#download">https://gi=
t-for-windows.github.io/#download</a><br>
&gt;&gt;<br>
&gt;&gt; Lots of changes since the first release candidate (v2.4.2, I was t=
oo<br>
&gt;&gt; swamped to announce the second release candidate -- v2.4.3 -- I pu=
blished<br>
&gt;&gt; Friday last week, my apologies). Please find them in the release n=
otes:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://github.com/git-for-windows/build-extra/blob/mas=
ter/installer/ReleaseNotes.md">https://github.com/git-for-windows/build-ext=
ra/blob/master/installer/ReleaseNotes.md</a><br>
&gt;<br>
&gt; 1) Why are there two ssl/certs trees? (e.g. - one is used by git-bash.=
exe<br>
&gt; and the other git-cmd.exe and cmd/git.exe?)</p>
<p dir=3D"ltr">Please keep in mind that Git for Windows is a hybrid collect=
ion of pure Win32 executables and MSys2 executables (MSys2 is a stripped-do=
wn Cygwin providing a POSIX emulation layer on top of the Win32 API[*1*]). =
They are separated into the `/usr/` and the `/mingw64/` directories, respec=
tively (`/mingw32/` for 32-bit). An example for a pure Win32 executable is =
`git.exe` while Perl and Bash are MSys2 executables. In general, we avoid M=
Sys2 as much as possible: while it provides a nice POSIX emulation layer, i=
t comes at a noticable performance penalty.</p>
<p dir=3D"ltr">So whenever we can get away with using OpenSSL compiled as p=
ure Win32 library, we do so. Cloning via HTTPS falls into that category.</p=
>
<p dir=3D"ltr">When it comes to `git-svn` -- something that is needed by ma=
ny users, still, and indeed the motivation for the most prolific contributo=
r helping me with Git for Windows 2.x -- it is not that easy, though: `git-=
svn` is a Perl script, our Perl is an MSys2 program and therefore uses Open=
SSL compiled as MSys2 library.</p>
<p dir=3D"ltr">That is the reason why we have separate ssl/ directory struc=
tures. One for MinGW (i.e. pure Win32) programs and one for MSys2 ones.</p>
<p dir=3D"ltr">&gt; 2) Why are INSTALL_DIR/usr/ssl/certs/ca-bundle.crt and<=
br>
&gt; INSTALL_DIR/mingw64/ssl/certs/ca-bundle.crt different?</p>
<p dir=3D"ltr">We simply use the packages provided by MSys2. The MinGW/MSys=
2 ca-certificates packages are sometimes out of sync, and that is what you =
are seeing here.</p>
<p dir=3D"ltr">Now, theoretically it would be possible to reconcile the dif=
ferent ca-certificates packages into a single one. The correct way to go ab=
out this would be by contributing to the MSys2 project: that way, not only =
Git for Windows but really all MSys2-based projects benefit from it.</p>
</blockquote>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--20cf302ef58829c28d0518f500d9--
