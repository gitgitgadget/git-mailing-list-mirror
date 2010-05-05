From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Does recent 'smart' HTTP feature help git-svn thru unfriendly
 corp. firewalls too?
Date: Wed, 05 May 2010 10:33:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005051031280.14468@xanadu.home>
References: <t2td43c95441005050710rb5123219v9ca23aebc01e40ad@mail.gmail.com>
 <20100505141636.GG11053@spearce.org>
 <i2yd43c95441005050720rccceadcex88a2ce6730d96a5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Michael Norman <mwnorman@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 16:34:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9fg0-00034y-U7
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760303Ab0EEOdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 10:33:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54653 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760279Ab0EEOdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 10:33:39 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L1Y00I9KB3REQH0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 May 2010 10:33:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <i2yd43c95441005050720rccceadcex88a2ce6730d96a5d@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146402>

On Wed, 5 May 2010, Michael Norman wrote:

> Sigh - most SVN installations require ssh+svn for read/write access.
> 
> Our company is changing firewall vendors and I have been told that our
> TortoisePlink+putty-session 'trick' may be blocked :-(

Any firewall installation ought to be configurable and allow for letting 
through selected ssh connections.  If no I suggest you change firewall 
vendors again.


Nicolas
