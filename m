From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments on Presentation Notes Request.
Date: Fri, 09 Jan 2009 05:50:40 -0800 (PST)
Message-ID: <m31vvc37x0.fsf@localhost.localdomain>
References: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 14:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLHmT-0005lz-Mm
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 14:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbZAINup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 08:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZAINup
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 08:50:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:19307 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZAINuo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 08:50:44 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1171610nfc.21
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 05:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=3sPtNZNpJyF2ojMFpJaire4Axcehr9kcrIkBCiPxZpg=;
        b=C/w/Lnc0L8MFs+NGeh1cJcxNp23yOEmXkRtRbWKAQm3COYI5fCikcrT1zo0LtAiSKF
         GP+XjAJDpc/LAFlgF0ycKn9oZGWxC/wg4HpKiu69uu3y0lCUm5ThqJ687FLmK+CNXhAu
         7sVJcwR0iK85S3+ogn5ghCOxf///4SnPU1n+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=lFKJnfr+E10CIhBhgI+OCMd9DblGHVK91xSscFdHQhvD/UOBUwk2jp+ABx/TKKSizk
         7n3FcegF0M0/HAAHw+qs8zFBDt+nqv03Hz0whA8KWDL1rtn3KO/m5np8XPL+j0/g3TjQ
         LV0k23wdF36/mVTvKB7/eE5hjX3zGYrpMDAYk=
Received: by 10.210.43.10 with SMTP id q10mr19309121ebq.179.1231509041518;
        Fri, 09 Jan 2009 05:50:41 -0800 (PST)
Received: from localhost.localdomain (abxa216.neoplus.adsl.tpnet.pl [83.8.250.216])
        by mx.google.com with ESMTPS id 28sm5099124eye.30.2009.01.09.05.50.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 05:50:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n09Dob1o024520;
	Fri, 9 Jan 2009 14:50:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n09Doa4E024517;
	Fri, 9 Jan 2009 14:50:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105012>

"Tim Visher" <tim.visher@gmail.com> writes:

> Hello Everyone,
> 
> I'm putting together a little 15 minute presentation for my company
> regarding SCMSes in an attempt to convince them to at the very least
> use a Distributed SCMS and at best to use git.  I put together all my
> notes, although I didn't put together the actual presentation yet.  I
> figured I'd post them here and maybe get some feedback about it.  Let
> me know what you think.
> 
> Thanks in advance!

Take a look at the following links:
 * "Understanding Version-Control Systems (DRAFT)" by Eric Raymond
   http://www.catb.org/esr/writings/version-control/version-control.html
 * "Version Control Habits of Effective Developers" at The Daily Build
   http://blog.bstpierre.org/version-control-habits

Note that the first one is DRAFT; on the other hand it explains
lock-edit, merge-then-commit, and commit-then-merge workflows quite
well, and has a host of links.
   
-- 
Jakub Narebski
Poland
ShadeHawk on #git
