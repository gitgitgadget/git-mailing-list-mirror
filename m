From: =?ISO-8859-15?Q?Klaus_R=F6del?= <klaus.roedel@vipco.de>
Subject: [cvsimport] Import CVS repository from a specified date or branch
 name
Date: Fri, 23 Oct 2009 09:52:28 +0200
Message-ID: <4AE160BC.5000608@vipco.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 09:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Ewn-0005AB-Fw
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 09:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbZJWHwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 03:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbZJWHwV
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 03:52:21 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:42332 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbZJWHwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 03:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1256284343; l=473;
	s=domk; d=vipco.de;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:
	Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=4AGrN6BsHiQT9N3MLdDZa1AJDbc=;
	b=C0iWcalXVkP7TqAvynDmZBoxEeEN1G/61ZysBMYD9ptB/ssQo+jLDiTOXIifOj0pEjg
	zUbtZzvFesG9b8xsq6DqiPNXFdjWomGsmeR1j8RcFfoujDhYc4qNtFjVEjkCtVb11q24n
	RmxZQC/y21QPE8fBLSxOFl4XZfz3TbtSG30=
X-RZG-AUTH: :J2AFYFPmafDcxkJlIy32DzKJ39CLzwbYxYKkQ7q7d4z2U4Ni9ryrH2hKASJ6tl6v/bRb
X-RZG-CLASS-ID: mo00
Received: from [192.168.0.83] (p57A5DBED.dip.t-dialin.net [87.165.219.237])
	by post.strato.de (fruni mo33) (RZmta 22.1)
	with ESMTP id c053a0l9N7fccb ; Fri, 23 Oct 2009 09:52:22 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131095>

Hello,

I have a very large and old (serveral years) cvs repository and I want 
to import this in git.
For my work it is not nessecary to import all the revision history from 
the cvs repository.
It is engough to import only the revisions from a specified date or 
branch name of the cvs repo.

Is this possible with git-cvsimport?
If yes, how?
If no, is it possible to include such a function in the git-cvsimport 
script?

Thanks for any help.

Greets Klaus
