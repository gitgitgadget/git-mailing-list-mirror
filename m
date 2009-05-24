From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit] how to use a ssh private key
Date: Sun, 24 May 2009 16:45:11 -0700
Message-ID: <20090524234511.GY30527@spearce.org>
References: <4A19B59C.7020408@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Gaber <Michael.Gaber@gmx.net>
X-From: git-owner@vger.kernel.org Mon May 25 01:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8NNu-0004rj-Aw
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 01:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbZEXXpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 19:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbZEXXpK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 19:45:10 -0400
Received: from george.spearce.org ([209.20.77.23]:33139 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbZEXXpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 19:45:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3B4CC381FD; Sun, 24 May 2009 23:45:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A19B59C.7020408@gmx.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119876>

Michael Gaber <Michael.Gaber@gmx.net> wrote:
>
> I'd like to know if current egit/jgit supports using a ssh private key  
> (with or without password) to sync to a git repository and how this  
> could be accomplished.

It does support it.  Just make sure the key is listed in the
workspace preferences, under General > Network Connections > SSH2.

-- 
Shawn.
