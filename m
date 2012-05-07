From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git-scm.com refresh
Date: Mon, 07 May 2012 11:08:50 -0400
Message-ID: <4FA7E582.9090709@gmail.com>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 17:09:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRPYc-0005Fd-Gq
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 17:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901Ab2EGPI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 11:08:58 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37766 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab2EGPI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 11:08:57 -0400
Received: by qcro28 with SMTP id o28so1919838qcr.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=wLvrLSzRGUKDkhcnBftTtk9R55UYXk5uYMjaTVYBmgw=;
        b=HVMX0NYBkEsOSJKY8KXCP/rVoIdWZRdS+fd+qqrIJJDLq6gJyBuBg6TH+bV941I1WS
         RkrfWasPL8xwMHf9sLF+CNTSILgxoE5FC/hLYESU6jJPEAQjYKI7lnlnOfCH36XxQ/tx
         Wqxr849kjf3H8L1jqIdIZq0dSYikJEa6OE4K0MxYjfTY5K+8n0/kRE8iY7HsWtWRHlk2
         uZn9QYomzWs3aecnzUBjrpwb86ZCPsoDiG8yooQctdFlP8qM4RqJxcXiF+BTbXcTzvt9
         QR8dTVFjI0hWnYAv+pBR2e4fEtCuvPPuMxptYa75348TCS8Y8pku9s5r5fySyDkvx4+c
         gBqQ==
Received: by 10.229.136.84 with SMTP id q20mr6907172qct.89.1336403336660;
        Mon, 07 May 2012 08:08:56 -0700 (PDT)
Received: from [10.0.1.130] (cpe-67-248-162-240.nycap.res.rr.com. [67.248.162.240])
        by mx.google.com with ESMTPS id u3sm3770414qaa.4.2012.05.07.08.08.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 08:08:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120428 Icedove/3.0.11
In-Reply-To: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197275>

On 05/04/2012 07:29 PM, Scott Chacon wrote:
> Hey everyone,
>
> I just shipped a big update to the git-scm.com website, incorporating
> tons of feedback I've gotten on the site, especially from new users,
> over the years.  I think it will help new users to Git find the right
> installer and get up and running easier.  I have other ideas of things
> to add to it in the future, but I think this is much better than the
> site that has served us well for a few years now.

[...]

I was looking over the updated website and what follows are my initial 
impressions:

1) I like the old logo much better.

2) I notice that GitHub is NOT listed as a company or project using git 
on the main page. What SCM does GitHub use? :-O

3) On the About -> Small and Fast Page: you show a comparison to Git and 
Git* for the clone operation but there is no explanation of how Git and 
Git* differ.

4) It's 2 clicks to get to a category view of the man pages: I think 
that's 1 too many.

5) I would like to see a page that lists all of the documentation in the 
core distribution in one place. A good place for this would be somewhere 
near the top of the category view page.

6) The documentation pages should let the user decide with one click 
which version of the documentation set they wish to view instead of 
having to do it for every page.

7) A help topic on the category view page about determining which 
version of the documentation matches the user's installed version of Git 
would be useful.
