From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase in progress
Date: Wed, 6 Feb 2008 23:23:14 +0100
Message-ID: <200802062323.15995.robin.rosenberg.lists@dewire.com>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <7vodatvmtl.fsf@gitster.siamese.dyndns.org> <200802062314.39440.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMsgQ-0004a7-CS
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401AbYBFWXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757022AbYBFWXZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:23:25 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11851 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756892AbYBFWXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:23:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4F1FA800697;
	Wed,  6 Feb 2008 23:23:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gV5t9qaAk3bP; Wed,  6 Feb 2008 23:23:23 +0100 (CET)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id DF905800682;
	Wed,  6 Feb 2008 23:23:22 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <200802062314.39440.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72865>


Actually I wrote the patch and Shawn sent back a sligtly better version,
i.e.:

From: Robin Rosenberg <robin.rosenberg@dewire.com>

-- robin
