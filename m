From: Pascal Obry <pascal@obry.net>
Subject: how to hide some branches
Date: Sun, 30 Nov 2008 10:50:01 +0100
Organization: Home - http://www.obry.net
Message-ID: <493261C9.4040608@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 10:51:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6ixh-0007rv-Mg
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 10:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbYK3JuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 04:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbYK3JuK
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 04:50:10 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:55915 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbYK3JuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 04:50:09 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1828869muf.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 01:50:07 -0800 (PST)
Received: by 10.103.240.5 with SMTP id s5mr3964593mur.106.1228038606949;
        Sun, 30 Nov 2008 01:50:06 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-80-99.w86-205.abo.wanadoo.fr [86.205.110.99])
        by mx.google.com with ESMTPS id u9sm5814725muf.34.2008.11.30.01.50.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 01:50:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.18) Gecko/20081105 Thunderbird/2.0.0.18 Mnenhy/0.7.5.0
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101952>


Hello everyone,

I create a new branch for every new feature/fix I work on. After some
time I have many (too much) branch listed when doing:

   $ git branch

I'd like to hide some (not removing them).

Is there a solution for this?

How you people handle this?

Thanks.

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
