From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fatal: BUG: dashless options don't support arguments
Date: Fri, 08 Oct 2010 08:59:12 +0200
Message-ID: <4CAEC140.20905@viscovery.net>
References: <AANLkTi=xscHHPTBtTJ3uXPO9y9gpQTBF4AWTe47C9njU@mail.gmail.com> <AANLkTikqB-EvE6uxgBmutssJoiH2RiPjSxtjbo++Jj-X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Zitzow <bzitzow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 08:59:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P46vK-0001i9-4K
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 08:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab0JHG7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 02:59:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42912 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753372Ab0JHG7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 02:59:14 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P46vA-0007dk-M3; Fri, 08 Oct 2010 08:59:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6DA5A1660F;
	Fri,  8 Oct 2010 08:59:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTikqB-EvE6uxgBmutssJoiH2RiPjSxtjbo++Jj-X@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158478>

Am 10/8/2010 2:06, schrieb Brian Zitzow:
> Hello,
>  I was asked to report this bug error... Environment: OS 10.4.11 PowerPC:
> 
> Ki:$ git branch
> * branch1
>   master
> Ki:$ git checkout master
> fatal: BUG: dashless options don't support arguments
> Ki:$ git --version
> git version 1.7.3.GIT

Maybe related to this one:

http://thread.gmane.org/gmane.linux.kernel/973211/focus=973865

-- Hannes
