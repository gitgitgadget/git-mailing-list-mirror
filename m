From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [RFC/PATCH] Add support for a pdf version of the user manual
Date: Wed, 10 Dec 2008 19:20:42 -0500
Message-ID: <ee2a733e0812101620s5fc2ff27p81826a5ff827e154@mail.gmail.com>
References: <1228949090-22475-1-git-send-email-vmiklos@frugalware.org>
	 <ee2a733e0812101606m1c522541j9380b6f5d5dc7fc8@mail.gmail.com>
	 <7vd4fzy3il.fsf@gitster.siamese.dyndns.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:22:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZJi-0000WX-97
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbYLKAUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbYLKAUq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:20:46 -0500
Received: from mail-bw0-f13.google.com ([209.85.218.13]:53156 "EHLO
	mail-bw0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbYLKAUp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:20:45 -0500
Received: by bwz6 with SMTP id 6so1700624bwz.13
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 16:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Iivgol2IW9wU1VfaWYkAF0AnBkRapWqohdZM7Reik34=;
        b=fi27qXzl9cVMHEsj4GkdcFpOkDDckEl+KApMLZzGpShG8xJ2clxOypTGiEUZGHTIkv
         6nMBxYxDbFhVtw9FO4o7GA91fk6eEGXuedqL5wMyEPeY40DdSgMpYCM4I7qrnbzoddYx
         khIuGkPOvN7kER3DzeS0P8ArKtowHaQdhsfW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=ZNsOmcmyY/tk8+/msLuYIuPAhNbQCxkVt6vDC8Sl3eIotp82cKJK0U1nGj2DIx7IRf
         OLxfU1g/TYSsrPzYplMzfdwxuF0/lhDOeG+waFZNK3d/1fPP43Hg50ewjC8sm/H9fcnp
         mCZURpReZDeD27QdMccfmUdNCgEFaV0Teum5g=
Received: by 10.181.206.7 with SMTP id i7mr646386bkq.126.1228954842959;
        Wed, 10 Dec 2008 16:20:42 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Wed, 10 Dec 2008 16:20:42 -0800 (PST)
In-Reply-To: <7vd4fzy3il.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102750>

On 12/10/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Leo Razoumov" <slonik.az@gmail.com> writes:
>
>  > BTW, for those of us without dblatex, is it possible to have pdf
>  > manual pregenerated the same way html and man pages are pregenerated
>  > for official releases in the git repo?
>
>
> Those of us includes myself, so...

Ouch:-) Does it mean that such a useful patch has a low probability of
being accepted?
