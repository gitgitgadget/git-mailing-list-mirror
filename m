From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: RFC: New diff-delta.c implementation
Date: Tue, 25 Apr 2006 20:22:23 +0200
Message-ID: <444E68DF.1020105@lsrfire.ath.cx>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 25 20:23:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSBQ-0001fR-59
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWDYSWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 25 Apr 2006 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDYSWk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:22:40 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:29886
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932276AbWDYSWj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 14:22:39 -0400
Received: from [10.0.1.3] (p508E7520.dip.t-dialin.net [80.142.117.32])
	by neapel230.server4you.de (Postfix) with ESMTP id 0962B1C008;
	Tue, 25 Apr 2006 20:22:37 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
To: Geert Bosch <bosch@adacore.com>
In-Reply-To: <20060424025741.GA636@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19161>

Geert Bosch schrieb:
> On Sat, Apr 22, 2006 at 02:36:04PM +0200, Rene Scharfe wrote:
>> You can use "indent -npro -kr -i8 -ts8 -l80 -ss -ncs" to reformat yo=
ur
>> code into a similar style as used in the rest of git (settings taken
>> from Lindent which is shipped with the Linux source).
> Although I cringe at 8-space indenting, and find much of the GIT
> code close to unreadable for lack of design-level comments, I'll
> gladly reformat any code to conform to existing code standards.
> Please let me know if you've got documentation on that, as it would
> be helpful for me to know what the standard is. (No flame intended. :=
-)

I'm not aware of a document mandating a certain formatting.  The output
of that indent call should come close to a "standard format", because
Linus followed this style from the beginning and Junio didn't go astray=
=2E

Don't worry too much about it.  I just wanted to point out an easy way
to reformat your code to use sane indenting. :->

Ren=E9
