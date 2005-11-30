From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 12:46:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511301235390.25300@iabervon.org>
References: <20051128234256.1508.qmail@science.horizon.com>
 <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 19:13:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhW1X-0004z8-9r
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 18:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbVK3Rpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 12:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVK3Rpa
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 12:45:30 -0500
Received: from iabervon.org ([66.92.72.58]:52491 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751483AbVK3Rp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 12:45:29 -0500
Received: (qmail 29992 invoked by uid 1000); 30 Nov 2005 12:46:00 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Nov 2005 12:46:00 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13009>

On Mon, 28 Nov 2005, Junio C Hamano wrote:

> *1* It is a shame that the most comprehensive definition of
> 3-way read-tree semantics is in t/t1000-read-tree-m-3way.sh test
> script.

Isn't Documentation/technical/trivial-merge.txt more comprehensive?

Probably the tables in various other places should be replaced with 
references to this document.

	-Daniel
