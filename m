From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: determine the list of header files using a
 glob
Date: Fri, 27 Nov 2009 09:50:47 +0100
Message-ID: <4B0F92E7.8090403@viscovery.net>
References: <4B0F8825.3040107@viscovery.net> <20091127082624.GA19875@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 09:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDwXY-0004OW-JT
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 09:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbZK0Iup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 03:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbZK0Iup
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 03:50:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39038 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750971AbZK0Iuo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 03:50:44 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NDwXP-0008LN-RU; Fri, 27 Nov 2009 09:50:47 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7E6EB1660F;
	Fri, 27 Nov 2009 09:50:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091127082624.GA19875@glandium.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133878>

Mike Hommey schrieb:
> I don't know if the current Makefile works with Solaris' make,...

No, it doesn't. You have to use GNU make anyway.

-- Hannes
