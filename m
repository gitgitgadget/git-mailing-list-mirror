From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/6] merge-recur: Assorted cleanups
Date: Thu, 27 Jul 2006 19:12:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271910350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 27 19:12:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69P4-00027x-Up
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWG0RMD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWG0RMD
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:12:03 -0400
Received: from mail.gmx.de ([213.165.64.21]:9930 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750918AbWG0RMC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:12:02 -0400
Received: (qmail invoked by alias); 27 Jul 2006 17:12:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 27 Jul 2006 19:12:01 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24308>

Hi,

these 6 patches are further cleanups in the spirit of Junio's patch. There 
are 2 TODOs left: one minor, and the big read_tree thing.

Ciao,
Dscho
