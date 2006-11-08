X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 08 Nov 2006 00:26:49 -0800
Message-ID: <7vr6wetkc6.fsf@assigned-by-dhcp.cox.net>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<eis2m4$3i6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 8 Nov 2006 08:27:10 +0000 (UTC)
Cc: jnareb@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eis2m4$3i6$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	08 Nov 2006 08:58:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31129>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghim1-0001G9-RP for gcvg-git@gmane.org; Wed, 08 Nov
 2006 09:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754445AbWKHI0v convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006 03:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754446AbWKHI0v
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 03:26:51 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4484 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1754444AbWKHI0u
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006
 03:26:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061108082650.BQQ4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Wed, 8
 Nov 2006 03:26:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id k8SS1V00Z1kojtg0000000; Wed, 08 Nov 2006
 03:26:27 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> [master]
>>=20
>> =A0 Three topics that have been cooking in 'next' have been
>> =A0 merged, I've tagged the tip as v1.4.4-rc1.
>
> By the way, tag v1.4.4-rc1 has "GIT 1.4.4-rc1" as title, while the co=
mmit it
> points to, v1.4.4-rc1^{} has "GIT 1.4.3-rc1" as a title.

Yeah, sometimes I make typoes.  Not a news X-<.
