From: Ken Ismert <kismert@gmail.com>
Subject: Re: Script for handling UTF-16 files
Date: Thu, 11 Apr 2013 12:11:25 -0700 (PDT)
Message-ID: <62acca4c-9328-4c38-bf35-6db55d45c895@googlegroups.com>
References: <608a349b-cc71-4cba-9197-3783049e9f47@googlegroups.com>
 <5165B6AC.5090403@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_426_25831019.1365707485985"
Cc: Ken Ismert <kismert@gmail.com>, git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCDP3P7LRYJBBXUVTSFQKGQEUC6LZ2Y@googlegroups.com Thu Apr 11 21:11:28 2013
Return-path: <msysgit+bncBCDP3P7LRYJBBXUVTSFQKGQEUC6LZ2Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ia0-f192.google.com ([209.85.210.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCDP3P7LRYJBBXUVTSFQKGQEUC6LZ2Y@googlegroups.com>)
	id 1UQMu8-0003sD-4Y
	for gcvm-msysgit@m.gmane.org; Thu, 11 Apr 2013 21:11:28 +0200
Received: by mail-ia0-f192.google.com with SMTP id k27sf532841iad.29
        for <gcvm-msysgit@m.gmane.org>; Thu, 11 Apr 2013 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:date:from:to:cc:message-id
         :in-reply-to:references:subject:mime-version:x-original-sender
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=fy5pbF2ezIh2PA7sjb1wH88WJDVtpbKHO3CBMIQEv0k=;
        b=pOIVW3RPfciMnZafTApJpWYTxWBwDR+BZz9i153fOJBCN7h+LVd90TFImOIUZA02Yl
         NWatlVM9tp9ZqvbF+reKO0OaKya3diguKk6d+yJsklYD2AB9Vm0oshvbBOc1BCsywJhJ
         NzsE+c3qvFRAmrHNmpnPWId4nHiBcq64rYy9GYql6pB8P1+A3dOX/4thEyJjReJ0nzE8
         sj0mqopE6ffbWbHxbdkp1G37M6FZPWliL0mOVgfKMT7pbcyIX2RidpZBbqDc0mdEbXg5
         o05ddmDNs9SNY10JDWo7jTqx+f93d7Ry2e5gtx8ZPk1ruyakOQW2JDE7SwHxjEC5TxYI
         cASQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:date:from:to:cc:message-id
         :in-reply-to:references:subject:mime-version:x-original-sender
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=fy5pbF2ezIh2PA7sjb1wH88WJDVtpbKHO3CBMIQEv0k=;
        b=U/D0txVqN7kDGjcy+F7Ac2fRAP9mMpu2PKYCwImp8lHCjihPHD9fJVemGr3yXUrZtV
         mByw+N3BAHiKq+LjdvrTBaLYBGbwbTW856RNLykSZQcc1oPliNhB26XTfRYB2GjPQ1Wg
         7a+016clvb7v6x5PCKtyP9jzpl4TEp8bwRVhu2B87183BZYEIfAaQ0/cXhvTU3vQVUS3
         MBKDd9+VsyMkMwdDx1uBg8UF75el/q2RzSJE1oSFi5wIApl40gBSxIGk1ibgv7hWVXpA
         9K5Y6ff/B7zPVn+bQv2NqPkKNi583cJKVRBxUdbQ/7kpUxzd0RW8ihwesDUr+RrymJAc
         wDVw==
X-Received: by 10.49.98.65 with SMTP id eg1mr721407qeb.2.1365707487073;
        Thu, 11 Apr 2013 12:11:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.127.111 with SMTP id nf15ls1091957qeb.25.gmail; Thu, 11 Apr
 2013 12:11:26 -0700 (PDT)
X-Received: by 10.49.24.134 with SMTP id u6mr740830qef.24.1365707486403;
        Thu, 11 Apr 2013 12:11:26 -0700 (PDT)
In-Reply-To: <5165B6AC.5090403@gmail.com>
X-Original-Sender: kismert@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220915>

------=_Part_426_25831019.1365707485985
Content-Type: text/plain; charset=ISO-8859-1


Karsten, 

There's also an 'encoding' attribute and a 'gui.encoding' setting which in 
> theory should solve your issue (i.e. specify encoding of files for display 
> by GUI tools). I don't know if Git Extensions supports that, or whether its 
> supposed to work for binary files at all. 
>

I played around with this, and neither 'encoding' or 'gui.encoding' solves 
my problem in Get Extensions or Git Gui.

According to the man page, I would put this entry in my .gitattributes:
*.txt encoding=utf-8

This sounds rather tautological -- "Why yes, I do want to display my UTF-16 
file as text!"

More to the point, since Git *doesn't know* the original encoding of a 
'non-standard' Unicode file, how can it possibly know how to convert it to 
UTF-8?

So, 'encoding' and 'gui.encoding' seem to be poorly conceived, and 
certainly aren't helpful for the Windows UTF-16 problem.

-Ken

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.



------=_Part_426_25831019.1365707485985
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>Karsten, <br><br><blockquote style=3D"margin: 0px 0px 0px 0.8ex; border=
-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;" class=3D"gmail_quo=
te">There's also an 'encoding' attribute and a 'gui.encoding' setting which=
=20
in theory should solve your issue (i.e. specify encoding of files for=20
display by GUI tools). I don't know if Git Extensions supports that, or=20
whether its supposed to work for binary files at all.
<br></blockquote><br>I played around with this, and neither 'encoding' or '=
gui.encoding' solves my problem in Get Extensions or Git Gui.<br><br>Accord=
ing to the man page, I would put this entry in my .gitattributes:<br><div s=
tyle=3D"margin-left: 40px;"><span style=3D"font-family: courier new,monospa=
ce;">*.txt encoding=3Dutf-8</span><br></div><br>This sounds rather tautolog=
ical -- "Why yes, I do want to display my UTF-16 file as text!"<br><br>More=
 to the point, since Git *doesn't know* the original encoding of a 'non-sta=
ndard' Unicode file, how can it possibly know how to convert it to UTF-8?<b=
r><br>So,  'encoding' and 'gui.encoding' seem to be poorly conceived, and c=
ertainly aren't helpful for the Windows UTF-16 problem.<br><br>-Ken<br>

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
&nbsp;<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />
&nbsp;<br />
&nbsp;<br />

------=_Part_426_25831019.1365707485985--
