From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn problem with v1.6.5
Date: Thu, 12 Nov 2009 07:39:37 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AFBADA9.3060401@obry.net>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com> <4AFA91BB.7050402@obry.net> <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com> <4AFB1756.7090708@obry.net> <20091111202201.GA10351@dcvr.yhbt.net> <20091111203413.GA9648@dcvr.yhbt.net> <4AFB32DC.50505@obry.net> <20091111224454.GA16178@dcvr.yhbt.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 07:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8TNL-0007YO-I2
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 07:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbZKLGjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 01:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbZKLGjQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 01:39:16 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:32091 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZKLGjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 01:39:16 -0500
Received: by ey-out-2122.google.com with SMTP id 9so490326eyd.19
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 22:39:20 -0800 (PST)
Received: by 10.213.96.195 with SMTP id i3mr2266315ebn.97.1258007959925;
        Wed, 11 Nov 2009 22:39:19 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-24.w86-205.abo.wanadoo.fr [86.205.111.24])
        by mx.google.com with ESMTPS id 10sm2394226eyd.7.2009.11.11.22.39.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 22:39:18 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091111224454.GA16178@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132740>

Eric,

> Did you try an early version of Adam's patch before it made it into
> git.git by any chance?

No.

> Or, did you by any chance start a fresh import with a v1.6.5 and then
> rsync $GIT_DIR to one created with 1.6.4 and not use --delete with
> rsync?

No. The import has been done with 1.6.4. A filter-branch has been 
applied to fix author names. But AFAIK (will check) it has been done 
with 1.6.4 too.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
