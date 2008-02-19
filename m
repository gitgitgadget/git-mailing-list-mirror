From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Builtin-clone?
Date: Tue, 19 Feb 2008 00:30:43 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802182341430.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 06:31:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRL4q-0004ZH-VQ
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 06:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbYBSFap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 00:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbYBSFap
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 00:30:45 -0500
Received: from iabervon.org ([66.92.72.58]:54834 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbYBSFao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 00:30:44 -0500
Received: (qmail 12443 invoked by uid 1000); 19 Feb 2008 05:30:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 05:30:43 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74376>

I remember some discussion of what was still needed in order to make clone 
a trivial caller of init, config, fetch, and (optionally) checkout, and 
that there was still something. But has anyone actually written the bulk 
of builtin-clone.c? 

	-Daniel
*This .sig left intentionally blank*
