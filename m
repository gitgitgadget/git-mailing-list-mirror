From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Feature wish: Cloning without history
Date: Thu, 18 May 2006 21:35:05 +0200
Organization: At home
Message-ID: <e4ii8u$p7j$1@sea.gmane.org>
References: <20060518192144.15912.qmail@web25913.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu May 18 21:35:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgoHK-0005Ha-DZ
	for gcvg-git@gmane.org; Thu, 18 May 2006 21:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWERTfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 15:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWERTfT
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 15:35:19 -0400
Received: from main.gmane.org ([80.91.229.2]:50141 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932138AbWERTfS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 15:35:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgoH6-0005Er-09
	for git@vger.kernel.org; Thu, 18 May 2006 21:35:08 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 May 2006 21:35:07 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 May 2006 21:35:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20300>

Sven Ekman wrote:

> Would it be possible to add an option to git-clone to
> skip the complete history? The result should be a
> repository which contains the current head only (or
> maybe a specified tag) and has that commit id added to
> .git/info/grafts. For the fetch process, this would
> certainly have to imply the --no-tags flag.

It is certainly reccuring request.

Check for "shallow clone" in git mailing list archives.

-- 
Jakub Narebski
Warsaw, Poland
