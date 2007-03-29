From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH] checkout -d: explicitly detach HEAD even when switching to the tip of a branch
Date: Thu, 29 Mar 2007 22:54:23 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703292054.l2TKsNRi010668@localhost.localdomain>
References: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net> <200703291044.l2TAig5M021533@localhost.localdomain> <20070329171024.GA2809@steel.home>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: junkio@cox.net, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX2cX-0007t9-QV
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 23:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbXC2V5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 17:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbXC2V5W
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 17:57:22 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:52682 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422642AbXC2V5W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 17:57:22 -0400
Received: from zogzog.home (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 3C1223823D;
	Thu, 29 Mar 2007 23:57:21 +0200 (CEST)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2TKsNwo010671;
	Thu, 29 Mar 2007 22:54:23 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2TKsNRi010668;
	Thu, 29 Mar 2007 22:54:23 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <20070329171024.GA2809@steel.home> (raa.lkml@gmail.com)
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43480>


   A throw-away or an experimental work. A commit importer which cares
   about the branch it commits on: to update the branch reference only
   when it has reached a stable state.

Hum, yes, I see. Thank you.

Xavier
