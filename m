From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Tue, 01 May 2007 10:46:20 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0705011044210.6574@xanadu.home>
References: <463678B7.70409@gmail.com>
 <7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
 <200705010926.35265.andyparkins@gmail.com>
 <7virbc7vue.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 16:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hitcb-0007xp-K2
	for gcvg-git@gmane.org; Tue, 01 May 2007 16:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbXEAOqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 10:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbXEAOqZ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 10:46:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24291 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbXEAOqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 10:46:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHD00843AD9EHC0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2007 10:46:21 -0400 (EDT)
In-reply-to: <7virbc7vue.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45944>

On Tue, 1 May 2007, Junio C Hamano wrote:

> I was not sure if that is even a good idea, and I am now
> inclined to think that keeping the failed attempt history is
> probably better than potentially causing confusion to people who
> follow 'next'.  But it _is_ a possibility to reset 'next' to
> 'master'.

And what is the advantage of doing that, exactly?


Nicolas
