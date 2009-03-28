From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git svn clone failure
Date: Sat, 28 Mar 2009 13:59:33 +0100
Message-ID: <200903281359.34412.markus.heidelberg@web.de>
References: <A5DCF978-5D10-4A6C-BE4B-1024FA475E2F@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 14:02:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnYAa-0001OA-6q
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 14:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbZC1M7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 08:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbZC1M7j
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 08:59:39 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:48398 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZC1M7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 08:59:39 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id CF1C3F9AA297;
	Sat, 28 Mar 2009 13:59:36 +0100 (CET)
Received: from [89.59.72.204] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LnY8O-0001ou-00; Sat, 28 Mar 2009 13:59:36 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <A5DCF978-5D10-4A6C-BE4B-1024FA475E2F@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/HLQ8NqD5KJExT09g/51EyJzwWU04DDPxBZ7pM
	2dp+tlEeyTBaD3N9QVgrutK1M4XW+fIqGyyXtNcB7TbOJP1pgq
	JyYtJ34MYp42Dr17TLJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114953>

Lachlan Deck, 27.03.2009:
> Hi there,
> 
> I'm trying to clone an existing svn repository with git (just getting  
> started with git) and it keeps failing with:
> ...
> r604 = 6428e63734a21ee5fcb4593274747e2758578a91 (git-svn)
> fatal: unable to run 'git-svn'

Are you sure r604 isn't the latest svn revision?

I always get this error when doing "git svn fetch" with an http URL, it
doesn't occur with an svn URL. But everything seems to work fine,
though.

Markus
