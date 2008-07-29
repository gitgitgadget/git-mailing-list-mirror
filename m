From: "Scott Chacon" <schacon@gmail.com>
Subject: Git Community Book
Date: Tue, 29 Jul 2008 09:20:20 -0700
Message-ID: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 18:21:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNrwz-0007xz-Gh
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 18:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYG2QUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 12:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbYG2QUX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 12:20:23 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:13761 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYG2QUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 12:20:22 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1551505ywe.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=PlL1uPxe588NHtm6pbe9Q/4uW4JGQAwKLfjBFYPYLBI=;
        b=CEsfjnX/pPAshliazpaE+Wb5xcai3jS2LyQC1C3si73W3sEYfpl6jTLVZGGLQ8J2Os
         dybN2bsbu88FgBXZTL+/ul3wphfZH0LvDX3Ev0P5j8jaHZ0vahKoId99TTSmvJjzmMCf
         vv2kXN1GlaZOXQK44ccyp2B7sSibbuMtfZIXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=e9mF5cFI1w3ZiyhSbawLwdcCWtXM/65vQu9FD5tE3dhP57hfuz1mV4evMeGU5XoVqt
         S9RG098gfcVnFFhIY3mbuCSh8lmsYfR0PJFVWOZO490C1HklU1YNcs0fb9n0lrHwtxPZ
         xfXSrEEcO+LF8Pk2Fzj5xG+DFFvtBCY4eg1CA=
Received: by 10.114.125.2 with SMTP id x2mr6869672wac.59.1217348420590;
        Tue, 29 Jul 2008 09:20:20 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Tue, 29 Jul 2008 09:20:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90653>

So I wanted to develop a really nice, easy to follow book for Git
newcomers to learn git quickly and easily.  One of the issues I
remember having when learning Git is that there is a lot of great
material in the User Guide, Tutorial, Tutorial 2, Everyday Git, etc -
but they're all huge long documents that are sometimes difficult to
come back to and remember where you were, and I didn't know which one
to start with or where to find what I was looking for, etc.

So, what I've started to do is pull material from all of them into a
single book which will be available in online HTML (one page per
chapter) and downloadable PDF form.  I'm trying to give it a very
organized flow that will hopefully be a bit easier to follow and
digest than the current formats, and including a number of diagrams,
illustrations and screencasts to supplement the text.  Where possible,
I am also trying to simplify the explanations a bit to be a tad more
digestible for beginning users, at least in the first couple dozen
chapters. I have put the current html output of this book here:

http://book.git-scm.com

It is not complete - the grey links are chapters that are very short
or completely empty - but it is a start.  Please let me know what you
think, and if anyone is interested in helping with the project, give
me a shout.

Also, for credit, I have generated an Authors page I will be linking
to the site soon that lists everyone that contributed a patch to any
of the Git User Guide, Git Tutorials, etc.  It is in the PDF right
now, but not in the HTML version yet (and the PDF is not yet linked to
the site).

Thanks,
Scott
