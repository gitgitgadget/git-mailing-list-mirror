From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 11/12] documentation: replace Discussion section by	link
 to user-manual chapter
Date: Sun, 16 Sep 2007 21:38:27 +0200
Message-ID: <46ED8633.9070000@op5.se>
References: <11893670591013-git-send-email-bfields@citi.umich.edu> <11893670592312-git-send-email-bfields@citi.umich.edu> <11893670593596-git-send-email-bfields@citi.umich.edu> <11893670592701-git-send-email-bfields@citi.umich.edu> <11893670593670-git-send-email-bfields@citi.umich.edu> <1189367060244-git-send-email-bfields@citi.umich.edu> <11893670603146-git-send-email-bfields@citi.umich.edu> <11893670603581-git-send-email-bfields@citi.umich.edu> <11893670601869-git-send-email-bfields@citi.umich.edu> <46E45F45.3040109@op5.se> <20070916015606.GA5118@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 21:38:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWzx9-0000VW-Q1
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 21:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbXIPTib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 15:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbXIPTib
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 15:38:31 -0400
Received: from mail.op5.se ([193.201.96.20]:57611 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbXIPTia (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 15:38:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CE3C31943F7;
	Sun, 16 Sep 2007 21:38:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.000, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kzyrr1mfVTlJ; Sun, 16 Sep 2007 21:38:28 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 4BF801943AE;
	Sun, 16 Sep 2007 21:38:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070916015606.GA5118@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58337>

J. Bruce Fields wrote:
> On Sun, Sep 09, 2007 at 11:01:57PM +0200, Andreas Ericsson wrote:
>> J. Bruce Fields wrote:
>>> +
>>> +A git project normally consists of a working directory with a ".git"
>>> +subdirectory at the top level.  The .git directory contains, among other
>>> +things, a compressed object database representing the complete history
>>> +of the project, a set of pointers into that history ("refs")
>> ... into that history ("refs" - branches and tags)
> 
> I slept on it and took another look, and decided you were right; this is
> what I have there now:
>  
>   A git project normally consists of a working directory with a ".git"
>   subdirectory at the top level.  The .git directory contains, among
>   other things, a compressed object database representing the complete
>   history of the project, an "index" file which links that history to
>   the current contents of the working tree, and named pointers into that
>   history such as tags and branch heads.
>  

Looks good. Thanks :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
