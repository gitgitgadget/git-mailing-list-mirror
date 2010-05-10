From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git branch documentation improvements
Date: Mon, 10 May 2010 08:22:33 +0200
Message-ID: <4BE7A629.7050709@viscovery.net>
References: <201005070024.41172.ahartmetz@gmail.com> <4BE3BF2F.8050903@viscovery.net> <201005081839.37790.ahartmetz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>
To: Andreas Hartmetz <ahartmetz@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 08:22:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBMO3-0000ht-Dj
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 08:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab0EJGWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 02:22:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50497 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752890Ab0EJGWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 02:22:38 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OBMNu-0006yY-LL; Mon, 10 May 2010 08:22:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4522C1660F;
	Mon, 10 May 2010 08:22:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201005081839.37790.ahartmetz@gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146762>

Am 5/8/2010 18:39, schrieb Andreas Hartmetz:
> On Friday 07 May 2010 09:20:15 Johannes Sixt wrote:
>> But what is wrong with "start-point"? It precisely conveys the meaning of
>> the parameter.
>>
> Look at -f: as far as I understand it moves the branch *head*, so start-point 
> is plain wrong. The "root" of the branch is not moved, or only moved 
> indirectly (not sure if the latter is allowed).

Huh? The purpose of -f is not to *move* a branch head, but to say "trust
me, I know what I'm doing". Why would "start-point" not be suitable in
this case?

-- Hannes
