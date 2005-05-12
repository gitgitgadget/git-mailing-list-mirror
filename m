From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: How to add new tree?
Date: Thu, 12 May 2005 15:44:23 +0400
Message-ID: <200505121544.23902.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 13:38:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWBzq-0005fU-Dl
	for gcvg-git@gmane.org; Thu, 12 May 2005 13:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVELLof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 07:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVELLoa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 07:44:30 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:18569
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261492AbVELLo1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 07:44:27 -0400
Received: (qmail 25916 invoked from network); 12 May 2005 11:44:25 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 12 May 2005 11:44:24 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.7.2
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello.
Probably a lame question but I can figure out how to add new directory to repo 
neither with cogito nor with git.

a simple example:
=========
$mkdir newdir
$cg-add newdir
cg-add: newdir does not exist
$
==========
How can this be resolved?

-- 
Respectfully
Alexey Nezhdanov

