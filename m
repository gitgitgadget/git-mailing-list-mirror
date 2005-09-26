From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/3] http-fetch enhancements
Date: Mon, 26 Sep 2005 18:29:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509261823590.23242@iabervon.org>
References: <20050926175148.GA9410@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:25:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK1Om-0007YK-ET
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVIZWYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVIZWYd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:24:33 -0400
Received: from iabervon.org ([66.92.72.58]:48136 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932482AbVIZWYd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 18:24:33 -0400
Received: (qmail 2768 invoked by uid 1000); 26 Sep 2005 18:29:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Sep 2005 18:29:02 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050926175148.GA9410@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9348>

On Mon, 26 Sep 2005, Nick Hengeveld wrote:

> The following series contains some http-fetch enhancements, based on
> our requirements for use of SSL client certificates and partial HTTP
> transfers.

If you happen to know how to have curl do multiple simultaneous downloads, 
that would be a big performance win, and I should be able to explain how 
to get this to work. I haven't gotten around to learning libcurl well 
enough to do the flow control.

	-Daniel
*This .sig left intentionally blank*
