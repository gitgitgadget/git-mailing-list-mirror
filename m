From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 02/19] Delete incorrect Javadoc from Config's getRawString method
Date: Sat, 25 Jul 2009 22:32:30 +0200
Message-ID: <200907252232.30712.robin.rosenberg.lists@dewire.com>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org> <1248547982-4003-2-git-send-email-spearce@spearce.org> <1248547982-4003-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 22:33:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUnw1-00029o-S7
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 22:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZGYUcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 16:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbZGYUcc
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 16:32:32 -0400
Received: from mail.dewire.com ([83.140.172.130]:23714 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbZGYUcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 16:32:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A2C5F1481DBD;
	Sat, 25 Jul 2009 22:32:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i3qOGuP+Vk-W; Sat, 25 Jul 2009 22:32:31 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 495F91481DB2;
	Sat, 25 Jul 2009 22:32:31 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1248547982-4003-3-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124065>

l=F6rdag 25 juli 2009 20:52:45 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> I don't know how this Javadoc got here, but it predates the code
> refactor done by Constantine Plotnikov in 2564768e63.

Why do you think so? The getRawString before his patch did not have any
javadoc. It was added there in that patch.

-- robin
