From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [ANNOUNCE] GIT MinGW port updated to v1.5.3.rc2
Date: Wed, 01 Aug 2007 00:26:20 -0300
Message-ID: <46AFFD5C.5060007@xs4all.nl>
References: <46A87F5D.C5BFC04B@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 05:31:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG4vZ-00089Y-OO
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 05:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbXHADbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 23:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbXHADbJ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 23:31:09 -0400
Received: from main.gmane.org ([80.91.229.2]:40238 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbXHADbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 23:31:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IG4vP-0001qO-06
	for git@vger.kernel.org; Wed, 01 Aug 2007 05:31:03 +0200
Received: from c950001d.bhz.virtua.com.br ([201.80.0.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 05:31:02 +0200
Received: from hanwen by c950001d.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 05:31:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c950001d.bhz.virtua.com.br
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <46A87F5D.C5BFC04B@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54402>

Johannes Sixt escreveu:
> I've just pushed an update of the MinGW port to:
> 
> clone:	git://repo.or.cz/git/mingw.git
> gitweb:	http://repo.or.cz/w/git/mingw.git
> 
> It is now at v1.5.3.rc2.
> 
> NOTE! This is only lightly tested, i.e. it passes (most of) the test
> suite(*), but it hasn't been used in production, yet.
> 

to match this beacon of robustness: I have put up 
a completely untested binary build for mingw at 

  http://lilypond.org/git/binaries/mingw/

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
