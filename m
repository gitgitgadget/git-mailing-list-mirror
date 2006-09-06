From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 2/2] Teach rev-list an option to read revs from the standard
 input.
Date: Wed, 06 Sep 2006 13:32:22 +0100
Message-ID: <44FEBFD6.10709@shadowen.org>
References: <7v64g1a9f7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 14:33:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKwaK-00076s-BO
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 14:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWIFMcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 08:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIFMcs
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 08:32:48 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:22289 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750799AbWIFMcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 08:32:47 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GKwZq-0005la-Ph; Wed, 06 Sep 2006 13:32:22 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64g1a9f7.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26517>

Ok, I've tested this with an updated version of my patch to make
send-pack use this (which I'll send out following this message) and it
seems to work pretty well.

-apw
