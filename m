From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Q: how to check for -crlf property for a set of files using git
    command line?
Date: Thu, 15 Oct 2009 11:25:10 +0200
Message-ID: <4AD6EA76.2040400@viscovery.net>
References: <85647ef50910150215w1efec91fu16b1fe13f8acec61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 11:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyMik-0004ze-2p
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 11:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943AbZJOJZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 05:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbZJOJZt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 05:25:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19442 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbZJOJZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 05:25:48 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MyMa6-0006M2-Q5; Thu, 15 Oct 2009 11:25:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 843CA6D9; Thu, 15 Oct 2009 11:25:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <85647ef50910150215w1efec91fu16b1fe13f8acec61@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130382>

Constantine Plotnikov schrieb:
> I'm interested how to check for -crlf property (from .gitattributes)
> on the set of files using git command line. I'm also interested how to
> query for values specified in .gitattributes in general from scripts.
> Parsing .gitattributes looks like too complex way of doing this.

man git-check-attr

-- Hannes
