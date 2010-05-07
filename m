From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git branch documentation improvements
Date: Fri, 07 May 2010 09:20:15 +0200
Message-ID: <4BE3BF2F.8050903@viscovery.net>
References: <201005070024.41172.ahartmetz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Hartmetz <ahartmetz@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 09:20:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAHrG-0002gi-7B
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 09:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab0EGHUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 03:20:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47654 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753568Ab0EGHUT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 03:20:19 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OAHr5-0001Xo-Mv; Fri, 07 May 2010 09:20:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 72D4C1660F;
	Fri,  7 May 2010 09:20:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201005070024.41172.ahartmetz@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146528>

Am 5/7/2010 0:24, schrieb Andreas Hartmetz:
> The most significant change is renaming <start-point> (or is it 
> <startpoint>...) to <branch-head> because even I as a relative beginner know 
> that a branch is defined by its (movable) head, and <start-point> *does* 
> actually specify the new branch head if I'm not mistaken.

But what is wrong with "start-point"? It precisely conveys the meaning of
the parameter.

-- Hannes
