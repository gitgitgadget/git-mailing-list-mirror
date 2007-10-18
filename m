From: Steven Grimm <koreth@midwinter.com>
Subject: Subversion developer: svn is for dumb people
Date: Thu, 18 Oct 2007 07:25:36 -0700
Message-ID: <47176CE0.7030609@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: 'git' <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 16:26:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiWJr-0000ZY-Ul
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 16:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763831AbXJROZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 10:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763523AbXJROZk
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 10:25:40 -0400
Received: from tater.midwinter.com ([216.32.86.90]:60318 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763438AbXJROZj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 10:25:39 -0400
Received: (qmail 28306 invoked from network); 18 Oct 2007 14:25:38 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=lu+zAMewUUlOfvBnc2oaqZQ3/Eu1vaLbKP6aN0gBgSR+SOhf2/EvmfBvpR1xf5RI  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 18 Oct 2007 14:25:38 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61534>

Thought folks here might get a kick out of this:

http://blog.red-bean.com/sussman/?p=79

Okay, my summary is slightly facetious, but that's basically the gist of 
what he's saying: you should choose Subversion rather than a DVCS 
because most of your users won't be smart enough to use the better tool.

I can't say he's completely wrong, especially about the 20/80% idea 
(though I think "20%" is generous), but some of his specific arguments 
about DVCS are on the bogus side. "Centralized systems encourage code 
reviews," for one -- I challenge him to find a project with a more 
pervasive and effective code-reviewing culture than the git project. I 
find code reviews *harder* in a centralized system because you end up 
building external tools to help people try out each other's changes.

-Steve
