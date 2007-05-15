From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: testing vger handling of charsets (part 1)
Date: Tue, 15 May 2007 15:05:59 -0700
Message-ID: <87646teo8o.fsf@morpheus.local>
References: <20070515test.1@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 00:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho59u-0006ZB-2G
	for gcvg-git@gmane.org; Wed, 16 May 2007 00:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbXEOWGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 18:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754996AbXEOWGM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 18:06:12 -0400
Received: from main.gmane.org ([80.91.229.2]:60774 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbXEOWGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 18:06:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ho59h-0003Ab-Cn
	for git@vger.kernel.org; Wed, 16 May 2007 00:06:05 +0200
Received: from iragan.virtutech.com ([67.111.107.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 May 2007 00:06:05 +0200
Received: from davidk by iragan.virtutech.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 May 2007 00:06:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: iragan.virtutech.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:OUwqB5rp+ikGfycccvel3b+xVYQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47380>

Jeff King <peff@peff.net> writes:

> This is a test message to check how vger reacts to seeing 8bit
> characters (like Hasselstr=C3=83=C2=B6m) in a message without the rig=
ht mime
> header. Previous attempts were eaten by the list because of a lack of=
 a
> message id.

This is broken when reading over NNTP from GMANE.

--=20
David K=C3=A5gedal
