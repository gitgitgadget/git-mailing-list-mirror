From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : [RFC] just an (stupid) idea when creating a new branch
Date: Sun, 9 Jul 2006 09:48:08 +0000 (GMT)
Message-ID: <20060709094808.74906.qmail@web25811.mail.ukl.yahoo.com>
References: <1152415640.2103.10.camel@dv>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 11:48:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzVte-0003R8-1o
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 11:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWGIJsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 05:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGIJsL
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 05:48:11 -0400
Received: from web25811.mail.ukl.yahoo.com ([217.146.176.244]:57168 "HELO
	web25811.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751319AbWGIJsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 05:48:10 -0400
Received: (qmail 74908 invoked by uid 60001); 9 Jul 2006 09:48:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=IgIQWk1XzrOZG7cw/tqHjwNJPjdwnAXb1E38lBfzWDPe/Frw+Q3JPHXHxDmNJEieiUro+9g/NQq6o9JqMsoWwaKvRG2b6BVOvWl+5X/lUe5COZWmXpa2Du8fpDx2PyLMCAVOc4D80Ho4y3fXjfa4F9lzGnx7CkMOtiaBbLouo4A=  ;
Received: from [82.235.205.153] by web25811.mail.ukl.yahoo.com via HTTP; Sun, 09 Jul 2006 09:48:08 GMT
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1152415640.2103.10.camel@dv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23537>


> Just for your information, this is already implemented by StGIT.  For
> instance, .git/patches/master/description contains the description of
> the "master" branch.

well I'm using plain git for now. And it doesn't seem to be a high level
 feature.
 
 Another point to this would be to show this set of patch and its summary
 threaded under a mailer. I use thunderbird, and it's possible to use threaded
 view which is very convinient. I don't know how it works, but see the set of
 patchs like:
 
 [PATCH 0/3] Summary of the set
                     |
                    + [PATCH 1/4] blababla
                     + [PATCH 2/4] another useful commit
                    + [PATCH 3/4] ...
 
 would be great !
 
 Francis
 
 PS: please CC me when answering.
