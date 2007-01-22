From: Nicolas Pitre <nico@cam.org>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Mon, 22 Jan 2007 12:23:24 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701221220300.3011@xanadu.home>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
 <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <20070121134308.GA24090@1wt.eu>
 <7v7ivg1a25.fsf@assigned-by-dhcp.cox.net> <45B3C3B4.6000706@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Willy Tarreau <w@1wt.eu>,
	git@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 18:23:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H92tG-0003WU-3t
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 18:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXAVRX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 12:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbXAVRX0
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 12:23:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24497 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbXAVRXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 12:23:25 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCA006MK5N0LS60@VL-MH-MR001.ip.videotron.ca>; Mon,
 22 Jan 2007 12:23:24 -0500 (EST)
In-reply-to: <45B3C3B4.6000706@zytor.com>
X-X-Sender: nico@xanadu.home
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37432>

On Sun, 21 Jan 2007, H. Peter Anvin wrote:

> In general, though, I would agree that the major number should change if there
> is an incompatible change.

Maybe when those incompatible features are enabled by default.  Right 
now they're not.


Nicolas
