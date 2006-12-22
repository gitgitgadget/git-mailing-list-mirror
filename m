From: Nicolas Vilz <niv@iaglans.de>
Subject: git-svn dcommit ignors svn.authorsfile config and -A / --author-file cmd-line-option
Date: Fri, 22 Dec 2006 13:28:36 +0100
Message-ID: <20061222122836.GD9595@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 22 13:28:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxjVe-0007bK-8L
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 13:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWLVM2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 07:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWLVM2T
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 07:28:19 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:1820 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964819AbWLVM2S (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 07:28:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 2D50F3FCF
	for <git@vger.kernel.org>; Fri, 22 Dec 2006 13:28:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 79G8VcnV0kYH for <git@vger.kernel.org>;
	Fri, 22 Dec 2006 13:27:53 +0100 (CET)
Received: from localhost (dslb-088-066-037-196.pools.arcor-ip.net [88.66.37.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 381E83FC4
	for <git@vger.kernel.org>; Fri, 22 Dec 2006 13:27:53 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35169>

Hello again,

I wonder, if git dcommit supports the option or the repo-config key
svn.authors.file... i think it does not, or i do something wrong...

<username> = <name> <email>

did work on git-svn fetch iirc ... but does it on git-svn dcommit, too?

Sincerly
Nicolas
