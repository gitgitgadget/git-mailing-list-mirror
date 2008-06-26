From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn branches creation question
Date: Thu, 26 Jun 2008 21:05:22 +0200
Organization: Home - http://www.obry.net
Message-ID: <4863E872.4070904@obry.net>
References: <4863BBFB.8010305@obry.net> <32541b130806260908m7ca2060bub071da52aa7a33ce@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing-List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 21:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwne-0007vw-Dh
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 21:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbYFZTFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbYFZTFd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 15:05:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:8903 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbYFZTFc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 15:05:32 -0400
Received: by yw-out-2324.google.com with SMTP id 9so35839ywe.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 12:05:28 -0700 (PDT)
Received: by 10.103.170.13 with SMTP id x13mr164150muo.52.1214507127678;
        Thu, 26 Jun 2008 12:05:27 -0700 (PDT)
Received: from ?192.168.0.100? ( [86.217.126.114])
        by mx.google.com with ESMTPS id y6sm2234938mug.15.2008.06.26.12.05.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 12:05:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <32541b130806260908m7ca2060bub071da52aa7a33ce@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86476>

Avery,

> And creating branches in svn is a single command, even if you don't
> have an svn checkout:
> 
>    svn cp $SVN/trunk $SVN/branches/whatever

That's what I'm doing as I said in my message.

> So it seems unnecessary to duplicate this feature in git.

Well it would be quite handy to work on Git directly (eventually 
off-line) and doing the final "git svn dcommit" to update the subversion 
repository and creating the branches if necessary.

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
