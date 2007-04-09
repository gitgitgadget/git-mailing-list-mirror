From: Nicolas Pitre <nico@cam.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 09 Apr 2007 13:32:26 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091328130.28181@xanadu.home>
References: <11760951973172-git-send-email-nico@cam.org>
 <20070409171925.GS5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 21:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaxjD-0004AT-Kb
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 19:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbXDIRc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 13:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbXDIRc2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 13:32:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57562 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbXDIRc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 13:32:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG800D10RE2TS30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 13:32:26 -0400 (EDT)
In-reply-to: <20070409171925.GS5436@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44061>

On Mon, 9 Apr 2007, Shawn O. Pearce wrote:

> It is unfortunate that we are changing the index file format without
> also bringing in packv4 support at the same time.  I have just been
> too swamped in useless bulls**t in day-job work to spend time on
> Git lately.

Well... I still did index v2 with pack v4 in mind.  The diference 
between index v2 and v3 would be minimal.

Pack v4 is coming along.  Slowly but still coming.


Nicolas
