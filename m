From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Re: [TRIVIAL] Documentation: merge: one <remote> is
 required
Date: Wed, 12 Aug 2009 22:47:40 +0200
Message-ID: <1250110060.2500.8.camel@x61.thuisdomein>
References: <1249995838.1589.3.camel@localhost.localdomain>
	 <20090811144253.GA12956@vidovic>
	 <1250002681.2707.2.camel@localhost.localdomain>
	 <7vy6ppbvdf.fsf@alter.siamese.dyndns.org>
	 <1250074578.7545.2.camel@localhost.localdomain>
	 <7vhbwcydtn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKjj-00084o-N5
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbZHLUrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbZHLUrp
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:47:45 -0400
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:41292 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028AbZHLUrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:47:45 -0400
Received: from [212.123.169.34] (helo=[192.168.1.104])
	by smtp-out3.tiscali.nl with esmtp (Exim)
	(envelope-from <pebolle@tiscali.nl>)
	id 1MbKjZ-0002If-Py; Wed, 12 Aug 2009 22:47:45 +0200
In-Reply-To: <7vhbwcydtn.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125745>

On Wed, 2009-08-12 at 13:31 -0700, Junio C Hamano wrote:
> Paul Bolle <pebolle@tiscali.nl> writes:
> I do not have any objection to make sure that we uniformly use ellipses
> for one-or-more (and enclose them in [] if we want zero-or-more).  Are
> these two that your patch touched the only ones that need fixing?

I guess not (these two were the ones that annoyed me enough to write
patches when I read them in order to learn more about the commands they
described).

What is the best way to fix small issues like this: one set of patches
that tries to fix as much as possible in one go or a stream of little
patches whenever similar issues are found in one of the documents?
