From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFH - git-log variant that _does_ search through diffs
Date: Tue, 30 Jun 2009 01:09:17 -0700
Message-ID: <7vd48m9m8i.fsf@alter.siamese.dyndns.org>
References: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com>
	<20090630040337.GA23741@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 10:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLYP9-0001rL-LS
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 10:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbZF3IJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 04:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbZF3IJR
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 04:09:17 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64289 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbZF3IJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 04:09:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630080917.SVNW17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jun 2009 04:09:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id A89J1c0034aMwMQ0389Jpl; Tue, 30 Jun 2009 04:09:18 -0400
X-VR-Score: -180.00
X-Authority-Analysis: v=1.0 c=1 a=6MulFls2jywA:10 a=PKzvZo6CAAAA:8
 a=TSbVqHtbAAAA:8 a=vqUTE8Z9d18KCMdHDs0A:9 a=j9dXP1GcA41LxOC6SND-mZKhhwAA:4
 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090630040337.GA23741@sigio.peff.net> (Jeff King's message of "Tue\, 30 Jun 2009 00\:03\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122498>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 29, 2009 at 05:08:47PM -0700, Eric Raible wrote:
>
>> [Surely this has been address before,  but I wasn't able to find it...]
>
> There is some discussion here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/112077
>
> Currently, yes. There is no way to do it internally. A patch to
> implement it would probably be accepted, though (see the thread I
> mentioned above for more details).

Specifically:

    http://thread.gmane.org/gmane.comp.version-control.git/112077/focus=112114

and its cousin

    http://article.gmane.org/gmane.comp.version-control.git/112141
