From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Completion of error handling
Date: Tue, 02 Feb 2010 19:49:16 +0100
Message-ID: <4B6873AC.4030303@web.de>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:55:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcNuL-00075V-H5
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 19:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab0BBSzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 13:55:23 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:52816 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360Ab0BBSzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 13:55:23 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id B177D145FC00E;
	Tue,  2 Feb 2010 19:55:21 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcNoM-0001en-00; Tue, 02 Feb 2010 19:49:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <alpine.LFD.2.00.1002021324290.1681@xanadu.home>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138738>


> What is the likelihood for those function calls to actually fail?

Do you know the probability for failed memory allocations?

Would you like to care for error codes from all Pthread function calls?

Regards,
Markus
