From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Bash v4 on msysgit?
Date: Fri, 9 May 2014 08:09:32 -0500
Message-ID: <CAHd499DhnCKhd5m7XF3XjZAt4_JiF_Taog56RO1J6F+TksRQcQ@mail.gmail.com>
References: <536CA1C9.1090201@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Fri May 09 15:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WikYT-0002tv-Ql
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 15:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaEINJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 09:09:34 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:64322 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaEINJd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 09:09:33 -0400
Received: by mail-vc0-f180.google.com with SMTP id hy4so4277195vcb.25
        for <git@vger.kernel.org>; Fri, 09 May 2014 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=k7+5l1X49GGp/QtctteULSNz9Y/umm7CdXUGCTvPnNA=;
        b=jAaTr4W0SVpJDG2rRonnWt07zBfpXKdhm4z4ME54wyVW4UvuxxP2sxiPBfFgjyeOqI
         BrDZul3tK4CqyzGVg5qtEmST1EL9YffbJtGzFg3alHYZ2jVsGZvEXcQUzNmyjlcWmyv/
         +xOOfHmvaAULKHSb6Iw7sKEu6l2rtI8xEMOFAHhe0rQ1WeYuTBBymRHktosddUuDncvg
         gbP3bh2zRhYsWRC3VmVsDHiqjXA3JDUp68JgLR4gfBt5uW6qxeQTTgH36UHNDCcNZv5E
         5sSfIpnpgjllF08ySN3S1+37WXRjtcjMQQKbfiU0aQxe92qbAyPw0AH1zJqDnZn9axmS
         //rw==
X-Received: by 10.52.53.69 with SMTP id z5mr217839vdo.42.1399640972670; Fri,
 09 May 2014 06:09:32 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.13.198 with HTTP; Fri, 9 May 2014 06:09:32 -0700 (PDT)
In-Reply-To: <536CA1C9.1090201@virtuell-zuhause.de>
X-Google-Sender-Auth: FhouDztRSR-gYRoUlFZqYZKzJUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248555>

Thanks for the info. Really quite disappointing that the discussion
linked was from 3 years ago but still no progress. I wish I could use
cygwin to use GIT but LESS doesn't work for log, reflog, and other
commands.

On Fri, May 9, 2014 at 4:37 AM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
>> How can I get Bash v4 for msysgit 1.9.2? I need it for 'globstar'
>> shopt support. Thanks in advance.
>
> Unfortunately you can't.
> Newer bash versions don't work with the current msys layer.
>
> See http://mingw.5.n7.nabble.com/bash-4-x-for-MSYS-td5605.html for a
> more in depth discussion.
