From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Allow fetch-pack to decide keeping the fetched pack
 without exploding
Date: Tue, 23 Jan 2007 11:01:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701231101040.3011@xanadu.home>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
 <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 17:02:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9O5u-0008Pa-0r
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 17:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952AbXAWQBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 11:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbXAWQBz
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 11:01:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56179 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932952AbXAWQBy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 11:01:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCB00C5IWJB7M30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 23 Jan 2007 11:01:59 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37542>

On Tue, 23 Jan 2007, Johannes Schindelin wrote:

> On Mon, 22 Jan 2007, Junio C Hamano wrote:
> 
> > We may want to later make this the default.
> 
> You have my vote for sooner rather than later.

Seconded.


Nicolas
