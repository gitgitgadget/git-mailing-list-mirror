From: Darren Williams <dsw@gelato.unsw.edu.au>
Subject: Kernel autobuild now uses Git
Date: Wed, 4 May 2005 08:29:51 +1000
Message-ID: <20050503222951.GE26031@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 00:24:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT5o6-0001Aw-JT
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVECWaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVECWaG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 18:30:06 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:24762 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261869AbVECW3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 18:29:54 -0400
Received: From wagner With LocalMail ; Wed, 4 May 2005 08:29:51 +1000 
To: LKML <linux-kernel@vger.kernel.org>,
	Ia64 Linux <linux-ia64@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi All
  Our ia64 autobuild system has been moved from using
BK to Git. Here we do a nightly pull on Linus's 
(not so mainline) Git tree and test the ia64 build.

This may be a benefit to the Git developers to see
the results of a nightly 'cg-pull'.

Thanks to all for the effort, the conversation from BK
to Git was relatively painless.

 - dsw

--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
