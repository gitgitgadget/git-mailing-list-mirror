From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] doc: add clarification of existing GPLv2 license terms
 to manual pages
Date: Fri, 24 Mar 2006 11:18:06 +1200
Message-ID: <44232CAE.2040102@vilain.net>
References: <20060323015847.4624.61707.stgit@localhost.localdomain> <20060323215759.GW18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 00:18:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMZ4W-0005ub-7w
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 00:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWCWXSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 18:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWCWXSW
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 18:18:22 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:36998 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932555AbWCWXSV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 18:18:21 -0500
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 2E9B15388; Fri, 24 Mar 2006 11:18:14 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 29ABF3938;
	Fri, 24 Mar 2006 11:18:07 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060323215759.GW18185@pasky.or.cz>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17882>

Petr Baudis wrote:
> Dear diary, on Thu, Mar 23, 2006 at 02:58:50AM CET, I got a letter
> where Sam Vilain <sam.vilain@catalyst.net.nz> said that...
> 
>>The GPLv3 is less ambiguous on these things, but a decision on the use
>>of GPLv3 has already been deferred.
> 
> 
> Was it?
> 
> My fulltext =git mailbox search doesn't yield any matches at all.

I refer to this section from COPYING:

 Note that the only valid version of the GPL as far as this project
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

 HOWEVER, in order to allow a migration to GPLv3 if that seems like
 a good idea, I also ask that people involved with the project make
 their preferences known. In particular, if you trust me to make that
 decision, you might note so in your copyright message, ie something
 like

        This file is licensed under the GPL v2, or a later version
        at the discretion of Linus.

  might avoid issues. But we can also just decide to synchronize and
  contact all copyright holders on record if/when the occasion arises.

                        Linus Torvalds

This may become problematic if any of the copyright holders start
becoming Old Ones or otherwise not being contactable...

Sam.
