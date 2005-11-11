From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Should have been what is cg-clone doing (Re: What is cg-clone)
Date: Fri, 11 Nov 2005 07:03:14 +0000
Message-ID: <200511110703.14683.alan@chandlerfamily.org.uk>
References: <200511110656.29553.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 08:03:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaSwL-0004db-9d
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 08:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVKKHDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 02:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVKKHDI
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 02:03:08 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:33929
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751234AbVKKHDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 02:03:07 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EaSwE-0008EF-GE
	for git@vger.kernel.org; Fri, 11 Nov 2005 07:03:06 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <200511110656.29553.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11566>

On Friday 11 Nov 2005 06:56, Alan Chandler wrote:
> Just trying to set up my public repository and test it.
>
> cg-clone http://www.chandlerfamily.org.uk/git/famtree.git new
>
> When I get near the end the following happens:
>
> http://www.chandlerfamily.org.uk/git/famtree.git/refs/tags/:
> 05:46:53 ERROR 403: Forbidden.
>
> I suspect its trying to get a list of tags, but is the ":" part of the
> error message, or was that what it was trying to receive.
>
> Does it require that apache serves the directories properly, because at the
> moment I have DirectoryIndex on these set to gitweb.cgi (although thats
> giving me 403 errors at the moment, hence my suspicions)

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
