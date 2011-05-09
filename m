From: Jonathan Rogers <jrogers@socialserve.com>
Subject: Re: Qgit should use "git config" instead of "git repo-config"
Date: Mon, 09 May 2011 19:35:30 -0400
Message-ID: <4DC87A42.5000407@socialserve.com>
References: <4DC85AA7.2090502@socialserve.com> <20110509231942.GA23781@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:35:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZzN-0007TR-9A
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445Ab1EIXfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:35:40 -0400
Received: from mail2.socialserve.com ([66.129.73.133]:45219 "EHLO
	mail.socialserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442Ab1EIXfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:35:40 -0400
Received: from jrogers.socialserve.com (jrogers.socialserve.com [10.1.1.118])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jrogers)
	by mail.socialserve.com (Postfix) with ESMTP id 7FAEE175352;
	Mon,  9 May 2011 19:35:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110509231942.GA23781@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173291>

Jonathan Nieder wrote:
> Hi Jonathan,
>
> Jonathan Rogers wrote:
>
>> Here's a small patch to cause qgit to use "git config" instead of
>> "git repo-config" in a couple of places.
> Thanks!  I noticed you also submitted this at [1].
>
> Looking at the qgit source[2] I don't see an address to send patches to;
> cc-ing Marco for advice.
Yes, this list is the only address listed in the docs that I found. It 
looks like some patches have been accepted on the SourceForge project 
have been accepted, but I'm not sure if that's the preferred location.
Thanks for the help.
> Hope that helps,
> Jonathan
>
> [1] http://sourceforge.net/tracker/index.php?func=detail&aid=3299672&group_id=139897&atid=744829
> [2] http://git.kernel.org/?p=qgit/qgit4.git
-- 

Jonathan Ross Rogers
