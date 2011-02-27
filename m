From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 18:21:40 +0900
Message-ID: <87bp1xest7.fsf@catnip.gol.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
	<AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	<20110227084317.GB3356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 27 10:22:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtcpK-0000si-QB
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 10:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891Ab1B0JWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 04:22:02 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:46146 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab1B0JV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 04:21:58 -0500
Received: from 218.231.234.87.eo.eaccess.ne.jp ([218.231.234.87] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1Ptcov-0007j6-Sa; Sun, 27 Feb 2011 18:21:41 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 0C102DFA0; Sun, 27 Feb 2011 18:21:41 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20110227084317.GB3356@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 27 Feb 2011 03:43:17 -0500")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168017>

Jeff King <peff@peff.net> writes:
> So the term "staging area" makes perfect sense to me; it is where we
> collect changes to make a commit. I am willing to accept that does not
> to others (native English speakers or no), and that we may need to come
> up with a better term. But I think just calling it "the stage" is even
> worse; it loses the concept that it is a place for collecting and
> organizing.

Agreed.

"Staging area" is a good noun (phrase) for this.  "Stage" is a good verb
(for "move into the staging area"), but isn't intuitive as a noun.

-miles

-- 
In New York, most people don't have cars, so if you want to kill a person, you
have to take the subway to their house.  And sometimes on the way, the train
is delayed and you get impatient, so you have to kill someone on the subway.
  [George Carlin]
