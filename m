From: linux@horizon.com
Subject: Re: More merge questions (why doesn't this work?)
Date: 2 Dec 2005 18:14:50 -0500
Message-ID: <20051202231450.11116.qmail@science.horizon.com>
References: <Pine.LNX.4.64.0512021409320.3099@g5.osdl.org>
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Dec 03 00:15:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiK7C-00027m-S6
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 00:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVLBXOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 18:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVLBXOw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 18:14:52 -0500
Received: from science.horizon.com ([192.35.100.1]:43055 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751111AbVLBXOv
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 18:14:51 -0500
Received: (qmail 11117 invoked by uid 1000); 2 Dec 2005 18:14:50 -0500
To: linux@horizon.com, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0512021409320.3099@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13136>

> and I don't see why you wouldn't get that too.
> 
> Do you have that broken version of git that had problems with "rmdir" and 
> thought the unlink failed? 

Quite possibly; my previous version of git was 27 November.
(I've been using the Debian package builder, which insists on a
full rebuild each time and is thus annoyingly slow... especially
the "xmlto man" part.  I think I'll switch to "make; make install")

Anyway, updated and it works as expected.  Sorry for the spurious
complaint.
