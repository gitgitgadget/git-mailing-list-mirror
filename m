From: Roddie Grant <gitlist@myword.co.uk>
Subject: Re: "Resetting" a repository
Date: Wed, 28 Sep 2011 08:52:28 +0100
Message-ID: <4E82D23C.4020400@myword.co.uk>
References: <4E81EAA7.5030708@myword.co.uk> <861uv27y6k.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 09:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8owV-0002QK-C4
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 09:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab1I1Hwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 03:52:30 -0400
Received: from mail3.anu.net ([83.96.156.167]:47986 "EHLO mail3.anu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab1I1Hwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 03:52:30 -0400
Received: from Roddie-Grants-MacBook-Pro.local (cpc3-warw13-2-0-cust132.3-2.cable.virginmedia.com [86.17.75.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail3.anu.net (Postfix) with ESMTP id 108BB319995
	for <git@vger.kernel.org>; Wed, 28 Sep 2011 09:52:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <861uv27y6k.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182298>

On 27/09/2011 17:22, Randal L. Schwartz wrote:
>>>>>> "gitlist" == gitlist<gitlist@myword.co.uk>  writes:
>
> gitlist>  I have a project with a test repository and a live repository (and a
> gitlist>  development repository).
>
> You haven't mentioned what kind of access you have to the two repos.
> Are they both bare remote repos?  Or can you just rsync one over the
> other?

Both repos are on the same virtual server. I normally use ssh for git, 
but have full access to the server. Both repos are not bare. The test 
repos is for the customer to test new stuff and the live repos is for 
the world to see the site (it's all for a website).

The development repos is on my laptop, but it's the test and live repos 
I want to get back in step with each other.

Thanks

Roddie Grant
