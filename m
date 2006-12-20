X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT - error: no such remote ref refs/heads/TestBranch
Date: Wed, 20 Dec 2006 15:36:51 -0800
Message-ID: <7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
	<7v64c7pmlw.fsf@assigned-by-dhcp.cox.net>
	<87wt4m2o99.wl%cworth@cworth.org>
	<7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net>
	<87vek62n1k.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 23:37:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87vek62n1k.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	20 Dec 2006 14:57:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34984>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxAza-0008UC-C0 for gcvg-git@gmane.org; Thu, 21 Dec
 2006 00:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964880AbWLTXg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 18:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWLTXgz
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 18:36:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45110 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964880AbWLTXgz (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 18:36:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220233652.ZYNP16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 18:36:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 1BcA1W00M1kojtg0000000; Wed, 20 Dec 2006
 18:36:11 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> Anyway, yes, the description of the new stuff there looks very
> interesting, and I'll maybe I'll start running from next a bit to see
> how this stuff all works.

Good.

Do you have comments on recent changes (both on 'master' and
some parts of 'next') from teachability point of view?  I think
you are "the guilty guy" who defined the theme for v1.5.0 to be
"usability and teachability" ;-).
