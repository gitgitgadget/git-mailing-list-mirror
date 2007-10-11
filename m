From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 09:41:44 +0200
Message-ID: <470DD3B8.1080809@viscovery.net>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>	<470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz> <470DCC76.7070809@viscovery.net> <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Thu Oct 11 09:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifsg9-0005Ka-OI
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 09:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbXJKHls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 03:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755671AbXJKHls
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 03:41:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30816 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbXJKHls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 03:41:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ifsfo-00005N-Re; Thu, 11 Oct 2007 09:41:37 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5FDCDA33B; Thu, 11 Oct 2007 09:41:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60584>

Jonathan del Strother schrieb:
> How are you going to test that git works on paths with spaces if the 
> test suite doesn't run there?

By writing a specific test?

-- Hannes
