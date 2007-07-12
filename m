From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/6] Pack window memory limit, take 2
Date: Thu, 12 Jul 2007 11:46:28 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707121144110.32552@xanadu.home>
References: <1184244952554-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 17:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I90sH-0005Fq-2d
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 17:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbXGLPqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757740AbXGLPqa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 11:46:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30444 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbXGLPq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 11:46:29 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL200DH2P5GMH80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 11:46:28 -0400 (EDT)
In-reply-to: <1184244952554-git-send-email-bdowning@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52299>

On Thu, 12 Jul 2007, Brian Downing wrote:

> This series has my circular buffer errors (hopefully) corrected, and
> the code is a lot cleaner as a bonus.  Also, the options are now named
> --window-memory and pack.windowMemory, and both can take {k,m,g} suffixes.

Acked-by: Nicolas Pitre <nico@cam.org>
(including the amended patches).


Nicolas
