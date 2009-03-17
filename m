From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/2] git checkout: one bugfix and one cosmetic change
Date: Tue, 17 Mar 2009 14:39:25 +0100
Message-ID: <49BFA80D.6040504@drmicha.warpmail.net>
References: <cover.1237115791.git.barvik@broadpark.no> <e51f4f550903162156i64b64900g815ee8317720f1a0@mail.gmail.com> <20090317084352.GL18475@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kris Shannon <kris@shannon.id.au>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 14:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjZXb-0006eW-Bp
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 14:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbZCQNjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 09:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbZCQNjm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 09:39:42 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59710 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751703AbZCQNjm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 09:39:42 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 62C5C2F35EE;
	Tue, 17 Mar 2009 09:39:39 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 17 Mar 2009 09:39:39 -0400
X-Sasl-enc: 1iN4fNY8M8gI71K0kAsdsWgrzcbnpsgiwGph6o2gv9Hh 1237297178
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6EF73539B8;
	Tue, 17 Mar 2009 09:39:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090317 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090317084352.GL18475@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113470>

Jeff King venit, vidit, dixit 17.03.2009 09:43:
> On Tue, Mar 17, 2009 at 03:56:12PM +1100, Kris Shannon wrote:
> 
>> I was rather surprised to see my name on that list.  A quick git log
>> showed my one contribution to git-parse-remote way pack in
>> August 2005.
>>
>> I'd forgotten about that and was feeling all warm and fuzzy until I did:
>> git log -- git-parse-remote
>>
>> and saw that it was deleted a week later :(
> 
> Heh. The current list just counts commits, which is nice and fast. But
> one could also "git blame" all of the content from master and credit
> people based either on:
> 
>   - number of surviving lines in the current codebase (which obviously
>     would give very rankings for people, as the number of lines added
>     in a commit is not constant)
> 
>   - number of commits which have surviving lines
> 
> Doing such a calculation would be pretty slow, though, I imagine. And it
> would of course remove you from the list. :)
> 
> -Peff

Maybe we can forge a statement by Canonical, claiming they were among
the top contributors to git? Then GKH would do all the statistics for us ;)

Michael
