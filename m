From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 02/13] declare overflow during base128 decoding when 1 MSB
 nonzero, not 7
Date: Thu, 05 Apr 2007 20:35:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704052033350.28181@xanadu.home>
References: <56b7f5510704051524p28eafc18mae3131ef13cdabfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 02:35:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZcQe-0006OP-U1
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 02:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767328AbXDFAfp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 20:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767451AbXDFAfp
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 20:35:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55544 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767328AbXDFAfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 20:35:44 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG1001B8WBJQO80@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Apr 2007 20:35:43 -0400 (EDT)
In-reply-to: <56b7f5510704051524p28eafc18mae3131ef13cdabfa@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43888>


This patch looks completely wrong to me.  Please explain why you're 
doing this?


Nicolas
