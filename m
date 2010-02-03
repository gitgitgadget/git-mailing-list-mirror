From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk translation updates needed?
Date: Thu, 4 Feb 2010 08:46:52 +1100
Message-ID: <20100203214652.GE12487@brick.ozlabs.ibm.com>
References: <20100201151647.GB8916@spearce.org>
 <201002031113.11212.barra_cuda@katamail.com>
 <7vsk9ihzlp.fsf@alter.siamese.dyndns.org>
 <201002032156.16101.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 23:10:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcnQq-0008C5-Mn
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 23:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab0BCWKd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 17:10:33 -0500
Received: from ozlabs.org ([203.10.76.45]:33652 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603Ab0BCWKc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 17:10:32 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 550E9B7D37; Thu,  4 Feb 2010 09:10:31 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <201002032156.16101.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138907>

On Wed, Feb 03, 2010 at 09:56:15PM +0100, Michele Ballabio wrote:

> The "fuzzy" attribute is bogus but is understandable, because
> the msgid changed: "=A9" became "=A99". What I don't get is:
> why "=A9" became "=A99"? Was it a needed change or just an oversight?

It crept in without me noticing in commit d93f1713 ("gitk: Use themed
tk widgets").  I'll fix it.

Paul.
