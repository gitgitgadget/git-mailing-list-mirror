From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Fri, 26 Jun 2009 09:32:43 +0200
Message-ID: <200906260932.43826.johan@herland.net>
References: <200906252122.51737.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>,
	David Aguilar <davvid@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 09:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK5vb-0000EO-4g
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 09:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbZFZHcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 03:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbZFZHco
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 03:32:44 -0400
Received: from mx.getmail.no ([84.208.15.66]:53923 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750699AbZFZHcn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 03:32:43 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KLU00IJI4YLYS40@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 26 Jun 2009 09:32:45 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KLU00KOE4YKAO10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 26 Jun 2009 09:32:45 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.6.26.72115
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <200906252122.51737.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122283>

On Thursday 25 June 2009, Jakub Narebski wrote:
> Current version of survey has 30 questions, as compared to
> 60 questions last year; the number of free-form essay questions
> were also greatly reduced.

Good. :)

> The *test* version of this year survey can be now found at
> the following URL (as in previous year, we use Survs.com)
>
>   http://www.survs.com/survey?id=2PIMZGU0&channel=TFN2Y52K7Y
>
> Please tell me what you think about questions and about selection
> of possible answers in single choice/multiple choice questions.

There seems to be some unnecessary overlap among questions 11, 16/17 and 18. 
Examples: I found myself ticking off equivalent options like:
- 11/gitk, 17/gitk and 18/"gitk or other history viewer"
- 17/"git gui" and 18/"git-gui or other commit tool"
- 14/"via git-bundle", 15/"git bundle", 16/"git bundle" and 18/"git bundle"
- 11/StGIT/Guilt/TopGit and 18/"path management interface"
- 17/"git reflog" and 18/reflog
- 17/"git stash" and 18/stash
- 16/"git difftool" and 18/"mergetool and/or difftool"
- 16/"git mergetool" and 18/"mergetool and/or difftool"
- 17/"git rebase -i" and 18/"interactive rebase"
- 16/"git add -i" and 18/"interactive commit/..."
- 16/"git filter-branch", 18/"git-filter-branch or cg-admin-rewritehist" and 
18/"git-filter-branch or equivalent"
- 11/"editor/IDE VC integration" and 18/"integration with IDE/editor"

Some of this overlap is probably unavoidable, but I think some of it 
(especially between 16/17 and 18) can be eliminated without compromising the 
survey. Maybe we can integrate the non-overlapping parts of 18 into the 
other questions, thereby further decreasing the number of questions?

BTW, 17 is just a continuation of 16, AFAICS. Is it possible to just repeat 
the column headers (to break up the table length) and still keep it as one 
question?


Otherwise, I like the survey very much.

> How long does it take to fill survey?

~ 5-7 minutes


Thanks for the hard work you put into this. It is appreciated.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
