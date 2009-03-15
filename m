From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH] Create a debugging tool "jgit rebuild-commitgraph"
Date: Sun, 15 Mar 2009 12:34:39 +0100
Message-ID: <200903151234.39367.robin.rosenberg@dewire.com>
References: <1236954901-30990-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 15 12:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liodc-0000c9-F6
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 12:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbZCOLes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 07:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZCOLer
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 07:34:47 -0400
Received: from mail.dewire.com ([83.140.172.130]:21308 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbZCOLep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 07:34:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A07A7138AD40;
	Sun, 15 Mar 2009 12:34:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X002bb28Ig0t; Sun, 15 Mar 2009 12:34:40 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 1A8CA80286F;
	Sun, 15 Mar 2009 12:34:40 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <1236954901-30990-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113282>


I'd hate to put such a dangerous thing in the list of normal tools. If the user
want to shoot him/her-self in the foot they should get a license first.

-- robin
