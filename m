From: "Yngve N. Pettersen (Developer Opera Software ASA)" <yngve@opera.com>
Subject: Opera release Git-splitter, a sub-modularizing tool for Git
Date: Tue, 18 Dec 2012 15:51:14 +0100
Organization: Opera Software AS
Message-ID: <op.wpiovoj5qrq7tp@acorna.invalid.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 15:58:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkydG-0001Md-2y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 15:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab2LRO6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 09:58:40 -0500
Received: from smtp.opera.com ([213.236.208.81]:39454 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832Ab2LRO6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 09:58:39 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2012 09:58:39 EST
Received: from acorna.invalid.invalid (126.176.249.62.customer.cdi.no [62.249.176.126])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id qBIEp5GX004679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 18 Dec 2012 14:51:07 GMT
User-Agent: Opera Mail/12.11 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211749>

Hello all,

Today Opera Software released the "Git-splitter", a small tool for  
sub-modularizing code in a git repo, with complete commit history, under  
the Apache 2.0 license.

It's functionality is similar to "git-subtree", but also include a command  
for reversing the process.

The code is hosted on GitHub:  
<https://github.com/operasoftware/git-splitter>

We have announced the release as part of another announcement of released  
code at the Opera Security Group home page:  
<http://my.opera.com/securitygroup/blog/2012/12/18/tls-prober-source-released-under-apache-2-0-license>

-- 
Sincerely,
Yngve N. Pettersen
********************************************************************
Senior Developer		     Email: yngve@opera.com
Opera Software ASA                   http://www.opera.com/
Phone:  +47 96 90 41 51              Fax:    +47 23 69 24 01
********************************************************************
