From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Which packages/versions are needed to build documentation
Date: Wed, 9 Nov 2005 18:49:44 +0000
Message-ID: <200511091849.44362.alan@chandlerfamily.org.uk>
References: <200511091655.51093.alan@chandlerfamily.org.uk> <437230C1.3090700@debian.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 09 19:53:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZv13-0005hl-CV
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 19:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbVKIStq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 13:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbVKIStq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 13:49:46 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:59520
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751525AbVKIStp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 13:49:45 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EZv0y-0001K2-8w
	for git@vger.kernel.org; Wed, 09 Nov 2005 18:49:44 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <437230C1.3090700@debian.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11409>

On Wednesday 09 Nov 2005 17:24, Simon Richter wrote:
> Hi,
>
> > On my debian sarge system it fails almost immediately
>
> Just take the asciidoc package from unstable, last time I looked it had
> no dependencies that were unfulfillable from sarge.
>
>     Simon

Thanks - working now - although I needed to also install xmlto


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
