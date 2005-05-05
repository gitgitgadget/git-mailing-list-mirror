From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: git and symlinks as tracked content
Date: Thu, 5 May 2005 07:09:43 +0100
Message-ID: <200505050709.43307.alan@chandlerfamily.org.uk>
References: <Pine.LNX.4.21.0505041854040.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 05 08:03:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTZS2-00087a-43
	for gcvg-git@gmane.org; Thu, 05 May 2005 08:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVEEGJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 02:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVEEGJm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 02:09:42 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:12452
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261905AbVEEGJl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 02:09:41 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1DTZYK-0004B7-T1
	for git@vger.kernel.org; Thu, 05 May 2005 07:09:40 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.21.0505041854040.30848-100000@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 05 May 2005 00:03, Daniel Barkalow wrote:

> (on the other hand, it might make sense for git to handle files starting
> with '.', and only skip .git).

definitely only as an option.  I envisage checking out (maybe anonymously) 
from svn or other repositories and then using git locally to manage my own 
development.  It would be preferable for the .git repository not to be 
"polluted" with the svn prisine trees etc 


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
