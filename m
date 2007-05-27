From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: GIT on MinGW, with tcltk for gitk
Date: Sun, 27 May 2007 16:52:47 -0300
Message-ID: <f3cnm6$gda$1@sea.gmane.org>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <4659D306.6030803@xs4all.nl>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 21:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsOpz-0006hI-5R
	for gcvg-git@gmane.org; Sun, 27 May 2007 21:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXE0TzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 15:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbXE0TzT
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 15:55:19 -0400
Received: from main.gmane.org ([80.91.229.2]:39165 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbXE0TzS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 15:55:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsOpO-0004aQ-SS
	for git@vger.kernel.org; Sun, 27 May 2007 21:54:58 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 21:54:58 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 21:54:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <4659D306.6030803@xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48573>

Han-Wen Nienhuys escreveu:
> There is a 1.5.2-3 installer which includes a cross-compiled tcltk. 
> 
>   http://lilypond.org/git/binaries/mingw/
> 
> What is the proper way to have the 'gitk' command start up with wish
> automatically?

I've just uploaded 1.5.2-5, which also writes a gitk.bat file, containing
proper paths. However, I can't get it working in Wine. Any windows user
that cares to test? 

  http://lilypond.org/git/binaries/mingw/git-1.5.2-5.mingw.exe

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
