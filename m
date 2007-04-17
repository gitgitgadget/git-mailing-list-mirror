From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Add "stg bury" command,	with the functionnality of contrib/stg-sink.
Date: Wed, 18 Apr 2007 08:42:54 +1200
Message-ID: <4625314E.2050103@vilain.net>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HduWZ-0003dw-1n
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbXDQUng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbXDQUnf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:43:35 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53731 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbXDQUnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 16:43:35 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id A48D413A400; Wed, 18 Apr 2007 08:43:29 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 47EB513A382;
	Wed, 18 Apr 2007 08:43:26 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44820>

Yann Dirson wrote:
> This is the rewrite in python of by stg-sink written in perl.
>
> I changed the name to "bury" since it seems more descriptive of what
> it does, despite being less of an opposite to "float" than "sink" was.
>   

But 'bury' means to hide or even kill.

How about "raise" and "lower" ?

Sam.
