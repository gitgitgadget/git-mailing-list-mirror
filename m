From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Thu, 05 Apr 2007 21:04:11 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704052103410.28181@xanadu.home>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 03:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZcsi-0005Rb-Td
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 03:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992788AbXDFBEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 21:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767461AbXDFBEa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 21:04:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21675 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992882AbXDFBEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 21:04:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG100A9WXMZOP10@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Apr 2007 21:04:11 -0400 (EDT)
In-reply-to: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43892>


I still consider this feature to make no sense.


Nicolas
