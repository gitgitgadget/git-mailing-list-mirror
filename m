From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH V2] user-manual: add addition gitweb information
Date: Wed, 30 Dec 2015 17:23:42 -0700
Message-ID: <2699825.69Q9PnVUEi@thunderbird>
References: <xmqqoad7d1g0.fsf@gitster.mtv.corp.google.com> <1451517920-30703-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 01:23:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aER1t-0007wM-ST
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 01:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbbLaAXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 19:23:39 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:35212 "EHLO
	fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbbLaAXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 19:23:37 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151231002336.WLTD331.fed1rmfepo101.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Wed, 30 Dec 2015 19:23:36 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id 00Pb1s00C2tqoqC010Pbrg; Wed, 30 Dec 2015 19:23:35 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020204.56847587.0138,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=lNNhxV3-Mf8-bfdA4NgA:9 a=CjuIK1q_8ugA:10 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 946FF13F6B9;
	Wed, 30 Dec 2015 17:23:42 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.3.0-2-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283223>

On Wednesday, December 30, 2015 03:29:09 PM Junio C Hamano wrote:
 > "Stephen P. Smith" <ischis2@cox.net> writes:
 > 
 > >  The gitweb cgi script provides users an easy way to browse your
 > > -project's files and history without having to install Git; see the file
 > > -gitweb/INSTALL in the Git source tree for instructions on setting it up.
 > > +project's revisions, file contents and logs without having to install
 > > +Git. Features like RSS/Atom feeds and blame/annotation details may
 > 
 > Thanks.  Was there a reason to rewrite "files and history" into
 > "revisions, file contents and logs"?  The words "revisions" and
 > "logs" both refer to the same thing and "history" is a good word for
 > it already, so I am puzzled.  No strong objection, though...
 > 

[Re-worded my explanation.]
 
"revisions, file contents and logs was in the second sentence of the first patch.
"files and history" was in the first sentence of the first patch.

When I was getting rid of the duplication I decided that "revisions, file contents 
and logs" was a little more explicit and so decided to keep that wording.

As a secondary reason that is the wording in gitweb.txt.
