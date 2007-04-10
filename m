From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 11/10] allow forcing index v2 and 64-bit offset treshold
Date: Tue, 10 Apr 2007 09:23:29 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704100920500.28181@xanadu.home>
References: <alpine.LFD.0.98.0704091727300.28181@xanadu.home>
 <7vps6dxjvb.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704091901290.28181@xanadu.home>
 <7vejmtxekj.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704092046080.28181@xanadu.home>
 <7vlkh0wur7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbGJq-0004P9-QU
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 15:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbXDJNXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 09:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbXDJNXc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 09:23:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14008 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030493AbXDJNXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 09:23:31 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGA003VBAJ5OIJ0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Apr 2007 09:23:30 -0400 (EDT)
In-reply-to: <7vlkh0wur7.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44136>

On Tue, 10 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> >> > ddiff --git a/t/Makefile b/t/Makefile
> >> >> 
> >> >> ???
> >
> > $ touch t/Makefile
> > $ git diff
> 
> This still does not give me doubled d in diff.

Ah!  Maybe I tried to delete it ('dd' in vi) and screwed it somehow.


Nicolas
