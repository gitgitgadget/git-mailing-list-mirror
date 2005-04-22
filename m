From: Junio C Hamano <junkio@cox.net>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Fri, 22 Apr 2005 15:31:47 -0700
Message-ID: <7v4qdy5tpo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
	<7vis2fbr0p.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
	<7vzmvr72j6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504221147050.2344@ppc970.osdl.org>
	<7vbr867ecy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504221503270.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:27:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6cD-0000Y6-QU
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVDVWbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDVWbu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:31:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46312 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261245AbVDVWbt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 18:31:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050422223148.OLPV29099.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Apr 2005 18:31:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504221503270.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 22 Apr 2005 15:14:16 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Fri, 22 Apr 2005, Junio C Hamano wrote:
>> 
>> Almost, with a counter-example.  Please try this yourself:

LT> I agree that what git outputs is always "based on the archive base". But 
LT> that's an independent issue from "where is the working directory".

I am not talking about output, but the input.  I do not mind
(and I rather prefer) the output is always canonical.

