From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] Make it clear that push can take multiple refspecs
Date: Wed, 30 Jul 2008 02:58:08 +0530
Message-ID: <20080729212808.GA27076@toroid.org>
References: <1217362159-25440-1-git-send-email-ams@toroid.org> <7vbq0gcsxg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNwkr-0008Mu-Pl
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 23:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbYG2V2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 17:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYG2V2L
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 17:28:11 -0400
Received: from fugue.toroid.org ([85.10.196.113]:36693 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbYG2V2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 17:28:10 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 399F955831A;
	Tue, 29 Jul 2008 23:28:09 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 4BBCAADC369; Wed, 30 Jul 2008 02:58:08 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vbq0gcsxg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90688>

At 2008-07-29 13:54:35 -0700, gitster@pobox.com wrote:
>
> Doesn't this already say you can have zero or more refspecs?

It does, of course, but I've seen more than one question about how to do
it now, even from people who looked at the manpage, and it seemed to me
that adding an example wouldn't hurt.

-- ams
