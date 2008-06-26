From: Pascal Obry <pascal@obry.net>
Subject: git-svn branches creation question
Date: Thu, 26 Jun 2008 17:55:39 +0200
Organization: Home
Message-ID: <4863BBFB.8010305@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: pascal@obry.net, Git Mailing-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 15:56:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBrxm-0002J9-3i
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 15:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbYFZNzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 09:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbYFZNzk
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 09:55:40 -0400
Received: from smtp2b.orange.fr ([80.12.242.145]:61773 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbYFZNzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 09:55:39 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b12.orange.fr (SMTP Server) with ESMTP id F033F7000094;
	Thu, 26 Jun 2008 15:55:37 +0200 (CEST)
Received: from [127.0.0.1] (AVelizy-154-1-88-114.w86-217.abo.wanadoo.fr [86.217.126.114])
	by mwinf2b12.orange.fr (SMTP Server) with ESMTP id A4D707000092;
	Thu, 26 Jun 2008 15:55:37 +0200 (CEST)
X-ME-UUID: 20080626135537675.A4D707000092@mwinf2b12.orange.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080509 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86455>


Is it possible to create and track new branches (or tags) using git-svn?

I know how to track existing branches, but new ones?

Some context. I'm tracking a CVS repository doing update from time to 
time on the master branch (using simply rsync and git-svn dcommit). Now 
I want to add a new tag for updates on the master. Currently I'm using 
svn copy. I'd like to do this directly from Git.

Thanks.

-- 
    Pascal Obry
    --
    gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
