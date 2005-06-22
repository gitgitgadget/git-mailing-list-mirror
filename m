From: Junio C Hamano <junkio@cox.net>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 01:47:18 -0700
Message-ID: <7vd5qeixrd.fsf@assigned-by-dhcp.cox.net>
References: <1119308502.3926.18.camel@localhost.localdomain>
	<Pine.LNX.4.21.0506211337400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 10:55:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dl10w-0001dx-5P
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 10:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVFVJAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 05:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVFVI5K
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 04:57:10 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49660 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262914AbVFVIr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 04:47:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050622084718.NFEG550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Jun 2005 04:47:18 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506211337400.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Tue, 21 Jun 2005 14:02:05 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> On Mon, 20 Jun 2005, Darrin Thompson wrote:
>> On Mon, 2005-06-20 at 10:22 -0700, Junio C Hamano wrote:
>> >  (6) Throw away my HEAD, making Linus HEAD my HEAD, while
>> >      preserving changes I have made since I forked from him.  I
>> >      use "jit-rewind" for this.
>> 
>> When you say it that way it sounds so _bad_. :-)

DB> The reason is actually that he has to end up with a different history,

Exactly.  I _want_ to, not just _have_ to, end up with a
different history.

