From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Showing whitespace on minus lines of diff ouput
Date: Thu, 4 Feb 2010 22:28:15 -0500
Message-ID: <76718491002041928q11630725gcdae4ff56f1a2b6e@mail.gmail.com>
References: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
	 <7veil0o02z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:03:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL2X-0003Bj-Nh
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902Ab0BED2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 22:28:17 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:57716 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab0BED2R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 22:28:17 -0500
Received: by iwn27 with SMTP id 27so506590iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 19:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PVw3FJWuNEbND8hUgE0nIgQ58balZuejhLPNIL9Y/5o=;
        b=Vz7VAqIruFCHLZIn2wClPr2D39rWeSzB5OB2k/oRPK6rSj9ua86AnUwDnDjW0XVfPm
         sta58zfYL+xDrcH5W+x7or4QAdXpVseu5TxbUU8eYghff7LHvKqtnsTDIVB4bsxGNyAP
         igFSRYLkduS1oE+0fOjGhZYnKAzGeZZ0Wp7go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=loxvM3P3dKh7h83y89ixqjmd7QNRWHi7asBKQKaSXIhq5IZpDpxIzXOQf4QsYlfYfT
         6YiJAeT42zEIXEQzObI2QRuQvbdioSfQWsEiedbT41OPrAoJBBGqbkFQqs0RaAwlMpun
         ek2+KzbJXQfi92GIHoWN0TLoPtP04E+yiolf8=
Received: by 10.231.168.133 with SMTP id u5mr1216119iby.29.1265340495650; Thu, 
	04 Feb 2010 19:28:15 -0800 (PST)
In-Reply-To: <7veil0o02z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139023>

On Thu, Feb 4, 2010 at 10:03 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Totally uninterested. =C2=A0"diff -R" would be enough, wouldn't it?

Duh, I hadn't thought of that.

j.
