From: Dill <sarpulhu@gmail.com>
Subject: Re: Using git from Python
Date: Fri, 9 May 2008 23:52:47 -0700 (PDT)
Message-ID: <9b013f14-c193-41bc-923f-5f9a09d4fd60@56g2000hsm.googlegroups.com>
References: <alpine.DEB.1.10.0805071612510.26718@sf.creativecommons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 08:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juixy-0000Hk-Sn
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 08:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYEJGwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 02:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbYEJGww
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 02:52:52 -0400
Received: from ug-out-1516.google.com ([66.249.92.166]:46384 "EHLO
	ug-out-1516.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYEJGww (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 02:52:52 -0400
Received: by ug-out-1516.google.com with SMTP id v32so2059311ugc.1
        for <git@vger.kernel.org>; Fri, 09 May 2008 23:52:48 -0700 (PDT)
Received: by 10.150.49.11 with SMTP id w11mr105949ybw.20.1210402367613; Fri, 
	09 May 2008 23:52:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0805071612510.26718@sf.creativecommons.org>
X-IP: 161.184.178.241
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) 
	Gecko/20080404 Firefox/2.0.0.14,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81654>

Also check out: http://gitorious.org/projects/git-python/

Asheesh Laroia wrote:
> From a Python app, I want to read and write a git repository.  It seems
> from Luiz Fernando's post at http://blog.cpu.eti.br/?p=91 that the efforts
> to Pythonize libgit have stalled.
>
> On #git, I was advised to simply call the git command suite.  That's fine,
> and I can do it using the subprocess module in Python - but since I
> figured others may have done this also, does anyone know of a Python
> module that wraps some git commands?  I'm thinking if others have gone
> down this path, they might have code that e.g. raises Exceptions when the
> git commands fail for some reason.
>
> What have others on this list done lately for using git from Python?
>
> -- Asheesh.
>
> --
> You will reach the highest possible point in your business or profession.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
