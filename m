From: =?UTF-8?Q?P=C4=93teris_K=C4=BCavi=C5=86=C5=A1?= <p.klavins@gmail.com>
Subject: Re: Bug in EOL conversion?
Date: Wed, 23 Jan 2013 15:04:38 -0800 (PST)
Message-ID: <97b95a2c-1c51-48b9-aff7-33af35b4f049@googlegroups.com>
References: <CANrZfmGXtKcB+i_xhNJELftRc1pC2TJKKhOieHm=5Qkni9OKrA@mail.gmail.com>
 <063ABD39C46D492391698E400A7D1FA9@PhilipOakley>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_727_28829220.1358982279029"
Cc: Stefan Norgren <stefan.norgren@gmail.com>, git@vger.kernel.org, 
	Philip Oakley <philipoakley@iee.org>
To: msysgit@googlegroups.com
X-From: msysgit+bncBC76BK4LQMIBBCGZQGEAKGQEJWUPY4Q@googlegroups.com Thu Jan 24 00:05:03 2013
Return-path: <msysgit+bncBC76BK4LQMIBBCGZQGEAKGQEJWUPY4Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f188.google.com ([209.85.220.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC76BK4LQMIBBCGZQGEAKGQEJWUPY4Q@googlegroups.com>)
	id 1Ty9NM-0008Nq-4l
	for gcvm-msysgit@m.gmane.org; Thu, 24 Jan 2013 00:05:00 +0100
Received: by mail-vc0-f188.google.com with SMTP id p16sf552312vcq.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Jan 2013 15:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:date:from:to:cc:message-id
         :in-reply-to:references:subject:mime-version:x-original-sender
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=9Hwb45DT97VF0B9rJgc9wJtIIGaNs+i2X0k3w+nB1pQ=;
        b=bs1mCqG3k9fWOBU5NVRKpmusU6bPEmbzSWg9+dKX5HGqbu8heYKxNQwDBKhQkELY3D
         8KjJJHghhKUZacSTNhsdDCnbmwCBe+JuNQD98AIZr5+DUg086v1uiN3eApUt9HT57SuC
         0QFfVglplZfNB5SeON0J4/iCvvDISwf1hdSOWzjYTB2iVn3HJRjlQnsT5FBJ0/jZxBXU
         scrWsLEADAQ0AGCc3hAJ8bJKJMzu7aJQfkNT8tnbxTNZ0uF8M3A/OGhwn4MrnW1+vkBG
         2eM8djUTseZF6S2Rhiymw1qYqfoJHf64yvkybxDSTnvPUUIcMNQnNc19u/MzGKlU56F9
         oAAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:date:from:to:cc:message-id
         :in-reply-to:references:subject:mime-version:x-original-sender
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=9Hwb45DT97VF0B9rJgc9wJtIIGaNs+i2X0k3w+nB1pQ=;
        b=u2TpWbIzIOya+Bd+3IJFG10NHHk6s6Q43LwQPMq7oTve7nyeHlcJ0jakD/KFt6bPAr
         2UqV0vTkTgOjhNgepIJORfbKtXIcmlhUcchentOlxluwpew8n3fKnJTyBSrrOLssXyd2
         aWAoitXhO3PUNubXzdaIn4HtQa8wsyNPf61+SwEXjbNBlwRFJWsu22Z+AzWTzY4icZ2e
         5L7ARuLSm/oIzBlzNaQpcNvknu1EuWwVVH4GCDeFnPZqXUVOAN9lGax9pok60tA1pXTp
         HTZ7DWLhxXP2Zq11f7lZV6Qbe0ZjixsD3zw6NWDGsoqb3lmyJzq7QYXxg9vxXpwhH7vg
         JjvA==
X-Received: by 10.50.217.201 with SMTP id pa9mr18570igc.17.1358982281270;
        Wed, 23 Jan 2013 15:04:41 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.108.197 with SMTP id hm5ls379385igb.7.gmail; Wed, 23 Jan
 2013 15:04:39 -0800 (PST)
X-Received: by 10.50.191.131 with SMTP id gy3mr34231igc.1.1358982279508;
        Wed, 23 Jan 2013 15:04:39 -0800 (PST)
In-Reply-To: <063ABD39C46D492391698E400A7D1FA9@PhilipOakley>
X-Original-Sender: p.klavins@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214376>

------=_Part_727_28829220.1358982279029
Content-Type: text/plain; charset=ISO-8859-1

Hi Philip

You are mis-reading the warning. Git is acting as it does for the 
recommended settings for Windows. The 'repository' under the .git directory 
ALWAYS contains files with LF-only endings (unless you desperately override 
the settings). The warning was telling you that when you were checking in 
the file, it found that you have 'abnormal' line endings (for Windows) in 
the file in your checkout (just LF endings) and so tried to be helpful in 
saying that if someone else were to check the file out from your repository 
on Windows, they would get CRLF in the file on checkout. But the warning 
says 'the file will be checked in with CRLF' or similar because you are not 
supposed to know that the repository actually strips the CR and stores the 
file with LF-only. As you found out when you deleted the file and checked 
out a fresh copy, Git DID give you a copy of the file with CRLF endings, as 
how it said it had stored it in the repository! This translation between 
CRLF on disk and LF-only in the repository is done so that the same set of 
files would have the same repository contents, regardless of whether they 
were originally created on Windows or Linux. On Windows, files are normally 
created WITH CRLF endings, and on Linux with LF-only endings. In both 
cases, the same otherwise identical files would have identical, LF-only, 
copies in the actual repository in the .git directory.

Peter

On Wednesday, 23 January 2013 21:55:13 UTC, Philip Oakley wrote:
>
> The msysgit list msy...@googlegroups.com <javascript:> may be a better 
> place for 
> this. 
>
> It is likely that you have a windows specific EOL conversion set within 
> the wider config's (i.e.  --system, --global). You may have 
> core.safecrlf set which does a round trip test so tests the conversion 
> both ways. 
>
> The normal canonical line ending choice is LF in the repo. 
>
> I don't have a W7 install to compare against. 
>
> Philip 
>
> ----- Original Message ----- 
> From: "Stefan Norgren" <stefan....@gmail.com <javascript:>> 
> To: <g...@vger.kernel.org <javascript:>> 
> Sent: Wednesday, January 23, 2013 2:44 AM 
> Subject: Bug in EOL conversion? 
>
>
> > Hi, 
> > 
> > The EOL conversion does not behave as indicated by output message from 
> > add and commit. Here is my test case executed on Windows 7 64 bit. 
> > 
> > 
> > $ git --version 
> > git version 1.8.0.msysgit.0 
> > $ which git 
> > /cygdrive/c/Program Files (x86)/Git/cmd/git 
> > $ git config --list 
> > core.symlinks=false 
> > core.autocrlf=true 
> > color.diff=auto 
> > color.status=auto 
> > color.branch=auto 
> > color.interactive=true 
> > pack.packsizelimit=2g 
> > help.format=html 
> > http.sslcainfo=/bin/curl-ca-bundle.crt 
> > sendemail.smtpserver=/bin/msmtp.exe 
> > diff.astextplain.textconv=astextplain 
> > rebase.autosquash=true 
> > user.name=Stefan 
> > user.email=stefan@---.com 
> > core.repositoryformatversion=0 
> > core.filemode=false 
> > core.bare=false 
> > core.logallrefupdates=true 
> > core.symlinks=false 
> > core.ignorecase=true 
> > core.hidedotfiles=dotGitOnly 
> > 
> > -- Note core.autocrlf=true. 
> > -- Created withcrlf.txt with one character and one CRLF line feed. 
> > File size 3 bytes. 
> > -- Created withlf.txt with one character and one LF line feed. File 
> > size 2 bytes. 
> > -- Now let's init repository. 
> > 
> > $ git init 
> > Initialized empty Git repository in D:/Dev/workspaces/gittest/.git/ 
> > $ ls -la 
> > total 10 
> > d---------+ 1 Stefan None 0 Jan 23 02:12 . 
> > d---------+ 1 Stefan None 0 Jan 23 02:10 .. 
> > d---------+ 1 Stefan None 0 Jan 23 02:13 .git 
> > ----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt 
> > ----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt 
> > 
> > -- Note no .gitattributes file that will affect EOL conversion. 
> > 
> > $ ls -la .git/info/ 
> > total 5 
> > d---------+ 1 Stefan None   0 Jan 23 02:12 . 
> > d---------+ 1 Stefan None   0 Jan 23 02:13 .. 
> > ----------+ 1 Stefan None 240 Jan 23 02:12 exclude 
> > 
> > -- Note no attribute file in .git/info/ that will affect EOL 
> > conversion. 
> > 
> > $ git add * 
> > warning: LF will be replaced by CRLF in withlf.txt. 
> > The file will have its original line endings in your working 
> > directory. 
> > $ git commit -m 'Testing EOL' 
> > [master (root-commit) 9a0b2f5] Testing EOL 
> > 2 files changed, 2 insertions(+) 
> > create mode 100644 withcrlf.txt 
> > create mode 100644 withlf.txt 
> > warning: LF will be replaced by CRLF in withlf.txt. 
> > The file will have its original line endings in your working 
> > directory. 
> > $ ls -la 
> > total 10 
> > d---------+ 1 Stefan None 0 Jan 23 02:12 . 
> > d---------+ 1 Stefan None 0 Jan 23 02:10 .. 
> > d---------+ 1 Stefan None 0 Jan 23 02:22 .git 
> > ----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt 
> > ----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt 
> > 
> > -- So no changes (see file size) to files in working directory. This 
> > is expected and according to output warning from add and commit. 
> > 
> > -- Now lets look in the repository 
> > 
> > $ git ls-tree -l HEAD withcrlf.txt 
> > 100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d       2 
> > withcrlf.txt 
> > $ git ls-tree -l HEAD withlf.txt 
> > 100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d       2 
> > withlf.txt 
> > 
> > -- Note that size of withlf.txt is 2 in repository indicating that LF 
> > was not replaced by CRLF in withlf.txt as indicated in output from add 
> > and commit. Also note that size of withcrlf.txt is also 2 in 
> > repository so it looks like CRLF was replaced by LF in withcrlf.txt. 
> > To verify I will delete the files from working directory, turn off EOL 
> > conversion, checkout files and look at file endings in the working 
> > directory. 
> > 
> > $ rm with* 
> > $ ls -la 
> > total 8 
> > d---------+ 1 Stefan None 0 Jan 23 02:31 . 
> > d---------+ 1 Stefan None 0 Jan 23 02:10 .. 
> > d---------+ 1 Stefan None 0 Jan 23 02:22 .git 
> > $ git status 
> > # On branch master 
> > # Changes not staged for commit: 
> > #   (use "git add/rm <file>..." to update what will be committed) 
> > #   (use "git checkout -- <file>..." to discard changes in working 
> > directory) 
> > # 
> > #       deleted:    withcrlf.txt 
> > #       deleted:    withlf.txt 
> > # 
> > no changes added to commit (use "git add" and/or "git commit -a") 
> > $ git config --global core.autocrlf false 
> > $ git config --global core.autocrlf 
> > false 
> > $ git checkout -- with* 
> > $ ls -la 
> > total 10 
> > d---------+ 1 Stefan None 0 Jan 23 02:38 . 
> > d---------+ 1 Stefan None 0 Jan 23 02:10 .. 
> > d---------+ 1 Stefan None 0 Jan 23 02:38 .git 
> > ----------+ 1 Stefan None 2 Jan 23 02:38 withcrlf.txt 
> > ----------+ 1 Stefan None 2 Jan 23 02:38 withlf.txt 
> > 
> > -- Both files in working directory files now have LF line endings 
> > confirming that files in repository have LF file endings. Either the 
> > output message of add and commit is wrong or the behavior of the EOL 
> > conversion is wrong... or... have I missed something...? 
> > 
> >   /Stefan 
> > -- 
> > To unsubscribe from this list: send the line "unsubscribe git" in 
> > the body of a message to majo...@vger.kernel.org <javascript:> 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html 
> > 
> > 
> > ----- 
> > No virus found in this message. 
> > Checked by AVG - www.avg.com 
> > Version: 2013.0.2890 / Virus Database: 2639/6050 - Release Date: 
> > 01/22/13 
> > 
>
>

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

------=_Part_727_28829220.1358982279029
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philip<div><br></div><div>You are mis-reading the warning. Git is acting=
 as it does for the recommended settings for Windows. The 'repository' unde=
r the .git directory ALWAYS contains files with LF-only endings (unless you=
 desperately override the settings). The warning was telling you that when =
you were checking in the file, it found that you have 'abnormal' line endin=
gs (for Windows) in the file in your checkout (just LF endings) and so trie=
d to be helpful in saying that if someone else were to check the file out f=
rom your repository on Windows, they would get CRLF in the file on checkout=
. But the warning says 'the file will be checked in with CRLF' or similar b=
ecause you are not supposed to know that the repository actually strips the=
 CR and stores the file with LF-only. As you found out when you deleted the=
 file and checked out a fresh copy, Git DID give you a copy of the file wit=
h CRLF endings, as how it said it had stored it in the repository! This tra=
nslation between CRLF on disk and LF-only in the repository is done so that=
 the same set of files would have the same repository contents, regardless =
of whether they were originally created on Windows or Linux. On Windows, fi=
les are normally created WITH CRLF endings, and on Linux with LF-only endin=
gs. In both cases, the same otherwise identical files would have identical,=
 LF-only, copies in the actual repository in the .git directory.</div><div>=
<br></div><div>Peter<br><br>On Wednesday, 23 January 2013 21:55:13 UTC, Phi=
lip Oakley  wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;marg=
in-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">The msysgit =
list <a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"IMi=
tpSiTVNsJ">msy...@googlegroups.com</a> may be a better place for=20
<br>this.
<br>
<br>It is likely that you have a windows specific EOL conversion set within=
=20
<br>the wider config's (i.e. &nbsp;--system, --global). You may have=20
<br>core.safecrlf set which does a round trip test so tests the conversion=
=20
<br>both ways.
<br>
<br>The normal canonical line ending choice is LF in the repo.
<br>
<br>I don't have a W7 install to compare against.
<br>
<br>Philip
<br>
<br>----- Original Message -----=20
<br>From: "Stefan Norgren" &lt;<a href=3D"javascript:" target=3D"_blank" gd=
f-obfuscated-mailto=3D"IMitpSiTVNsJ">stefan....@gmail.com</a>&gt;
<br>To: &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=
=3D"IMitpSiTVNsJ">g...@vger.kernel.org</a>&gt;
<br>Sent: Wednesday, January 23, 2013 2:44 AM
<br>Subject: Bug in EOL conversion?
<br>
<br>
<br>&gt; Hi,
<br>&gt;
<br>&gt; The EOL conversion does not behave as indicated by output message =
from
<br>&gt; add and commit. Here is my test case executed on Windows 7 64 bit.
<br>&gt;
<br>&gt;
<br>&gt; $ git --version
<br>&gt; git version 1.8.0.msysgit.0
<br>&gt; $ which git
<br>&gt; /cygdrive/c/Program Files (x86)/Git/cmd/git
<br>&gt; $ git config --list
<br>&gt; core.symlinks=3Dfalse
<br>&gt; core.autocrlf=3Dtrue
<br>&gt; color.diff=3Dauto
<br>&gt; color.status=3Dauto
<br>&gt; color.branch=3Dauto
<br>&gt; color.interactive=3Dtrue
<br>&gt; pack.packsizelimit=3D2g
<br>&gt; help.format=3Dhtml
<br>&gt; http.sslcainfo=3D/bin/curl-ca-<wbr>bundle.crt
<br>&gt; sendemail.smtpserver=3D/bin/<wbr>msmtp.exe
<br>&gt; diff.astextplain.textconv=3D<wbr>astextplain
<br>&gt; rebase.autosquash=3Dtrue
<br>&gt; <a href=3D"http://user.name" target=3D"_blank">user.name</a>=3DSte=
fan
<br>&gt; user.email=3Dstefan@---.com
<br>&gt; core.repositoryformatversion=3D0
<br>&gt; core.filemode=3Dfalse
<br>&gt; core.bare=3Dfalse
<br>&gt; core.logallrefupdates=3Dtrue
<br>&gt; core.symlinks=3Dfalse
<br>&gt; core.ignorecase=3Dtrue
<br>&gt; core.hidedotfiles=3DdotGitOnly
<br>&gt;
<br>&gt; -- Note core.autocrlf=3Dtrue.
<br>&gt; -- Created withcrlf.txt with one character and one CRLF line feed.
<br>&gt; File size 3 bytes.
<br>&gt; -- Created withlf.txt with one character and one LF line feed. Fil=
e
<br>&gt; size 2 bytes.
<br>&gt; -- Now let's init repository.
<br>&gt;
<br>&gt; $ git init
<br>&gt; Initialized empty Git repository in D:/Dev/workspaces/gittest/.<wb=
r>git/
<br>&gt; $ ls -la
<br>&gt; total 10
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:12 .
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:10 ..
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:13 .git
<br>&gt; ----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt
<br>&gt; ----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt
<br>&gt;
<br>&gt; -- Note no .gitattributes file that will affect EOL conversion.
<br>&gt;
<br>&gt; $ ls -la .git/info/
<br>&gt; total 5
<br>&gt; d---------+ 1 Stefan None &nbsp; 0 Jan 23 02:12 .
<br>&gt; d---------+ 1 Stefan None &nbsp; 0 Jan 23 02:13 ..
<br>&gt; ----------+ 1 Stefan None 240 Jan 23 02:12 exclude
<br>&gt;
<br>&gt; -- Note no attribute file in .git/info/ that will affect EOL=20
<br>&gt; conversion.
<br>&gt;
<br>&gt; $ git add *
<br>&gt; warning: LF will be replaced by CRLF in withlf.txt.
<br>&gt; The file will have its original line endings in your working=20
<br>&gt; directory.
<br>&gt; $ git commit -m 'Testing EOL'
<br>&gt; [master (root-commit) 9a0b2f5] Testing EOL
<br>&gt; 2 files changed, 2 insertions(+)
<br>&gt; create mode 100644 withcrlf.txt
<br>&gt; create mode 100644 withlf.txt
<br>&gt; warning: LF will be replaced by CRLF in withlf.txt.
<br>&gt; The file will have its original line endings in your working=20
<br>&gt; directory.
<br>&gt; $ ls -la
<br>&gt; total 10
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:12 .
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:10 ..
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:22 .git
<br>&gt; ----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt
<br>&gt; ----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt
<br>&gt;
<br>&gt; -- So no changes (see file size) to files in working directory. Th=
is
<br>&gt; is expected and according to output warning from add and commit.
<br>&gt;
<br>&gt; -- Now lets look in the repository
<br>&gt;
<br>&gt; $ git ls-tree -l HEAD withcrlf.txt
<br>&gt; 100644 blob d00491fd7e5bb6fa28c517a0bb32b8<wbr>b506539d4d &nbsp; &=
nbsp; &nbsp; 2=20
<br>&gt; withcrlf.txt
<br>&gt; $ git ls-tree -l HEAD withlf.txt
<br>&gt; 100644 blob d00491fd7e5bb6fa28c517a0bb32b8<wbr>b506539d4d &nbsp; &=
nbsp; &nbsp; 2=20
<br>&gt; withlf.txt
<br>&gt;
<br>&gt; -- Note that size of withlf.txt is 2 in repository indicating that=
 LF
<br>&gt; was not replaced by CRLF in withlf.txt as indicated in output from=
 add
<br>&gt; and commit. Also note that size of withcrlf.txt is also 2 in
<br>&gt; repository so it looks like CRLF was replaced by LF in withcrlf.tx=
t.
<br>&gt; To verify I will delete the files from working directory, turn off=
 EOL
<br>&gt; conversion, checkout files and look at file endings in the working
<br>&gt; directory.
<br>&gt;
<br>&gt; $ rm with*
<br>&gt; $ ls -la
<br>&gt; total 8
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:31 .
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:10 ..
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:22 .git
<br>&gt; $ git status
<br>&gt; # On branch master
<br>&gt; # Changes not staged for commit:
<br>&gt; # &nbsp; (use "git add/rm &lt;file&gt;..." to update what will be =
committed)
<br>&gt; # &nbsp; (use "git checkout -- &lt;file&gt;..." to discard changes=
 in working=20
<br>&gt; directory)
<br>&gt; #
<br>&gt; # &nbsp; &nbsp; &nbsp; deleted: &nbsp; &nbsp;withcrlf.txt
<br>&gt; # &nbsp; &nbsp; &nbsp; deleted: &nbsp; &nbsp;withlf.txt
<br>&gt; #
<br>&gt; no changes added to commit (use "git add" and/or "git commit -a")
<br>&gt; $ git config --global core.autocrlf false
<br>&gt; $ git config --global core.autocrlf
<br>&gt; false
<br>&gt; $ git checkout -- with*
<br>&gt; $ ls -la
<br>&gt; total 10
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:38 .
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:10 ..
<br>&gt; d---------+ 1 Stefan None 0 Jan 23 02:38 .git
<br>&gt; ----------+ 1 Stefan None 2 Jan 23 02:38 withcrlf.txt
<br>&gt; ----------+ 1 Stefan None 2 Jan 23 02:38 withlf.txt
<br>&gt;
<br>&gt; -- Both files in working directory files now have LF line endings
<br>&gt; confirming that files in repository have LF file endings. Either t=
he
<br>&gt; output message of add and commit is wrong or the behavior of the E=
OL
<br>&gt; conversion is wrong... or... have I missed something...?
<br>&gt;
<br>&gt; &nbsp; /Stefan
<br>&gt; --
<br>&gt; To unsubscribe from this list: send the line "unsubscribe git" in
<br>&gt; the body of a message to <a href=3D"javascript:" target=3D"_blank"=
 gdf-obfuscated-mailto=3D"IMitpSiTVNsJ">majo...@vger.kernel.org</a>
<br>&gt; More majordomo info at &nbsp;<a href=3D"http://vger.kernel.org/maj=
ordomo-info.html" target=3D"_blank">http://vger.kernel.org/<wbr>majordomo-i=
nfo.html</a>
<br>&gt;
<br>&gt;
<br>&gt; -----
<br>&gt; No virus found in this message.
<br>&gt; Checked by AVG - <a href=3D"http://www.avg.com" target=3D"_blank">=
www.avg.com</a>
<br>&gt; Version: 2013.0.2890 / Virus Database: 2639/6050 - Release Date:=
=20
<br>&gt; 01/22/13
<br>&gt;=20
<br>
<br></blockquote></div>

<p></p>

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

------=_Part_727_28829220.1358982279029--
