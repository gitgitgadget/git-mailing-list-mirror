From: Rakotomandimby Mihamina <mihamina@gulfsat.mg>
Subject: choosing an issue tracker
Date: Wed, 02 Dec 2009 12:27:54 +0300
Message-ID: <4B16331A.3060606@gulfsat.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 10:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFlVR-0006Vw-9P
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 10:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbZLBJ2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 04:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZLBJ2F
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 04:28:05 -0500
Received: from smtp-out.malagasy.com ([41.204.120.134]:41051 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbZLBJ2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 04:28:03 -0500
Received: from camel.malagasy.com (camel.malagasy.com [41.204.104.34])
	by smtp-out.malagasy.com (Postfix) with ESMTP id D293E8C132
	for <git@vger.kernel.org>; Wed,  2 Dec 2009 12:31:31 +0300 (EAT)
Received: from localhost (spamassassin.malagasy.com [41.204.104.47])
	by camel.malagasy.com (Postfix) with ESMTP id 74CD4FE9E
	for <git@vger.kernel.org>; Wed,  2 Dec 2009 12:28:05 +0300 (EAT)
X-Virus-Scanned: par antivirus.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.773
X-Spam-Level: 
X-Spam-Status: No, score=-2.773 required=7 tests=[AWL=-0.174, BAYES_00=-2.599]
Received: from camel.malagasy.com ([41.204.104.34])
	by localhost (spamassassin.malagasy.com [41.204.104.47]) (amavisd-new, port 10024)
	with ESMTP id wPuTOp5tAHpU for <git@vger.kernel.org>;
	Wed,  2 Dec 2009 12:31:21 +0300 (EAT)
Received: from rktmb (sysadmin-cnc.malagasy.com [41.204.104.9])
	by camel.malagasy.com (Postfix) with ESMTP id 75ABFFEBC
	for <git@vger.kernel.org>; Wed,  2 Dec 2009 12:27:53 +0300 (EAT)
Received: from localhost ([127.0.0.1])
	by rktmb with esmtp (Exim 4.69)
	(envelope-from <mihamina@gulfsat.mg>)
	id 1NFlV4-0003jY-55
	for git@vger.kernel.org; Wed, 02 Dec 2009 12:27:54 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Shredder/3.0.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134316>

Hi all,

For a while, I used SVN and Trac.
They have a satisfying mutual integration.

I am looking for our new issue tracker, and would like to be advised.

Our context:
- developpers using git, developping
   - web based applications (PHP, Python, OCaml,...)
   - Unix-like system maintainance scripts (SHELL, Perl,...)
- a QA guy that makes functional tests only on the web applications
   and reports bugs and potential improvements. He does not use git.
- multiple projects

What we look for:
something like the (Trac, SVN) but with git as SCM.

What issue tracker would you recommend?

-- 
       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                                    +261 33 11 207 36
