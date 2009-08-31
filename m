From: Frank Li <lznuaa@gmail.com>
Subject: Re: [msysGit] Re: Using VC build git (split patch)
Date: Mon, 31 Aug 2009 10:45:16 +0800
Message-ID: <1976ea660908301945n74a55bb3p42aef0622e3996c7@mail.gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
	 <4A899FDB.8080308@gmail.com>
	 <1976ea660908171807x22f4b755r2e522a15ff462917@mail.gmail.com>
	 <a4c8a6d00908301236l4394a471vb83ed2befda3a91@mail.gmail.com>
	 <40aa078e0908301316m68258630oe84c0e9b6191332b@mail.gmail.com>
	 <a4c8a6d00908301324o25d1cb48u12b527ea68e43680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 04:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhwzh-0001Lo-V3
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 04:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbZHaCvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 22:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbZHaCvd
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 22:51:33 -0400
Received: from mail-yw0-f188.google.com ([209.85.211.188]:45159 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbZHaCvc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 22:51:32 -0400
Received: by ywh26 with SMTP id 26so5489950ywh.5
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 19:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jqxNi8rJe2cquGvEZpRvxtpG4TxennlVCy9AmGlXynY=;
        b=c+uDfIbHNpyrHGHjBh93UKtuAijxAKU8OyYhYwrGXsUCljW0AC2lK+QTFRZjJJQPT3
         FitQsK2hHxnXbgd3MttlF/j1T5081VFvjgacVQsop5HuuzROc+UBvJmGPvq+pEHhCqMF
         05fA8sbTz/I+yYZuPy9mFRV3x/umu5UG00qKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZSFunVOz+li7eVelNNXrsjvGVREkaGtytMSviit7e/pn5WZXI11RF+a2lsZujlN1YJ
         XpYA167PB0GcoeCWzbL6xYzTOffc9/wVF5nAqa9bXSyIoURLAlFHH3JqepmA7yucXqtS
         qDKzwsRjqFNU2W/JGcQCPoH3nSXud/HCOKep8=
Received: by 10.150.8.16 with SMTP id 16mr8050840ybh.131.1251686716143; Sun, 
	30 Aug 2009 19:45:16 -0700 (PDT)
In-Reply-To: <a4c8a6d00908301324o25d1cb48u12b527ea68e43680@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127456>

> Yep, an imap-send vcproject with one file(imap-send.c) was added to
> gitbuild.sln.

Sorry, I add imap-send to sln just for testing at solution.

You can omit this project.

best regards
Frank Li
