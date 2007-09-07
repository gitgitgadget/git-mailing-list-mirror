From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String
 Library.
Date: Fri, 7 Sep 2007 01:38:01 +0100 (BST)
Message-ID: <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
References: <46DDC500.5000606@etek.chalmers.se>  <1189004090.20311.12.camel@hinata.boston.redhat.com>
  <vpq642pkoln.fsf@bauges.imag.fr>  <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
  <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 02:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITRrV-0006nt-Ng
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 02:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbXIGAiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 20:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbXIGAiL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 20:38:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42688 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964835AbXIGAiK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 20:38:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l870c3Yq025928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Sep 2007 17:38:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l870c1Kl015838;
	Thu, 6 Sep 2007 17:38:02 -0700
In-Reply-To: <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
X-Spam-Status: No, hits=-3.241 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.31__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57957>



On Thu, 6 Sep 2007, Dmitry Kakurin wrote:
> 
> As dinosaurs (who code exclusively in C) are becoming extinct, you
> will soon find yourself alone with attitude like this.

Unlike you, I actually gave reasons for my dislike of C++, and pointed to 
examples of the kinds of failures that it leads to.

You, on the other hand, have given no sane reasons *for* using C++.

The fact is, git is better than the other SCM's. And good taste (and C) is 
one of the reasons for that.

It has nothing to do with dinosaurs. Good taste doesn't go out of style, 
and comparing C to assembler just shows that you don't have a friggin idea 
about what you're talking about.

			Linus
