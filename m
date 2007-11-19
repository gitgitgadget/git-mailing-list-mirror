From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] config: clarify compression defaults
Date: Mon, 19 Nov 2007 12:30:26 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711191230030.19105@xanadu.home>
References: <alpine.LFD.0.99999.0711191139240.19105@xanadu.home>
 <1195491531-2701-1-git-send-email-bdowning@lavos.net>
 <1195491531-2701-2-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonas Juselius <jonas.juselius@chem.uit.no>,
	git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:32:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuASL-0008OZ-Ie
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbXKSRa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbXKSRa1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:30:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36453 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbXKSRa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 12:30:27 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRR008Q7KMQDF60@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Nov 2007 12:30:26 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1195491531-2701-2-git-send-email-bdowning@lavos.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65474>

On Mon, 19 Nov 2007, Brian Downing wrote:

> * Clarify that core.compression provides a system-wide default to
>   other compression parameters.
> 
> * Explain that the default for pack.compression, -1, is "a default
>   compromise between speed and compression (currently equivalent
>   to level 6)" according to zlib.h.
> 
> Signed-off-by: Brian Downing <bdowning@lavos.net>

Looks fine to me.


Nicolas
