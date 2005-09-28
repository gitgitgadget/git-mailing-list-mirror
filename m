From: tab@snarc.org (Vincent Hanquez)
Subject: Re: More Porcelains?
Date: Wed, 28 Sep 2005 13:30:08 +0200
Message-ID: <20050928113008.GA11309@snarc.org>
References: <20050926175156.GB9410@reactrix.com> <20050926182341.GA26340@pasky.or.cz> <7v3bnrh85g.fsf@assigned-by-dhcp.cox.net> <20050927001542.GC15615@reactrix.com> <7v64sn8hml.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 13:31:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKa8e-0002GU-1z
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 13:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVI1LaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 07:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVI1LaL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 07:30:11 -0400
Received: from darwin.snarc.org ([81.56.210.228]:2509 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1751223AbVI1LaK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 07:30:10 -0400
Received: by darwin.snarc.org (Postfix, from userid 1000)
	id 03FC34BE14; Wed, 28 Sep 2005 13:30:08 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64sn8hml.fsf_-_@assigned-by-dhcp.cox.net>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9426>

On Mon, Sep 26, 2005 at 05:43:46PM -0700, Junio C Hamano wrote:
> Now you made me curious.
> 
> How many of you are working on your own Porcelains, announced or
> unannounced?  I know about Cogito and StGIT ;-).  In a distant
> past I have heard of something called JIT but I think it is now
> defunct.  Matthias Urlichs said he is doing something with
> Python.  Anybody else?

Hi Junio,

Well, I kinda work on one written in C using a libgit (using exec of git
executable for the moment) It doesn't do that much at the moment:
commiting, adding files, removing files.

At some point I'ld like to have a very integrated and easy to use
porcelain, but for now that's more a learning git by practice kind of
project.

Cheers,
-- 
Vincent Hanquez
