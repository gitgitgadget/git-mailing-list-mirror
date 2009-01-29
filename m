From: david@lang.hm
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Wed, 28 Jan 2009 18:57:21 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901281833280.22712@asgard.lang.hm>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com> <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:54:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSM7K-0003Ru-Pq
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 02:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbZA2Bx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 20:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbZA2Bx3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 20:53:29 -0500
Received: from mail.lang.hm ([64.81.33.126]:44332 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbZA2Bx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 20:53:29 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n0T1rP5N021437;
	Wed, 28 Jan 2009 17:53:25 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107610>

On Thu, 29 Jan 2009, Greg Hauptmann wrote:

> Hi,
>
> Do you recommend "git" (over svn) for a 1-person team???   (the
> ability to commit whilst offline on my laptop sounds potentially
> enough reason)

well, if you use svn just put the svn repository on your laptop.

but if you use multiple systems you aren't really a 1-person team, you 
just happen to be one person working in different places.

also the distributed nature of git will make doing (and maintaining) 
backups easier, as well as recovering from the inevitable cases where you 
do development seperatly on your different machines and then need to 
combine them.

David Lang
