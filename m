From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn very slow on fetch (shared git-svn repo)
Date: Sun, 11 Oct 2009 11:37:36 +0200
Organization: Home - http://www.obry.net
Message-ID: <4AD1A760.9060006@obry.net>
References: <4AD04F95.7050603@obry.net> <20091011070136.GB16264@dcvr.yhbt.net> <4AD19E9F.8010302@obry.net> <20091011090338.GA27480@dcvr.yhbt.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 11 11:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwutx-0004Pi-Mb
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 11:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbZJKJha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 05:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbZJKJha
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 05:37:30 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:51821 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZJKJh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 05:37:29 -0400
Received: by ewy4 with SMTP id 4so1733236ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 02:36:52 -0700 (PDT)
Received: by 10.216.89.12 with SMTP id b12mr1556256wef.93.1255253812554;
        Sun, 11 Oct 2009 02:36:52 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-79-118.w86-205.abo.wanadoo.fr [86.205.109.118])
        by mx.google.com with ESMTPS id 5sm5163558eyh.0.2009.10.11.02.36.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 02:36:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091011090338.GA27480@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129911>

Eric,

> Yes, copying .metadata should be enough.

I've put this in place. Works fine.

 > The .rev_map rebuild should be fast.

Yep. Thanks for your quick reply.

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
