From: Sam Vilain <sam@vilain.net>
Subject: Re: Subversion developer: svn is for dumb people
Date: Fri, 19 Oct 2007 11:40:59 +1300
Message-ID: <4717E0FB.1060705@vilain.net>
References: <47176CE0.7030609@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iie3M-00083Y-Hg
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbXJRWlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbXJRWlI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:41:08 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43847 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbXJRWlG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 18:41:06 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 361BA21CFE8; Fri, 19 Oct 2007 11:41:05 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 8ACE621CFDB;
	Fri, 19 Oct 2007 11:41:01 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <47176CE0.7030609@midwinter.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61567>

Steven Grimm wrote:
> some of his specific arguments
> about DVCS are on the bogus side. "Centralized systems encourage code 
> reviews," for one --

I heard this from the core Subversion team too.  The hypothesis is that
by forcing groups to be unable to proceed without continually rebasing
to each other's work, that collaboration is enhanced.

I think any argument which states that a restrictive system is better
than a non-restrictive system, when the non-restrictive system can be
used in the same way as the restrictive system (either with
configuration, or agreement with the committers) is quite bizarre.

Sam.
