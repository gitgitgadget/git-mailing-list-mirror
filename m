From: Pascal Obry <pascal@obry.net>
Subject: Re: [GIT-SVN] master follows not trunk
Date: Thu, 23 Apr 2009 21:38:15 +0200
Organization: Home - http://www.obry.net
Message-ID: <49F0C3A7.7070400@obry.net>
References: <36ca99e90904220821u3dae67d7jcb6366d7a95dfbd1@mail.gmail.com> <20090423183705.GB17467@dcvr.yhbt.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:39:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4lz-0008PP-QN
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbZDWTiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 15:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbZDWTiS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:38:18 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:58962 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbZDWTiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 15:38:17 -0400
Received: by ewy24 with SMTP id 24so721397ewy.37
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 12:38:15 -0700 (PDT)
Received: by 10.210.20.17 with SMTP id 17mr1449426ebt.2.1240515495749;
        Thu, 23 Apr 2009 12:38:15 -0700 (PDT)
Received: from ?192.168.1.11? (ARouen-256-1-98-176.w92-132.abo.wanadoo.fr [92.132.65.176])
        by mx.google.com with ESMTPS id 28sm529774eyg.48.2009.04.23.12.38.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 12:38:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.5.0
In-Reply-To: <20090423183705.GB17467@dcvr.yhbt.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117373>

Eric,

> However, this issue has come up many times now so maybe setting
> master==trunk if trunk exists (sometimes it does not)...
> 
> Any objections?

I think it is a good idea as this would be just right in most cases.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
