From: David Kastrup <dak@gnu.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:34:25 +0100
Message-ID: <854pf8243i.fsf@lola.goethe.zz>
References: <200711252248.27904.jnareb@gmail.com>
	<858x4l2apc.fsf@lola.goethe.zz>
	<alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwjjD-000563-1b
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbXKZTeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755574AbXKZTeT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:34:19 -0500
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:52732 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755565AbXKZTeS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 14:34:18 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id B86EE1A456E;
	Mon, 26 Nov 2007 20:34:17 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 979F72BEB7D;
	Mon, 26 Nov 2007 20:34:17 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-029-090.pools.arcor-ip.net [84.61.29.90])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 3044C8C489;
	Mon, 26 Nov 2007 20:34:12 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 329F31C4D3AA; Mon, 26 Nov 2007 20:34:24 +0100 (CET)
In-Reply-To: <alpine.LFD.0.99999.0711261417580.9605@xanadu.home> (Nicolas
	Pitre's message of "Mon, 26 Nov 2007 14:30:19 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4927/Mon Nov 26 17:26:42 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66099>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 26 Nov 2007, David Kastrup wrote:
>
>> Get rid of plumbing at the command line level.
>
> We can't get rid of plumbing.

What about "at the command line level" did you not understand?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
