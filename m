From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCHv5 00/17] gitweb: Simple file based output caching
Date: Sun, 24 Oct 2010 14:34:37 -0700
Message-ID: <4CC4A66D.6050500@kernel.org>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 23:34:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA8DN-0005K7-My
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 23:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989Ab0JXVet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 17:34:49 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:41960 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932938Ab0JXVes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 17:34:48 -0400
Received: from voot-cruiser.eaglescrag.net ([216.239.45.19])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o9OLYbQ7025460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 24 Oct 2010 14:34:38 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sun, 24 Oct 2010 14:34:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159893>

> J.H., could you comment on how this series relates to the gitweb code
> *currently* running on git.kernel.org wrt. code?  If possible, could you
> try to compare performance of those two implementations, the one
> presented here in this series, and the one used by git.kernel.org.

Haven't been ignoring this, but been quite busy with a whole pile of
other things (new hardware, kernel issues, patching exploits, generally
going insane).

I'm *HOPING* I can get around to this next week, I've also been working
on a couple of clean-ups in my own code which will likely land 'soon'.

- John 'Warthog9' Hawley
