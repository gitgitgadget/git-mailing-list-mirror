From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Speed of conversion from Subversion repository to Git
Date: Thu, 11 Feb 2010 18:10:50 +0100
Message-ID: <4B743A1A.5060904@web.de>
References: <4B6717DF.8020004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 18:11:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfcZI-0002ti-V0
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 18:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993Ab0BKRK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 12:10:59 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:49983 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab0BKRK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 12:10:58 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4316E14DAFB08
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 18:10:57 +0100 (CET)
Received: from [78.48.68.13] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NfcZ5-0006O1-00
	for git@vger.kernel.org; Thu, 11 Feb 2010 18:10:55 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <4B6717DF.8020004@web.de>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19Ah7psMYhn8UC7mXgPZhDhAxwCyWGjn/Lg4hK0
	oc2VJDW7e19JzdB/lz9CAMLiNT2G/SLfzj3W4PfTU3hBRKy5vV
	f12eQeI07T28JvQ5y/jA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139608>

Hello,

Are there any chances to increase the processor utilisation in noticeable ways by multi-threaded programming?
http://git.kernel.org/?p=git/git.git;a=blob;f=git-svn.perl;h=265852f4596bfe5aeca12be06f78631320b8ebb4;hb=HEAD

Do any conversion tasks exist which would benefit from parallel processing?

Regards,
Markus
