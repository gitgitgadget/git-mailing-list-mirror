From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2007 partial summary
Date: Mon, 27 Aug 2007 02:51:05 +0200
Message-ID: <200708270251.05762.jnareb@gmail.com>
References: <200708190128.43515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 02:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPSp0-00080m-AS
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 02:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbXH0AvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 20:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXH0AvJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 20:51:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:1834 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbXH0AvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 20:51:08 -0400
Received: by nf-out-0910.google.com with SMTP id g13so998611nfb
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 17:51:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XiVA4RMXQdaB11olNOwdOGXMgOdCtNiL1MSf51OJ3nX3qKNr3B1Qh6yoTDRWjxKeQ+4hnx1qfQ43fVDv5uT8bdIgMKKICnWFYFbi38v+O7/IRyxG2XSikQspgz+7G/WzFFsscKKnBNFVq7IryagMfZl8oEnsCMvb0wo1C0yz8kE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IDjZwRkx7ZVj1IopOXCMipnZW+ucWYafh32VDXkEmD+pivhpSXZDEru6B8t1R8GOIfeYI76GyEJ77YhLafj8aGRIm4CAeBzhyCNt17yfEqbXWowjmyPMZUeJp4i6ArOhDOYtdpSZr6TvtN4B/NXW/fX/cRUcZOZofWtZis3KfP4=
Received: by 10.86.70.8 with SMTP id s8mr4454188fga.1188175867194;
        Sun, 26 Aug 2007 17:51:07 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id e32sm4394161fke.2007.08.26.17.51.05
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2007 17:51:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200708190128.43515.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56752>

This is partail summary of Git User's Survey 2007 after 1 week of 
running. It is based on "View Text Results" page:
  http://www.survey.net.nz/members.php?page=results&qn=1304

We have around 445 individual responses, as compared to (I think) 115 
answers (Base = 115) for previous survey. That is quite a bit.


04. Which programming languages are you proficient with?

It losk like there is only 3/4 people proficient in Perl as compared to 
Python; it looks like Python is more popular. C is most popular, with 
only a few (if everything is all right with the results page) people 
proficient in Tcl/Tk. I'm sorry, git-gui and gitk guys; it looks like
not many developers...


19. How do you obtain GIT?

Around twice as many people use binary packages as source tarball (or 
source package, I think). Around half the people compiles its own git 
(pull is also followed by compilation).


26. Which porcelains do you use?

Most people use core-git, some use cogito (the fact that it was lately 
deprecated and is no longer developed notwithstanding), some use StGIT,
3 even use pg (despite it is unmaintained). More people use StGIT than 
Guilt, but this can be cause by the fact that Guilt (formerly gq) is 
younger. Quite a bit use own scripts. 8 choose other... and there is no 
"what other" question, unfortunately...


28. Which (main) git web interface do you use for your projects?

Most use gitweb (which is distributed with git), 7 use cgit, 1 wit 
(Ruby), most probably XMMS2 project, 1 git-php (I wonder who...), and 
there are 20 "other" answers, which I am most curious about. What are 
they?


39. Did you participate in previous Git User's Survey?

43 people did out of 368 who answered this question, out of 115 who did 
participate in the previous survey. Bit curious.


55. Would commerical (paid) support from a support vendor be of interest 
to you/your organization?

Only 44 answers yes, 217 no, 126 not applicable (which was menat to 
encompass people who do not use git for work).

-- 
Jakub Narebski
Poland
