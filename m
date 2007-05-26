From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW port updated to 1.5.2
Date: Sat, 26 May 2007 18:01:18 -0300
Message-ID: <4658A01E.5060209@xs4all.nl>
References: <46569DA5.4F0EBF9A@eudaptics.com>  <4658922B.1010807@xs4all.nl> <001d01c79fd7$3d7f5ad0$0200a8c0@AMD2500>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 23:03:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs3Q5-0001Bz-0i
	for gcvg-git@gmane.org; Sat, 26 May 2007 23:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995AbXEZVDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 17:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758668AbXEZVDS
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 17:03:18 -0400
Received: from main.gmane.org ([80.91.229.2]:37795 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756995AbXEZVDR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 17:03:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hs3Pu-0005bl-GL
	for git@vger.kernel.org; Sat, 26 May 2007 23:03:14 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 May 2007 23:03:14 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 May 2007 23:03:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <001d01c79fd7$3d7f5ad0$0200a8c0@AMD2500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48494>

Aaron Gray escreveu:
>>> GIT_EXTERNAL_DIFF works now.
>>
>> http://lilypond.org/git/binaries/mingw/
>>
>> uploading as I speak. Untested.
> 
> This installs to "C:\Program Files\Git" and is not availiable on the
> path. What is going on here please ?

this uses the same buildscripts as before, so if it worked, it should 
still work. The path should point to $PF/Git/usr/bin/ ; you might need to 
log out and log in again for the path to visible. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
