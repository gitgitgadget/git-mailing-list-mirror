From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: v1.7.3-rc2 has t7003 breakage on Mac OS X 10.6.4
Date: Thu, 16 Sep 2010 11:04:54 +0200
Message-ID: <4C91DDB6.5000406@viscovery.net>
References: <664FE520-CDB1-4595-867A-9AEB4790C092@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 11:05:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwAOt-0001Hv-KR
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab0IPJE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:04:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38706 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813Ab0IPJE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:04:57 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OwAOk-0003qL-I4; Thu, 16 Sep 2010 11:04:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 47B9C1660F;
	Thu, 16 Sep 2010 11:04:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100824 Thunderbird/3.0.7
In-Reply-To: <664FE520-CDB1-4595-867A-9AEB4790C092@wincent.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156300>

Am 9/16/2010 9:18, schrieb Wincent Colaiuta:
> Just noticed a new test failure in t7003 on Mac OS X 10.6.4. Wasn't present in rc1, but is in rc2.

git pull git://github.com/gitster/git.git bg/fix-t7003

-- Hannes
