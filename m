From: =?UTF-8?B?R8OhYm9yIEZhcmthcw==?= <gabor@nekomancer.net>
Subject: Re: Git User's Survey 2007 partial summary
Date: Mon, 27 Aug 2007 13:28:39 +0200
Message-ID: <46D2B567.4000005@nekomancer.net>
References: <200708190128.43515.jnareb@gmail.com> <200708270251.05762.jnareb@gmail.com> <20070827014034.GD18160@spearce.org> <200708271315.07919.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 14:00:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPdGv-00087w-U4
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 14:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbXH0MAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 08:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbXH0MAm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 08:00:42 -0400
Received: from realtime.sk ([217.67.16.60]:46532 "EHLO core.realtime.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbXH0MAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 08:00:41 -0400
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2007 08:00:41 EDT
Received: from localhost (localhost [127.0.0.1])
	by core.realtime.sk (Postfix) with ESMTP id 2EFA2A635A;
	Mon, 27 Aug 2007 13:28:41 +0200 (CEST)
Received: from core.realtime.sk ([127.0.0.1])
 by localhost (core [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16979-09; Mon, 27 Aug 2007 13:28:39 +0200 (CEST)
Received: from [192.168.1.120] (ns1.ba.uptime.at [195.46.69.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by core.realtime.sk (Postfix) with ESMTP id 6E769A49AF;
	Mon, 27 Aug 2007 13:28:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070802)
In-Reply-To: <200708271315.07919.jnareb@gmail.com>
X-Virus-Scanned: amavisd-new at core.realtime.sk
X-Spam-Status: No, hits=-0.855 tagged_above=-999 required=5 tests=[AWL=-0.932,
 TW_GT=0.077]
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56821>

Jakub Narebski wrote:
> 
> I wonder if PyGTK is as portable as Tcl/Tk...

GTK does not run natively on osx, tcl/tk does.


p.s: there are some ways to make GTK run on osx, like running it using 
the apple x11-server, but then it looks ugly and does not have the 
'native' feeling, or try to make it run with the gtk-osx port, which is 
incomplete :)

gabor
