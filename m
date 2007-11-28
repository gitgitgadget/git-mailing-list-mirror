From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/3] Add basic cvsimport tests
Date: Wed, 28 Nov 2007 23:20:32 +0100
Message-ID: <8563zm811r.fsf@lola.goethe.zz>
References: <20071128185504.GA11236@coredump.intra.peff.net>
	<20071128185546.GA11320@coredump.intra.peff.net>
	<7v8x4i3tn4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVGo-0004Ye-IN
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbXK1WUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbXK1WUR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:20:17 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:33924 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754717AbXK1WUP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 17:20:15 -0500
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id CA55C31E9C4;
	Wed, 28 Nov 2007 23:20:14 +0100 (CET)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id B6D91279447;
	Wed, 28 Nov 2007 23:20:14 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-037-196.pools.arcor-ip.net [84.61.37.196])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 9864435E6A7;
	Wed, 28 Nov 2007 23:20:14 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 788B41C4D3AA; Wed, 28 Nov 2007 23:20:31 +0100 (CET)
In-Reply-To: <7v8x4i3tn4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 28 Nov 2007 14:14:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4947/Wed Nov 28 21:05:00 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66441>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> +	cat <<EOF >o_fortuna &&
>> +O Fortuna
>> + ...
>
> Copyrights?

Benediktbeuern, thirteenth century.

>> +add "O Fortuna" lyrics
>> +
>> +These public domain lyrics make an excellent sample text.
>> +EOF

As long as nobody adds Orff's musical arrangements...

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
