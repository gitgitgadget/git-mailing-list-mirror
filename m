From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git-svn capabilities
Date: Sun, 9 Dec 2007 11:20:29 +0000
Message-ID: <80A466F9-B7D3-437B-8249-DE4E650CE276@simplicidade.org>
References: <DB0B4F17-9E06-4C28-933E-FDEF9BAD6539@simplicidade.org> <475BA95F.7040403@apple.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 12:30:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1KMS-0000AP-VE
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 12:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbXLIL3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 06:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbXLIL3v
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 06:29:51 -0500
Received: from mail.log.pt ([82.102.10.60]:60017 "EHLO mail.gaia.log.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbXLIL3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 06:29:51 -0500
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Dec 2007 06:29:50 EST
Received: from localhost (mail [192.168.20.14])
	by mail.gaia.log.pt (Postfix) with ESMTP id 4F59B2BE385C;
	Sun,  9 Dec 2007 11:22:05 +0000 (WET)
X-Virus-Scanned: amavisd-new at log.pt
Received: from mail.gaia.log.pt ([192.168.20.14])
	by localhost (mail.gaia.log.pt [192.168.20.14]) (amavisd-new, port 10024)
	with ESMTP id K3hi4k9jvYdc; Sun,  9 Dec 2007 11:21:57 +0000 (WET)
Received: from [192.168.1.68] (bl7-106-211.dsl.telepac.pt [85.240.106.211])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.gaia.log.pt (Postfix) with ESMTP id A83A42BE3809;
	Sun,  9 Dec 2007 11:21:55 +0000 (WET)
In-Reply-To: <475BA95F.7040403@apple.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67619>

Hi,

On Dec 9, 2007, at 8:37 AM, Adam Roben wrote:

> Pedro Melo wrote:
>> I've been following along the gcc/git thread with interest and  
>> I've used Harvey Harrison recipe
>>
>> http://article.gmane.org/gmane.comp.version-control.git/67253
>>
>> with success on several svn repos.
>>
>> One thing that I'm not sure yet if it is possible to do is this:
>>
>> can I have a single central git repo that tracks the svn repo,  
>> allow several developers to use clone to copy that repo, and each  
>> one of them (after proper manual configuration) uses dcommit to  
>> push back to svn?
>>
>> All the recipes so far assume that each developer has to go  
>> through the initial git-svn fetch and have a copy of the entire  
>> SVN repo, and that seems wasteful to me.
>
> The "Basic Examples" section of the git-svn man page describe how  
> to do just that (though only for a single branch).

Sorry, missed that completely :)

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
