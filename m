From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH] Add new git-graph command
Date: Sun, 30 Mar 2008 15:02:36 -0700
Message-ID: <20080330220236.GB10978@adamsimpkins.net>
References: <20080330195840.GA8695@adamsimpkins.net> <vpqiqz4vt5e.fsf@bauges.imag.fr>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 31 00:03:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg5cX-0003sj-Lz
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 00:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbYC3WCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 18:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbYC3WCk
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 18:02:40 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:60707 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbYC3WCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 18:02:39 -0400
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 4B0331B54C2;
	Sun, 30 Mar 2008 18:02:39 -0400 (EDT)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 2A0151B5193;
	Sun, 30 Mar 2008 18:02:39 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id C8B6414100B8; Sun, 30 Mar 2008 15:02:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqiqz4vt5e.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78518>

On Sun, Mar 30, 2008 at 10:44:29PM +0200, Matthieu Moy wrote:
> Adam Simpkins <adam@adamsimpkins.net> writes:
> 
> > This is a first pass at a command to print a text-based graph of the commit
> > history.  It is similar to the history graph shown by gitk, but doesn't
> > require a windowing system.
> 
> Did you look at git-forest too?
> 
> http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-ed34e1966c28f24d459c5ad30a21457baa9bed23

Interesting, I wasn't aware of this utility.  It does look very
similar.

-- 
Adam Simpkins
adam@adamsimpkins.net
