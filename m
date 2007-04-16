From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/9] a couple cleanups and fixes to pack-objects
Date: Mon, 16 Apr 2007 12:14:18 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704161202320.4504@xanadu.home>
References: <11767005762964-git-send-email-nico@cam.org>
 <7vslb0x4ww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTrP-0002jZ-KP
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030819AbXDPQOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030822AbXDPQOV
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:14:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41237 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030818AbXDPQOT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:14:19 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL00CG0MFU58E0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:14:18 -0400 (EDT)
In-reply-to: <7vslb0x4ww.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44656>

On Sun, 15 Apr 2007, Junio C Hamano wrote:

> We probably found a bug in send-email.
> 
>    Date: Mon, 16 Apr 2007 01:16:07 -0400
>    From: Nicolas Pitre <nico@cam.org>
>    Subject: [PATCH 0/9] a couple cleanups and fixes to pack-objects
>    To: Junio C Hamano <junkio@cox.net>, "--cc git"@vger.kernel.org
>    Cc: 
>    Message-id: <11767005762964-git-send-email-nico@cam.org>
>    X-Mailer: git-send-email 1.5.1.1.781.g65e8
>    Content-transfer-encoding: 7BIT
>    Xref: gitster.siamese.dyndns.org git-mail:23396
>    Lines: 6
> 
>    Here's a couple patches to clean up pack-objects which should also provide
>    small performance gains, probably more visible on really large repositories.
> 
>    Nicolas
> 
> Your patches did not reach the list.

Well... I guess I, too, should avoid git-send-email from now. I don't 
have enough knowledge of the mail/anti-spam protocol/pitfalls to fix it 
myself.

Here are those patches again, manualy posted.


Nicolas
