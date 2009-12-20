From: Pascal Obry <pascal@obry.net>
Subject: Re: git svn clone just stops
Date: Sun, 20 Dec 2009 10:44:41 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B2DF209.1010200@obry.net>
References: <1260915555.6475.8.camel@mark.engr.acx> <20091216081514.GB26038@dcvr.yhbt.net> <4B2B990B.9060502@obry.net> <20091220085731.GA11535@dcvr.yhbt.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Jerkovic <mjerkovic@aconex.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 20 10:44:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMILQ-00079g-F3
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 10:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZLTJoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 04:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbZLTJoq
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 04:44:46 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:57448 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZLTJop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 04:44:45 -0500
Received: by ewy1 with SMTP id 1so5210538ewy.28
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 01:44:43 -0800 (PST)
Received: by 10.216.86.11 with SMTP id v11mr2225311wee.220.1261302283679;
        Sun, 20 Dec 2009 01:44:43 -0800 (PST)
Received: from ?192.168.1.11? (ARouen-552-1-71-154.w92-152.abo.wanadoo.fr [92.152.150.154])
        by mx.google.com with ESMTPS id 28sm14847743eye.11.2009.12.20.01.44.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Dec 2009 01:44:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091220085731.GA11535@dcvr.yhbt.net>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135528>

Hi Eric,

> --revision may be passed to fetch, but its optional.  fetch should
> always know where to pickup after it left off.

Ok, thanks for the info.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
