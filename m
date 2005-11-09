From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Problem with template location
Date: Wed, 9 Nov 2005 22:49:04 +0100
Message-ID: <20051109214904.GB23052@ebar091.ebar.dtu.dk>
References: <200511092045.55300.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 09 23:13:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZy81-00057d-W8
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVKIWJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbVKIWJI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:09:08 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:43933 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1030365AbVKIWJG
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 17:09:06 -0500
Received: (qmail 23168 invoked by uid 5842); 9 Nov 2005 21:49:04 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200511092045.55300.alan@chandlerfamily.org.uk>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11420>

On Wed, Nov 09, 2005 at 08:45:55PM +0000, Alan Chandler wrote:
> I am trying to set up a public repository on my server to which I can push 
> stuff
> 
> I have just downloaded the git-core-0.99f-tar.bz2 file and untarred it as me 
> (alan) on account on the server.  My home directory is at /home/alan
> 
> Went in as me into the git-core-0.99f directory and did a make
> 
> Then became ROOT and did 
> 
> make prefix=/usr/local install

Hey, I fell over this today also.  To me it's really quite unintuitive.

Regards,

Peter
