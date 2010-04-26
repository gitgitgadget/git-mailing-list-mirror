From: Jakub Narebski <jnareb@gmail.com>
Subject: Which Git projects got accepted in GSoC 2010?
Date: Tue, 27 Apr 2010 01:46:05 +0200
Message-ID: <201004270146.07131.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 27 01:46:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Y0P-0001DR-6r
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 01:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab0DZXqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 19:46:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:46658 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab0DZXqS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 19:46:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2812872fga.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 16:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jTwCb5LO6Ob7eeFmH+VlhckAAwtXT2nZwuRmpsFE5qs=;
        b=eN/DypykzSwXzN2/x3wnuTLceGfKSUaUJG+5G2zT9aSz2aPRMnzBjVTwbNNNRaMDpj
         VpE+W8JkBE8YqYXtyTEo5bSYM/hTo9Mc4lu/lSViZ1ZYQwQEgHaxvAMGYWarnnaiYdFC
         AACPV05oR9QuUsKyH2QNq2CXXMR65u5i0QBic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=X0PbqWSkP8ghGqDhdkXpOjTK9KYJbI1bPzqCKpJ1co+95WZgOZGWtdVivs5/dLXtui
         XP9CjUFnbnTmmvOy4TpayTnJ4OIuVcV9YUt8tN5rHQm14Tw6UCuXf0fZfF8KPMkIRxeJ
         ayxPQj6RJfI1vScVmgd+kXzO0ynNmqHr8lAIQ=
Received: by 10.102.13.24 with SMTP id 24mr2752147mum.6.1272325576413;
        Mon, 26 Apr 2010 16:46:16 -0700 (PDT)
Received: from [192.168.1.13] (abwh49.neoplus.adsl.tpnet.pl [83.8.231.49])
        by mx.google.com with ESMTPS id s10sm19367384muh.35.2010.04.26.16.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 16:46:15 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145861>

Ramkumar Ramachandra wrote in "[GSoC update] Acceptance"
http://permalink.gmane.org/gmane.comp.version-control.git/145852
that his "git-remote-svn | Native SVN support in Git" has been
accepted.

Could you (spearce and Dscho) please add SoC2010Projects page to Git 
Wiki, listing which projects got accepted (similar to SoC2007Projects, 
SoC2008Projects and SoC2009Projects pages)?  Current Melange-powered
GSoC pages are perhaps easier to use by administrators, but it is
hard to find relevant information, especially using outdated web 
browser... :-(

This way there would be additional place where one can put progress 
reports...

Thanks in advance
-- 
Jakub Narebski
Poland
