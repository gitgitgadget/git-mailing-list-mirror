From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Sun, 7 Sep 2008 14:56:24 +0530
Message-ID: <20080907092624.GA8470@toroid.org>
References: <48BBB59F.9080204@statsbiblioteket.dk> <vpqvdxggpw6.fsf@bauges.imag.fr> <20080901100435.GC6555@toroid.org> <48BBC20E.20808@statsbiblioteket.dk> <20080901104222.GA10026@toroid.org> <48BBCBEA.8000301@statsbiblioteket.dk> <7vskscplsz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 11:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcGYS-00011I-R6
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 11:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbYIGJ0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 05:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbYIGJ0a
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 05:26:30 -0400
Received: from fugue.toroid.org ([85.10.196.113]:49539 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbYIGJ03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 05:26:29 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 4524D558386;
	Sun,  7 Sep 2008 11:26:28 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 73BFD388402; Sun,  7 Sep 2008 14:56:24 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vskscplsz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95131>

At 2008-09-06 22:27:56 -0700, gitster@pobox.com wrote:
>
> Somebody involved in this thread care to report the current status
> please?

My patch is broken. I sent Tom an update, but he encountered an error
with that too. I'm trying to figure out what's wrong, and will post a
new patch to the list when I have it working.

-- ams
