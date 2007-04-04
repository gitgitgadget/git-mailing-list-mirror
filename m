From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gittorent .. avahi ?
Date: Wed, 04 Apr 2007 02:30:05 +0200
Organization: At home
Message-ID: <euurc0$js8$1@sea.gmane.org>
References: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 02:27:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYtKz-0005Gz-2V
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 02:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbXDDA0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 20:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXDDA0x
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 20:26:53 -0400
Received: from main.gmane.org ([80.91.229.2]:33352 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964868AbXDDA0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 20:26:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HYtKs-0004et-Am
	for git@vger.kernel.org; Wed, 04 Apr 2007 02:26:50 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 02:26:50 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 02:26:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43699>

[Cc: Srijak Rijal <srijak@gmail.com>, git@vger.kernel.org]

Srijak Rijal wrote:

> I hope to be able to implement the gittorrent client/ tracker during
> GoogleSoc (if chosen :) ).

I hope that you have not missed deadline.

> I was thinking about enabling avahi in the clients so that they can
> find peers without putting that much extra load on the tracker.

Avahi is Zeroconf implementation... wouldn't it be better to think
about implementing Kademlia?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
