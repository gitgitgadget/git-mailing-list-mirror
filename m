From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 14:45:23 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802101443240.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <alpine.LFD.1.00.0802081250240.2732@xanadu.home>
 <200802091525.36284.kendy@suse.cz>
 <e5bfff550802092323u3ec3c9c8uf6e92399395efd27@mail.gmail.com>
 <alpine.LSU.1.00.0802101207330.11591@racer.site>
 <ee77f5c20802100846g10937a49m4901f88a70a6de0@mail.gmail.com>
 <alpine.LSU.1.00.0802101649110.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Symonds <dsymonds@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 20:46:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOI7o-0003ni-HZ
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 20:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYBJTpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYBJTpb
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 14:45:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59849 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbYBJTpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 14:45:30 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW10031BG7O2AH0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Feb 2008 14:45:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802101649110.11591@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73393>

On Sun, 10 Feb 2008, Johannes Schindelin wrote:

> Resolving 34549 deltas...
>  100% (34549/34549) done

What Git version is this?

You better try out 1.5.4 for packing comparisons.  It produces slightly 
tighter packs than 1.5.3.


Nicolas
