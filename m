From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Do not take mode bits from index after type change.
Date: Sat, 17 Feb 2007 11:31:07 +0100
Message-ID: <200702171131.07304.johannes.sixt@telecom.at>
References: <200702170009.02500.johannes.sixt@telecom.at> <7vodntzljb.fsf@assigned-by-dhcp.cox.net> <7vodntw9u7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 11:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIMqg-00067M-M8
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 11:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbXBQKbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 05:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbXBQKbM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 05:31:12 -0500
Received: from smtp5.noc.eunet-ag.at ([193.154.160.227]:44533 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbXBQKbL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 05:31:11 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 33EAF13A3A9;
	Sat, 17 Feb 2007 11:31:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id DB0D5532F9;
	Sat, 17 Feb 2007 11:31:07 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vodntw9u7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39984>

Your patch works here, too. Thanks!

I'd appreciate if you could publish it soon since it has a few conflicts with 
my current "don't trust symlinks" work.

-- Hannes
