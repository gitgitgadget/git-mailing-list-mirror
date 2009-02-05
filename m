From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 06/11] Implement basic customizable label decorations with preferences
Date: Thu, 5 Feb 2009 21:04:23 +0100
Message-ID: <200902052104.23876.robin.rosenberg.lists@dewire.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <1233795618-20249-6-git-send-email-torarnv@gmail.com> <1233795618-20249-7-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tor Arne =?utf-8?q?Vestb=C3=B8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVATx-00077o-B4
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbZBEUE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZBEUE0
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:04:26 -0500
Received: from mail.dewire.com ([83.140.172.130]:2770 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbZBEUE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:04:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B6712147E880;
	Thu,  5 Feb 2009 21:04:24 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfNOhmBv8amE; Thu,  5 Feb 2009 21:04:24 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 5D7DE147E7FF;
	Thu,  5 Feb 2009 21:04:24 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1233795618-20249-7-git-send-email-torarnv@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108604>


The "assume unchanged" decoration seems lost.

-- robin
