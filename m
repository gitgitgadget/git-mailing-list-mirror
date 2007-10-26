From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svnimport
Date: Fri, 26 Oct 2007 11:06:43 -0700
Message-ID: <47222CB3.9070100@midwinter.com>
References: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com> <Pine.LNX.4.64.0710251132580.25221@racer.site> <20071026145520.2141.qmail@7a6a65599aed61.315fe32.mid.smarden.org> <Pine.LNX.4.64.0710261745110.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 20:07:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlTaM-000183-UW
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 20:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbXJZSGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 14:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbXJZSGw
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 14:06:52 -0400
Received: from tater.midwinter.com ([216.32.86.90]:55977 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753880AbXJZSGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 14:06:52 -0400
Received: (qmail 30735 invoked from network); 26 Oct 2007 18:06:51 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=unOaBobGxoyJlhAMY6uzIaSwzTJmOOge13YmYpuhlBtDItn99QieTg429FQYc7cZ  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 26 Oct 2007 18:06:51 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <Pine.LNX.4.64.0710261745110.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62434>

Johannes Schindelin wrote:
>> I'm not sure these are worth fixing, I'd rather suggest to drop 
>> git-svnimport in favor of git-svn, and not installing it in future 
>> versions.
>>     
> I already proposed this.  The outcome was... silent.
>   

Me too, and same reaction.

So I vote we interpret that as, "No objections from anyone."

-Steve
