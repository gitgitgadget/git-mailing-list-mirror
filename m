From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] Have git-cvsserver call hooks/update before really
 altering the ref
Date: Tue, 13 Feb 2007 12:54:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702131253010.1757@xanadu.home>
References: <200702131512.45412.andyparkins@gmail.com>
 <7v7iumymvq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1rX-0003LS-Um
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbXBMRyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbXBMRyk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:54:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47182 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbXBMRyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:54:40 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDE003WJXR3RCI0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Feb 2007 12:54:39 -0500 (EST)
In-reply-to: <7v7iumymvq.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39556>

On Tue, 13 Feb 2007, Junio C Hamano wrote:

> As a principle, I am in favor of this.  Perhaps post 1.5.0 after
> hearing what real cvsserver users have to say on the list.

Andy looks to me like a real cvsserver user though.


Nicolas
