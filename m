From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Problem with git-svnimport
Date: Thu, 18 Oct 2007 16:06:46 -0700
Message-ID: <4717E706.5040500@midwinter.com>
References: <55DDB08CC9CD2941A70E8D626789A2C906A4031A@ec8l7ljvo9h5dde.hosting.exch> <20071018180916.GK26127@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: VAUCHER Laurent <VAUCHER@fermat.eu>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Oct 19 01:07:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IieSE-0003nr-CM
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 01:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162AbXJRXGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 19:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758028AbXJRXGv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 19:06:51 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54821 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757550AbXJRXGu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 19:06:50 -0400
Received: (qmail 31209 invoked from network); 18 Oct 2007 23:06:48 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=oI20zIekJJRuta7ZYclFwPByHX9TgwKwpAqUQ9SRTVE3rkJn9j25YOfkmnx0nw4K  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 18 Oct 2007 23:06:48 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20071018180916.GK26127@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61573>

Jan Hudec wrote:
> git-svnimport is obsoleted (or mostly so) by git-svn. Look at that, please.
>   

This has been asked before, but I don't think there was a good answer: 
What remaining features does git-svnimport have that git-svn doesn't? It 
would be nice to not have two such tools if one of them doesn't actually 
add any value. Can we safely deprecate git-svnimport in the next release?

-Steve
