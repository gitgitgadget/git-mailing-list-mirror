From: "Alan Chandler" <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH] Gitweb - provide site headers and footers
Date: Tue, 03 Oct 2006 14:32:02 +0100
Message-ID: <E1GUkNO-0007p9-QJ@home.chandlerfamily.org.uk>
References: <1159879743194-git-send-email-alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 03 15:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUkNo-0003ql-Oz
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 15:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWJCNcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 09:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWJCNcH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 09:32:07 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:44205
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1750812AbWJCNcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 09:32:04 -0400
Received: from alan by home.chandlerfamily.org.uk with local (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GUkNO-0007p9-QJ
	for git@vger.kernel.org; Tue, 03 Oct 2006 14:32:02 +0100
In-Reply-To: <1159879743194-git-send-email-alan@chandlerfamily.org.uk>
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28271>

Alan Chandler writes: 

> From: Alan Chandler <alan@chandlerfamily.org.uk> 
> 
> This allows web sites with a header and footer standard for each page
> to add them to the pages produced by gitweb. 
> 

My web site at http://www.chandlerfamily.org.uk/git shows the example of 
this, although the list of projects is null at the moment, 

That is because I am using the very latest gitweb from master, but git is an 
older version (debian etch) which doesn't understand git --git-dir=... 

I will update to latest git sometime later this week, but I am away on 
business for a couple of days. 


 --
Alan Chandler
alan@chandlerfamily.org.uk
(via webmail - normally means I am not at my computer)
