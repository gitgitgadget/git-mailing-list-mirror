From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: GIT 1.5.0 binary installer available.
Date: Thu, 15 Feb 2007 17:53:09 +0100
Message-ID: <45D48FF5.2060800@xs4all.nl>
References: <45D44FD5.72299A3A@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 17:54:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHjrW-0006Kq-F8
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 17:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966130AbXBOQxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 11:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966131AbXBOQxe
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 11:53:34 -0500
Received: from main.gmane.org ([80.91.229.2]:54398 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966130AbXBOQxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 11:53:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHjrG-0000ny-3F
	for git@vger.kernel.org; Thu, 15 Feb 2007 17:53:22 +0100
Received: from peder.xs4all.nl ([82.93.198.126])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 17:53:22 +0100
Received: from hanwen by peder.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 17:53:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: peder.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <45D44FD5.72299A3A@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39836>

Johannes Sixt escreveu:
> I've merged GIT 1.5.0 into the MinGW port. It is available at the usual
> location:
> 
> pull/clone: git://repo.or.cz/git/mingw.git
> gitweb:     http://repo.or.cz/w/git/mingw.git
> 
> It contains an important fix (MinGW specific): Earlier versions could
> sometimes create temporary files read-only instead of read-writable.

I've uploaded a binary installer to

http://lilypond.org/git/binaries/mingw/

(untested, and will need magic to get the bash scripts 
working)




-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
