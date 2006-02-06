From: Olaf Hering <olh@suse.de>
Subject: git-bisect doesnt record bad commits
Date: Mon, 6 Feb 2006 22:54:42 +0100
Message-ID: <20060206215442.GA12209@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-From: git-owner@vger.kernel.org Mon Feb 06 22:55:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6EJr-0002Bn-0Q
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 22:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWBFVyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 16:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWBFVyo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 16:54:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:7393 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932161AbWBFVyn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 16:54:43 -0500
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D4CCEEA9E
	for <git@vger.kernel.org>; Mon,  6 Feb 2006 22:54:42 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15664>


Is there a reason why git-bisect does only record good ones? I would
really like to know which commits did crash for me. :(

 2006-02-05 14:07 .git/refs/bisect/good-a020ff412f0ecbb1e4aae1681b287e5785dd77b5
 2006-02-05 21:25 .git/refs/bisect/good-f61ea1b0c825a20a1826bb43a226387091934586
 2006-02-06 07:02 .git/refs/bisect/good-f2e46561cc1afa82b18b2fc6efc8510ec57c7d7d
 2006-02-06 10:24 .git/refs/bisect/good-d779188d2baf436e67fe8816fca2ef53d246900f
 2006-02-06 14:37 .git/refs/bisect/good-1cb9e8e01d2c73184e2074f37cd155b3c4fdaae6
 2006-02-06 17:43 .git/refs/bisect/good-54e08a2392e99ba9e48ce1060e0b52a39118419c
 2006-02-06 19:52 .git/refs/bisect/bad
 2006-02-06 21:57 .git/refs/bisect/good-4a4efbdee278b2f4ed91aad2db5c006ff754276e

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
