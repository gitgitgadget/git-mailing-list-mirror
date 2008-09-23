From: John Freeman <jfreeman@cs.tamu.edu>
Subject: Re: clone fails: Could not get the current working directory
Date: Tue, 23 Sep 2008 08:23:38 -0500
Message-ID: <48D8EDDA.3050804@cs.tamu.edu>
References: <48D59A30.5020403@cs.tamu.edu> <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 15:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki7t8-0004qw-3a
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 15:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbYIWNYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 09:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbYIWNX7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 09:23:59 -0400
Received: from smtp-relay.tamu.edu ([165.91.22.120]:7001 "EHLO
	sr-5-int.cis.tamu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751357AbYIWNX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 09:23:59 -0400
Received: from localhost (localhost.tamu.edu [127.0.0.1])
	by sr-5-int.cis.tamu.edu (Postfix) with ESMTP id 37078118C5;
	Tue, 23 Sep 2008 08:23:58 -0500 (CDT)
X-Virus-Scanned: amavisd-new at tamu.edu
Received: from [192.168.10.200] (r74-192-200-91.bcstcmta02.clsttx.tl.dh.suddenlink.net [74.192.200.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sr-5-int.cis.tamu.edu (Postfix) with ESMTPSA id 97FF7118C4;
	Tue, 23 Sep 2008 08:23:57 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96559>

Alex Riesen wrote:
> Do these work:
>   $ ssh john@remote.system.edu ls -R /home/bob/path/to/repo
>   $ ssh john@remote.system.edu 'cd /home/bob/path/to/repo && pwd'
>   

Yes, they do.  I wish the mailing list did better threading; please see 
my other posts if you happened to miss them:

http://article.gmane.org/gmane.comp.version-control.git/96442
http://article.gmane.org/gmane.comp.version-control.git/96505

Thank you,
John
