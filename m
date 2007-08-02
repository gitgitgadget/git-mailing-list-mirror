From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git clone error
Date: Thu, 2 Aug 2007 10:40:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708021039450.8109@woody.linux-foundation.org>
References: <C2D74FA8.2C06%denbuen@sandia.gov>
 <Pine.LNX.4.64.0708021806510.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Denis Bueno <denbuen@sandia.gov>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 19:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGefk-0007rN-QA
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 19:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758209AbXHBRk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 13:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758220AbXHBRk6
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 13:40:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43065 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752358AbXHBRk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 13:40:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l72HeoGM017643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 10:40:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l72Hejo4001281;
	Thu, 2 Aug 2007 10:40:45 -0700
In-Reply-To: <Pine.LNX.4.64.0708021806510.14781@racer.site>
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54577>



On Thu, 2 Aug 2007, Johannes Schindelin wrote:
> 
> Ah no.  Linus diagnosed that this blob is your condor-uninstall script in 
> your initial commit.

Well, I'm not sure the commit was the initial one, but it was the one that 
*introduced* that file. It *may* be the initial one, of course (and quite 
likely is, for an import), but..

		Linus
