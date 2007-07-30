From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 10:11:39 -0700 (PDT)
Message-ID: <104942.93033.qm@web51008.mail.re2.yahoo.com>
References: <Pine.LNX.4.64.0707300922420.11330@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jul 30 19:12:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFYnY-0004g9-97
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 19:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967506AbXG3RLn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 13:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967501AbXG3RLm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 13:11:42 -0400
Received: from web51008.mail.re2.yahoo.com ([206.190.38.139]:47436 "HELO
	web51008.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S967312AbXG3RLl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 13:11:41 -0400
Received: (qmail 93036 invoked by uid 60001); 30 Jul 2007 17:11:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=WET4iAkb7I3N0aaM9dBkH9uYvx92sPeXuIohHcbH9wjvOHeAjVI8vgidH95Z6WS5lGNCyetrjCCHHXZOfm8CsQml6HMGC9x8SqcdFoqAswSa8Qwa0TYFdsb77+9eTxN6kHvBOCaA9D35U8Ezx7I5cFn/30lAsRrzlbPEH6bMyW8=;
X-YMail-OSG: MXfUXVQVM1nAKPkzujEZYh99Dh_t6IzLmjaoxm0D6W0lhDQ0wBZ5LxFGAMhk83ULALuYDfLU2bOWrvD6JC11s6RdPddtkfDci6hp2EKxu7DP9yFWJ8f3cIKb6dxUnae_hUP2gEh70iWwJjJOG5Xg
Received: from [208.58.8.179] by web51008.mail.re2.yahoo.com via HTTP; Mon, 30 Jul 2007 10:11:39 PDT
In-Reply-To: <Pine.LNX.4.64.0707300922420.11330@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54242>


--- david@lang.hm wrote:

> On Mon, 30 Jul 2007, Matthew L Foster wrote:
> > Local commit order is stored locally right?
> 
> not normally. you could enable reflogs and then mine through the reflogs 
> to find the info, but it's not stored in any easy to access fashion.

Local merge order can be extracted from git? 

-Matt


       
____________________________________________________________________________________
Be a better Heartthrob. Get better relationship answers from someone who knows. Yahoo! Answers - Check it out. 
http://answers.yahoo.com/dir/?link=list&sid=396545433
