From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 16/21] Add Robert Harder's public domain Base64 encoding utility
Date: Sun, 29 Jun 2008 15:51:07 +0200
Message-ID: <200806291551.08166.robin.rosenberg@dewire.com>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org> <1214726371-93520-16-git-send-email-spearce@spearce.org> <1214726371-93520-17-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 15:56:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCxO7-00053M-Dl
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 15:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241AbYF2NzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 09:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756223AbYF2NzY
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 09:55:24 -0400
Received: from [83.140.172.130] ([83.140.172.130]:10685 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755902AbYF2NzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 09:55:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D31C0802E18;
	Sun, 29 Jun 2008 15:55:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0FAvibuWvaK6; Sun, 29 Jun 2008 15:55:21 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 948D08006B7;
	Sun, 29 Jun 2008 15:55:21 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214726371-93520-17-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86803>


Dragging in apache commons libraries seems to be too much at this point, one class, so this choice is
understandable at this point.

Other that that Apache Commons are almost ubiquotous these days and so be considered at every
point when we need external code.

-- robin
