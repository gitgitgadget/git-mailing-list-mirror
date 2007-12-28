From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Hunk splitting in "git gui"
Date: Fri, 28 Dec 2007 13:38:13 +0100
Message-ID: <4774EE35.10905@viscovery.net>
References: <3F129AD6-EA27-4584-B5C8-2866964AB93E@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 13:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8EUD-000164-LM
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 13:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbXL1MiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 07:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbXL1MiT
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 07:38:19 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50958 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbXL1MiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 07:38:19 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J8ETm-0002Rq-Nu; Fri, 28 Dec 2007 13:38:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C4FD04E4; Fri, 28 Dec 2007 13:38:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <3F129AD6-EA27-4584-B5C8-2866964AB93E@wincent.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69282>

Wincent Colaiuta schrieb:
> I'd use "git gui" a lot more if I could split hunks in it (like you can
> in "git add --interactive").
> 
> Problem is, I have zero knowledge of Tcl/Tk. Can someone who has
> knowledge of this offer an opinion on whether this would be a feasible
> project for a beginner? I'm willing to have a shot at it, but before I
> embark on this I'd like to know if others consider it useful and doable!

Look at the sub-thread that started here:

http://article.gmane.org/gmane.comp.version-control.git/68091

Be sure not to skip the explanation why --unidiff-zero is dangerous.

-- Hannes
