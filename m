From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Modularize http, commit-walker, http-fetch
Date: Sun, 22 Jul 2007 18:14:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707221811090.29679@iabervon.org>
References: <Pine.LNX.4.64.0707221745440.29679@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjhB-0001MQ-Gv
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760936AbXGVWO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762059AbXGVWO2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:14:28 -0400
Received: from iabervon.org ([66.92.72.58]:3501 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761533AbXGVWO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:14:27 -0400
Received: (qmail 29651 invoked by uid 1000); 22 Jul 2007 22:14:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jul 2007 22:14:26 -0000
In-Reply-To: <Pine.LNX.4.64.0707221745440.29679@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53346>

I just realized I forgot to use -C, so some of these patches are probably 
less than trivial to review as changes. If anybody wants to be able to 
actually read them all without applying them, I have -C versions; if 
nobody does, I'd just as soon not spam the list further.

	-Daniel
*This .sig left intentionally blank*
