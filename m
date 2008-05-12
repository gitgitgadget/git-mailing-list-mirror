From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 22:10:02 +0300
Message-ID: <20080512191002.GQ31039@zakalwe.fi>
References: <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com> <alpine.DEB.1.00.0805121606010.30431@racer> <20080512152731.GM31039@zakalwe.fi> <alpine.DEB.1.00.0805121804500.30431@racer> <20080512180720.GN31039@zakalwe.fi> <alpine.DEB.1.00.0805121920120.30431@racer> <20080512183615.GO31039@zakalwe.fi> <20080512183803.GP31039@zakalwe.fi> <73584838-DF17-4CDB-92CA-363ED9DA9582@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	bill lam <cbill.lam@gmail.com>, git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 21:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdRA-0007XA-5q
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 21:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617AbYELTKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758605AbYELTKG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 15:10:06 -0400
Received: from zakalwe.fi ([80.83.5.154]:34937 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757071AbYELTKE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 15:10:04 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id E00AD2BBE5; Mon, 12 May 2008 22:10:02 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <73584838-DF17-4CDB-92CA-363ED9DA9582@gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81911>

On Mon, May 12, 2008 at 12:58:07PM -0600, Tim Harper wrote:
> In our case, we  
> don't bother with repository backups here.  Everyone developer has a  
> full copy of the repository, and any one of them could be used to  
> create a new "central" git repository.

So you assume everyone syncs everyone else often enough. I don't think 
many organizations want to rely on that assumption. The point is to 
have a simple, efficient and manageable backup system that 
does _not_ require knowledge of Git internals.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
