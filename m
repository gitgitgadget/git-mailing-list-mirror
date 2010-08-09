From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Possible git status problem at case insensitive file system
Date: Mon, 09 Aug 2010 10:16:57 +0200
Message-ID: <4C5FB979.1020904@viscovery.net>
References: <AANLkTi=87fUaOH3Y0PVeeH5N7oCVVJyKY3jsf93jw-t7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 10:17:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiNXu-0002Qf-Nw
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 10:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab0HIIRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 04:17:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56931 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0HIIRB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 04:17:01 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OiNXW-0003Nh-9Q; Mon, 09 Aug 2010 10:16:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 092351660F;
	Mon,  9 Aug 2010 10:16:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <AANLkTi=87fUaOH3Y0PVeeH5N7oCVVJyKY3jsf93jw-t7@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152957>

Am 8/9/2010 6:22, schrieb Frank Li:
> [about renaming a directory such that only the case changes]

This is normal/expected behavior. A patch series is in the works that
addresses the issue.

-- Hannes
