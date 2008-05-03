From: Pascal Obry <pascal@obry.net>
Subject: Re: [ANNOUNCE] tig-0.11
Date: Sat, 03 May 2008 23:11:05 +0200
Organization: Home - http://www.obry.net
Message-ID: <481CD4E9.3080709@obry.net>
References: <20080406200533.GA20537@diku.dk>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat May 03 23:12:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsP1d-0005BW-Na
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 23:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYECVLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 17:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbYECVLV
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 17:11:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:20755 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbYECVLU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 17:11:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1423220fgg.17
        for <git@vger.kernel.org>; Sat, 03 May 2008 14:11:11 -0700 (PDT)
Received: by 10.86.90.13 with SMTP id n13mr7896385fgb.3.1209849071648;
        Sat, 03 May 2008 14:11:11 -0700 (PDT)
Received: from ?192.168.1.10? ( [90.51.149.27])
        by mx.google.com with ESMTPS id 4sm3466763fge.5.2008.05.03.14.11.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 May 2008 14:11:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080406200533.GA20537@diku.dk>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81117>


Jonas,

I see that the '@' key can now move from chunk to chunk. This is nice 
but it would be more user friendly if after staging a hunk the cursor 
was not moved to the first line! I think it would be better to have the 
cursor on top of the next hunk.

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
