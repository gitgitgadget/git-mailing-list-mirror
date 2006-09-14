From: Sam Vilain <sam@vilain.net>
Subject: Re: Marking abandoned branches
Date: Thu, 14 Sep 2006 15:37:35 +1200
Message-ID: <4508CE7F.8080703@vilain.net>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>	 <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 05:37:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNi2w-0002ep-1X
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 05:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWINDhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 23:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWINDhp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 23:37:45 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:20966 "EHLO
	magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750701AbWINDho
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 23:37:44 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id DBB05138282; Thu, 14 Sep 2006 15:37:41 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 5F0A5138280;
	Thu, 14 Sep 2006 15:37:37 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26978>

Jon Smirl wrote:
> It is a historical import. Everything that was in the initial repo
> needs to be preserved otherwise they aren't going to get rid of the
> old CVS repo.
>   

You can tag a tree which contains the raw RCS files used for the import;
then they'll be available forever!

Sam
