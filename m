From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] sha1_file.c (write_sha1_from_fd): Detect close failure.
Date: Mon, 26 Mar 2007 16:44:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703261644200.3041@xanadu.home>
References: <874po8umyk.fsf@rho.meyering.net>
 <7v8xdjwxr4.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.83.0703261636410.3041@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVw3f-000389-TO
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 22:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbXCZUos (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbXCZUos
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 16:44:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbXCZUos (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 16:44:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFJ001AA2YN5A40@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Mar 2007 16:44:47 -0400 (EDT)
In-reply-to: <alpine.LFD.0.83.0703261636410.3041@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43185>

On Mon, 26 Mar 2007, Nicolas Pitre wrote:

> Instead, teaching git-purge about those tmp files might be a better 
> idea.

git-prune that is.


Nicolas
