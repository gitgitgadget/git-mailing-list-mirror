From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] allow git to use the PATH for finding subcommands and
 help   docs
Date: Fri, 19 Oct 2007 09:33:03 +0200
Message-ID: <47185DAF.7060809@viscovery.net>
References: <20071019065931.GB1463@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Scott R Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 10:09:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Iimud-0001wv-0Q
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967233AbXJSIAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967058AbXJSIAF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:00:05 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31953 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967218AbXJSIAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:00:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IimkF-0004Yh-2L; Fri, 19 Oct 2007 09:58:11 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8124A546; Fri, 19 Oct 2007 09:33:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071019065931.GB1463@srparish.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61667>

Scott R Parish schrieb:
>  + check PATH for git_exec_path after other locations but before builtin
>  + prepend MANPATH and PERL5LIB in addition to PATH

This says *what* the patch does, but not *why*. Care to explain?

And then your explanation should go into the commit message.

-- Hannes
