From: =?UTF-8?B?QnJhbmtvIMSMaWJlag==?= <brane@wandisco.com>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and
 skelta mode
Date: Sat, 06 Jul 2013 02:34:23 +0200
Organization: WANdisco
Message-ID: <51D7660F.6070901@wandisco.com>
References: <kr6uvc$p8a$1@ger.gmane.org> <51D7072A.6080909@wandisco.com> <kr75h0$qg5$1@ger.gmane.org> <51D7362B.1040803@wandisco.com> <kr7il5$n0p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------080109000601050907070703"
Cc: Subversion Development <dev@subversion.apache.org>, 
 git@vger.kernel.org
To: users@subversion.apache.org
X-From: dev-return-27430-gcvsd-dev=m.gmane.org@subversion.apache.org Sat Jul 06 02:34:55 2013
Return-path: <dev-return-27430-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@plane.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-27430-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1UvGSk-0002CM-Ma
	for gcvsd-dev@plane.gmane.org; Sat, 06 Jul 2013 02:34:55 +0200
Received: (qmail 71679 invoked by uid 500); 6 Jul 2013 00:34:53 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 71627 invoked by uid 99); 6 Jul 2013 00:34:53 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Sat, 06 Jul 2013 00:34:53 +0000
X-ASF-Spam-Status: No, hits=1.5 required=5.0
	tests=HTML_MESSAGE,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of brane@wandisco.com designates 209.85.215.171 as permitted sender)
Received: from [209.85.215.171] (HELO mail-ea0-f171.google.com) (209.85.215.171)
    by apache.org (qpsmtpd/0.29) with ESMTP; Sat, 06 Jul 2013 00:34:46 +0000
Received: by mail-ea0-f171.google.com with SMTP id m14so1778727eaj.30
        for <dev@subversion.apache.org>; Fri, 05 Jul 2013 17:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type:x-gm-message-state;
        bh=xrf7kj1NJyrPHlrWOJ1yKiQUo6rXibhkGZ+ktw2mbfg=;
        b=MqPNnOLG93Rj7gEsQb05x57avRILCcHqIGvmbr7xYEWe6/2KXwbeYYt2ZT5WGz57sq
         dSDJFbNSgwTcu8GRIu8ZdHklkvUmyHF2tIj5OMOCQjgnWcGX8RgBuFNEXV5LfyviYdSK
         fC0BnPKNeX66/qL8gdsyequdzJn1Ks+bJGfuD1ssC9eKNF3t47Z25XSCxix7ZG1VDZJQ
         I7RDyzgR4F9+GHXSEvzujNEJLXjXOsC3ue4WYnIeNBObaB0PCRRR+wIdzFYEimlHUJNb
         mmNMS9uO99a0azHYUOkLQ4hr2gQ+JMxDawoEaPis6aFrb/C+ytlhWS58FoVBGcJH8qLR
         1mTg==
X-Received: by 10.14.2.137 with SMTP id 9mr14451022eef.64.1373070864771;
        Fri, 05 Jul 2013 17:34:24 -0700 (PDT)
Received: from zulu.local (cpe-46-164-15-215.dynamic.amis.net. [46.164.15.215])
        by mx.google.com with ESMTPSA id b7sm18537213eef.16.2013.07.05.17.34.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 17:34:24 -0700 (PDT)
Received: from zulu.local (localhost [IPv6:::1])
	by zulu.local (Postfix) with ESMTP id 511BD743A630;
	Sat,  6 Jul 2013 02:34:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <kr7il5$n0p$1@ger.gmane.org>
X-Gm-Message-State: ALoCoQl3uYgqcV1KeuwDRH/xkws5LBF9DlkbRmxiTVX/VjDjXcA2ETyhKnuiKVZhxpwATtdOVkWH
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229685>

This is a multi-part message in MIME format.
--------------080109000601050907070703
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Copying dev@ because it's related to a known issue that we document
more loudly.]

On 06.07.2013 00:51, David Rothenberger wrote:
> I cannot reproduce this problem using command-line tools, but I was
> able to do a trace of git-svn when it is failing and it looks to me
> that the problem is in the order in which the SVN::Delta::Editor
> (svn_delta_editor_t) function are being called.
>
> The order I see is:
>  1. open_root
>  2. open_directory
>  3. add_file
>  4. apply_textdelta
>  5. add_file
>  6. apply_textdelta
>
> The git-svn code is expecting a close_file call before the add_file
> call in #5. It appears to me that the svn_delta_editor_t API [1]
> requires this close_file call. It looks to me like this is Issue
> #2932 [2].

Indeed it is.

And it is actually documented here:

https://svn.apache.org/repos/asf/subversion/trunk/notes/api-errata/1.7/ra001.txt

and mentioned here:

http://subversion.apache.org/docs/release-notes/1.7.html#svnrdump
In other words, this is a limitation of the Serf-based backend that has
been around since Subversion 1.4. I'm aware that it isn't documented as
well as it should be, but the bulk-mode workaround exists in part as a
workaround for that, effectively disabling the more efficient HTTPv2
protocol.

In the meantime, it might be a good idea to relax the restrictions in
git-svn to account for the way the HTTPv2 protocol works.

-- Brane

-- 
Branko Čibej | Director of Subversion
WANdisco // Non-Stop Data
e. brane@wandisco.com

--------------080109000601050907070703
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">[Copying dev@ because it's related to a
      known issue that we document more loudly.]<br>
      <br>
      On 06.07.2013 00:51, David Rothenberger wrote:
    </div>
    <blockquote cite="mid:kr7il5$n0p$1@ger.gmane.org" type="cite">
      <pre wrap="">I cannot reproduce this problem using command-line tools, but I was
able to do a trace of git-svn when it is failing and it looks to me
that the problem is in the order in which the SVN::Delta::Editor
(svn_delta_editor_t) function are being called.

The order I see is:
 1. open_root
 2. open_directory
 3. add_file
 4. apply_textdelta
 5. add_file
 6. apply_textdelta

The git-svn code is expecting a close_file call before the add_file
call in #5. It appears to me that the svn_delta_editor_t API [1]
requires this close_file call. It looks to me like this is Issue
#2932 [2].</pre>
    </blockquote>
    <br>
    Indeed it is.<br>
    <br>
    And it is actually documented here:<br>
    <br>
<a class="moz-txt-link-freetext" href="https://svn.apache.org/repos/asf/subversion/trunk/notes/api-errata/1.7/ra001.txt">https://svn.apache.org/repos/asf/subversion/trunk/notes/api-errata/1.7/ra001.txt</a><br>
    <br>
    and mentioned here:<br>
    <br>
    <a class="moz-txt-link-freetext" href="http://subversion.apache.org/docs/release-notes/1.7.html#svnrdump">http://subversion.apache.org/docs/release-notes/1.7.html#svnrdump</a><br>
    <blockquote cite="mid:kr7il5$n0p$1@ger.gmane.org" type="cite">
    </blockquote>
    In other words, this is a limitation of the Serf-based backend that
    has been around since Subversion 1.4. I'm aware that it isn't
    documented as well as it should be, but the bulk-mode workaround
    exists in part as a workaround for that, effectively disabling the
    more efficient HTTPv2 protocol.<br>
    <br>
    In the meantime, it might be a good idea to relax the restrictions
    in git-svn to account for the way the HTTPv2 protocol works.<br>
    <br>
    -- Brane<br>
    <br>
    <div class="moz-signature">-- <br>
      <span style="font-face:sans-serif;font-size:9pt;line-height:18pt">Branko
        Čibej <span style="color: #f90">|</span> <span
          style="font-weight:bold">Director of Subversion</span>
        <br>
        WANdisco <span style="color: #f90">//</span> <span
          style="font-style:oblique">Non-Stop Data</span>
        <br>
        <span style="color: #ccc">e.</span> <a class="moz-txt-link-abbreviated" href="mailto:brane@wandisco.com">brane@wandisco.com</a></span></div>
  </body>
</html>

--------------080109000601050907070703--
