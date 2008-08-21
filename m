From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] filter-branch: Grok special characters in tag names
Date: Thu, 21 Aug 2008 14:35:03 -0500
Message-ID: <ON1COPVuxZx0fvgxvAxMTeg1TI9wGwA6G-XV3THb5Y5XvUoIzNchBg@cipher.nrlssc.navy.mil>
References: <1219329911-31620-1-git-send-email-johannes.sixt@telecom.at> <NWVPkDIELqWBHTU58gfzDqO8HR575ZDJVO2pYdPMtqv9aBLzMLvyZg@cipher.nrlssc.navy.mil> <200808212107.33474.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Aug 21 21:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWFxS-0003j1-N5
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 21:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170AbYHUTfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 15:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756166AbYHUTfa
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 15:35:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41439 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbYHUTf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 15:35:29 -0400
Received: by mail.nrlssc.navy.mil id m7LJZ3Xi001898; Thu, 21 Aug 2008 14:35:03 -0500
In-Reply-To: <200808212107.33474.johannes.sixt@telecom.at>
X-OriginalArrivalTime: 21 Aug 2008 19:35:03.0280 (UTC) FILETIME=[01F14700:01C903C5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93188>

Johannes Sixt wrote:

> (The '.*' in /^foo .*/c\\ is unnecessary.)

Yeah, I noticed after I sent it.

-brandon
