From: Jonas Schneider <JonasSchneider@gmx.de>
Subject: Re: Broken index file - any hope?
Date: Sat, 04 Oct 2008 00:03:55 +0200
Message-ID: <48E696CB.6040405@gmx.de>
References: <48E693E9.708@gmx.de> <20081003215319.GX21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 04 00:07:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klsle-00048n-Vy
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 00:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYJCWDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 18:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYJCWDs
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 18:03:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:58442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753409AbYJCWDs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 18:03:48 -0400
Received: (qmail invoked by alias); 03 Oct 2008 22:03:46 -0000
Received: from dslb-088-066-013-107.pools.arcor-ip.net (EHLO [192.168.1.33]) [88.66.13.107]
  by mail.gmx.net (mp045) with SMTP; 04 Oct 2008 00:03:46 +0200
X-Authenticated: #19141570
X-Provags-ID: V01U2FsdGVkX199kZ8CCTd9JcbzXSQTchI7zhOv4uR3zKcjBZ9F/M
	OLx8QV+1bFSkzf
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081003215319.GX21310@spearce.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97457>

Shawn O. Pearce schrieb:
>   git read-tree --reset HEAD
Sadly, this doesnt help. I still get the same error.
But, if I remove the corrupt index file, I get this:

fatal: just how do you expect me to merge 0 trees?

Does not look like a good sign :/
Are all my branches (branch==tree?) gone? (okay, werent that much)

Thanks anyway :)
-- Jonas
