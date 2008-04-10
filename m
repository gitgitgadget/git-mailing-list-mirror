From: Pascal Obry <pascal@obry.net>
Subject: Question about Tig
Date: Thu, 10 Apr 2008 17:47:05 +0200
Organization: Home - http://www.obry.net
Message-ID: <47FE3679.1020604@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 17:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjz0M-0003K1-TY
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280AbYDJPrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758264AbYDJPrO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:47:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:34682 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222AbYDJPrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:47:12 -0400
Received: by fg-out-1718.google.com with SMTP id l27so33104fgb.17
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 08:47:10 -0700 (PDT)
Received: by 10.86.59.2 with SMTP id h2mr3347723fga.19.1207842430357;
        Thu, 10 Apr 2008 08:47:10 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.112.72])
        by mx.google.com with ESMTPS id 12sm1583027fgg.6.2008.04.10.08.47.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Apr 2008 08:47:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79221>

I want to stage only some hunks and not the whole file.

The way to do this is:

    - to open the status view S
    - select a file
    - move the cursor up/down using j/k keys
    - when inside the right hunk, press 'u'

Fine. But a bit tedious. Is there a way to navigate one hunk
down/up? It would be very handy I think.

Thanks,
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
