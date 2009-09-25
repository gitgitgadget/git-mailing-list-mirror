From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 12:33:01 +0200
Message-ID: <4ABC9C5D.5030202@viscovery.net>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com> <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 12:33:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr86u-0008GO-5C
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 12:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbZIYKc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 06:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbZIYKc7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 06:32:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48545 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZIYKc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 06:32:58 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mr86o-0006tz-7H; Fri, 25 Sep 2009 12:33:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E86BF9614; Fri, 25 Sep 2009 12:33:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129074>

Marco Costalba schrieb:
> On Fri, Sep 25, 2009 at 10:40, Marco Costalba <mcostalba@gmail.com> wrote:
>> and now
>>
>> git log --pretty=format:%h
>>
> 
> Sorry, the correct command is:
> 
> git log --pretty=format:%H
> 
> but output is still abbreviated.

Doesn't happen here. %h produces abbreviated SHA1s and %H full SHA1s.
However, I don't run msysgit, but compile git myself. I run the commands
from CMD.

-- Hannes
