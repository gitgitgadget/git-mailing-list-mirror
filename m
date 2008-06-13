From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Dubious format-patch options
Date: Thu, 12 Jun 2008 19:24:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806121923400.2949@woody.linux-foundation.org>
References: <E1K6xrt-00033S-2J@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 04:26:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6z02-0006xG-5w
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 04:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbYFMCZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 22:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbYFMCZT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 22:25:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53547 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851AbYFMCZT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 22:25:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5D2OKLc013963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jun 2008 19:24:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5D2OI7a019283;
	Thu, 12 Jun 2008 19:24:19 -0700
In-Reply-To: <E1K6xrt-00033S-2J@jdl.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.368 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84823>



On Thu, 12 Jun 2008, Jon Loeliger wrote:
> 
>     $ git format-patch -1 --stdout --color master
> 
> But I seriously doubt that we _really_ want to send a
> patch that has the embedded escape sequences in it:

Hey, you asked for it, you got it. I hope you're not complaining.

		Linus
