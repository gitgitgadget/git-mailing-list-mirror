From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: git-svn set-tree bug
Date: Fri, 08 Jun 2007 19:25:15 +0200
Organization: Transmode AB
Message-ID: <1181323515.30670.110.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 19:25:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwiDD-0004qg-Kw
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 19:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968516AbXFHRZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 13:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968334AbXFHRZT
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 13:25:19 -0400
Received: from mail.transmode.se ([83.241.175.147]:47323 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968032AbXFHRZS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 13:25:18 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 08 Jun 2007 19:25:15 +0200
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49488>

trying to do git-svn set-tree remotes/trunk..svn
in my new git-svn repo I get:
config --get svn-remote.svn.fetch :refs/remotes/git-svn$: command returned error: 1

git version 1.5.2.1
