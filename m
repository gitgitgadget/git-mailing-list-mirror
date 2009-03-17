From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] git checkout: one bugfix and one cosmetic change
Date: Tue, 17 Mar 2009 04:43:52 -0400
Message-ID: <20090317084352.GL18475@coredump.intra.peff.net>
References: <cover.1237115791.git.barvik@broadpark.no> <e51f4f550903162156i64b64900g815ee8317720f1a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>
To: Kris Shannon <kris@shannon.id.au>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjUvW-0003KI-9f
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 09:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbZCQIoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 04:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbZCQIoB
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 04:44:01 -0400
Received: from peff.net ([208.65.91.99]:43759 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbZCQIoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 04:44:01 -0400
Received: (qmail 3069 invoked by uid 107); 17 Mar 2009 08:44:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 04:44:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 04:43:52 -0400
Content-Disposition: inline
In-Reply-To: <e51f4f550903162156i64b64900g815ee8317720f1a0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113443>

On Tue, Mar 17, 2009 at 03:56:12PM +1100, Kris Shannon wrote:

> I was rather surprised to see my name on that list.  A quick git log
> showed my one contribution to git-parse-remote way pack in
> August 2005.
> 
> I'd forgotten about that and was feeling all warm and fuzzy until I did:
> git log -- git-parse-remote
> 
> and saw that it was deleted a week later :(

Heh. The current list just counts commits, which is nice and fast. But
one could also "git blame" all of the content from master and credit
people based either on:

  - number of surviving lines in the current codebase (which obviously
    would give very rankings for people, as the number of lines added
    in a commit is not constant)

  - number of commits which have surviving lines

Doing such a calculation would be pretty slow, though, I imagine. And it
would of course remove you from the list. :)

-Peff
