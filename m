From: Gerrit Pape <pape@smarden.org>
Subject: git-commit could allow grouping of short options
Date: Sat, 3 Feb 2007 22:41:51 +0000
Message-ID: <20070203224151.19678.qmail@41f6d84bf5aaea.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 23:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDTZd-0005iR-6e
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 23:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbXBCWlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 17:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXBCWlb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 17:41:31 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:58262 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1751771AbXBCWla (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 17:41:30 -0500
Received: (qmail 19679 invoked by uid 1000); 3 Feb 2007 22:41:51 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38616>

Hi, please see http://bugs.debian.org/407241:

> git-commit could allow grouping of short options, rather than failing:
> 
> $ git commit -avs
> Usage: /usr/bin/git-commit [-a] [-s] [-v] [--no-verify] ...

I personally would like this too, not only for git-commit.

Thanks, Gerrit.
