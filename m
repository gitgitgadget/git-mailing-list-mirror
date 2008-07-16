From: Pascal Obry <pascal@obry.net>
Subject: Re: MSysGit Stability
Date: Wed, 16 Jul 2008 16:59:02 +0200
Organization: Home - http://www.obry.net
Message-ID: <487E0CB6.6070203@obry.net>
References: <73fd69b50807151458u22a383a3l343779e47f4161fa@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 17:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ8UF-00032M-Bt
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 17:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759978AbYGPO7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 10:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759616AbYGPO7K
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 10:59:10 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:2508 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489AbYGPO7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 10:59:09 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3496720fkq.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 07:59:07 -0700 (PDT)
Received: by 10.86.93.19 with SMTP id q19mr2170752fgb.69.1216220347495;
        Wed, 16 Jul 2008 07:59:07 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.144.103])
        by mx.google.com with ESMTPS id 12sm1342282fgg.0.2008.07.16.07.59.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 07:59:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <73fd69b50807151458u22a383a3l343779e47f4161fa@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88687>

Joe,

> I'm going to be working with a small dev shop in the near future and
> we would like to use Git for our project.  Two of us are on Macs, but
> the other is on Windows.  I know the options are MSysGit or Git
> through cygwin.  I'm curious which is better to use and if MSysGit is
> even stable yet.  Does anyone have experience running Git on Windows?

Yes, all the time on some quite large projects and since a year now. No 
problem, quite stable. I'm using Git on Cygwin that I build myself 
almost every day. I'm also working with git-svn as many projects I'm 
working on are based on Subversion. At least Git Cygwin is a perfect 
solution on Windows.

> Any experiences you can share?  Is MSysGit ready yet or should we
> wait?

I have never used MSysGit, so I won't comment.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
