From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 0/3] Request for help: graph-based UI
Date: Tue, 21 Jul 2009 21:40:32 +0200
Message-ID: <200907212140.32520.robin.rosenberg@dewire.com>
References: <cover.1247408350u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:40:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLCg-0001dE-46
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 21:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbZGUTki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 15:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbZGUTki
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 15:40:38 -0400
Received: from mail.dewire.com ([83.140.172.130]:6828 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbZGUTki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 15:40:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1409A1481DB3;
	Tue, 21 Jul 2009 21:40:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JvhqHuZmLOUo; Tue, 21 Jul 2009 21:40:34 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 741731481D84;
	Tue, 21 Jul 2009 21:40:34 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <cover.1247408350u.git.johannes.schindelin@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123686>

Diff yes, absolutely.

As for the graph, have you considered using JGraph (LGPL) or some
other  graph toolkit.

I'm not sure jgit gui in any advanced version belong in jgit itself, but should
probably be a project on its' own and let jgit stay as building blocks for more
advanced stuff, such as EGit, NbGit, Gerrit and others, and of course the gui
of yours. 

I'm not likely to have much time for much non-Eclipse GUI stuff, but I do
think this is a sensible project. 

-- robin
