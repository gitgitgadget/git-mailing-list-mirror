From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-p4: Fix sync errors due to new server version
Date: Mon, 01 Feb 2010 14:57:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002011455440.1681@xanadu.home>
References: <20100201193851.GA6134@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, simon@lst.de, git@vger.kernel.org,
	pal_engstad@naughtydog.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 20:57:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc2P2-0007D9-89
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 20:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993Ab0BAT5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 14:57:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25138 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab0BAT5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 14:57:37 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX600J79I40JY40@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 01 Feb 2010 14:57:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100201193851.GA6134@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138643>

On Mon, 1 Feb 2010, David Aguilar wrote:

> 
> Hi Junio
> 
> It looks like we forgot about this patch:
> 
> http://article.gmane.org/gmane.comp.version-control.git/137723
> 
> The patch looks good and Pal added his sign-off
> (I believe that and not inlining the patch were the original
>  setbacks).
> 
> Simon, are there any reasons to not apply it?

FWIW the patch looks fine to me.  Not that I'm affected by the new 
server version, but the patch can't break anything.


Nicolas
