From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jun 2011, #01; Sun, 5)
Date: Mon, 06 Jun 2011 09:16:57 +0200
Message-ID: <4DEC7EE9.9060807@viscovery.net>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Theo Niessink <theo@taletn.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 09:17:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTU3c-0000Jb-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 09:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab1FFHRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 03:17:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55255 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab1FFHQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 03:16:59 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QTU3W-0007PF-0X; Mon, 06 Jun 2011 09:16:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BA5761660F;
	Mon,  6 Jun 2011 09:16:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175098>

Am 6/6/2011 8:29, schrieb Junio C Hamano:
> * ef/maint-win-verify-path (2011-05-27) 3 commits
>   (merged to 'next' on 2011-06-01 at f316f68)
>  + verify_path: consider dos drive prefix
>  + real_path: do not assume '/' is the path seperator
>  + A Windows path starting with a backslash is absolute
> 
> Will cook a bit longer.

I agree to all changes. There was a bit of back-and-forth about the
"verify_path" change. Erik, Theo, would you please check whether the
queued version is the one you finally agreed on?

-- Hannes
