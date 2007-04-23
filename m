From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Anybody using git-send-pack?
Date: Mon, 23 Apr 2007 14:38:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704231437180.28708@iabervon.org>
References: <Pine.LNX.4.64.0704231321550.28708@iabervon.org>
 <7vr6qbey5p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:38:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg3Qz-0004Qt-It
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 20:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbXDWSi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 14:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbXDWSi0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 14:38:26 -0400
Received: from iabervon.org ([66.92.72.58]:3477 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161337AbXDWSiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 14:38:25 -0400
Received: (qmail 7879 invoked by uid 1000); 23 Apr 2007 18:38:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Apr 2007 18:38:24 -0000
In-Reply-To: <7vr6qbey5p.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45349>

On Mon, 23 Apr 2007, Junio C Hamano wrote:

> Fwiw, I use a custom script that directly calls send-pack.

Okay, I'll do a builtin for it, then.

	-Daniel
*This .sig left intentionally blank*
