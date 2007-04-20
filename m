From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFR] gitattributes(5) documentation
Date: Thu, 19 Apr 2007 21:57:23 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704192150510.4504@xanadu.home>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
 <7vslav4yv6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 03:57:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeiNO-0001WO-Ca
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 03:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbXDTB51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 21:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbXDTB51
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 21:57:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52442 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbXDTB50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 21:57:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGR00KHUXFP7XB0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Apr 2007 21:57:26 -0400 (EDT)
In-reply-to: <7vslav4yv6.fsf_-_@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45056>

On Thu, 19 Apr 2007, Junio C Hamano wrote:

> Generating diff text
> ~~~~~~~~~~~~~~~~~~~~
> 
> The attribute `diff` affects if `git diff` generates textual
> patch for the path or just says `Binary files differ`.
> 
> Set::
> 	A path to which the `crlf` attribute is set is treated
                             ^^^^

> 	as text, even when they contain funny bytes such as NUL.
> 
> Unset::
> 	A path to which the `crlf` attribute is unset will
                             ^^^^

> 	generate `Binary files differ`.
> 
> Unspecified::
> 	A path to which the `crlf` attribute is unspecified
                             ^^^^

Remnants of a cut'n paste?


Nicolas
