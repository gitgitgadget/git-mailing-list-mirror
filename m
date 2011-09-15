From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Anybody home?
Date: Thu, 15 Sep 2011 09:15:11 +0200
Message-ID: <4E71A5FF.5040807@viscovery.net>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 09:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R46Ah-0006DN-3c
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 09:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab1IOHPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 03:15:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46604 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab1IOHPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 03:15:14 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R46AC-00030p-LQ; Thu, 15 Sep 2011 09:15:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2C0ED1660F;
	Thu, 15 Sep 2011 09:15:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.22) Gecko/20110902 Thunderbird/3.1.14
In-Reply-To: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181444>

Am 9/15/2011 6:24, schrieb Joshua Stoutenburg:
> Hey guys, I'm pretty stoked about git -- coming from subversion.
> 
> I'm having a hard time understanding clearly how to set up a git
> server and configure my local machine to pull and push to it.
> 
> I've been reading the git book pdf.  But I think I must have missed
> something.  I feel stranded.

Reading your exchanges elsewhere in this thread, I think you missed that
you don't need a git server at all just to *use* git.

Even when you want to exchange your commits between two or three machines,
all you need is ssh access. There is no *git server* necessary. git is not
svn. ;-)

I thought I'd just mention this to help you streamline your search.

-- Hannes
