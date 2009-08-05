From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 00/13] Native and foreign helpers
Date: Wed, 5 Aug 2009 11:11:00 +0200
Message-ID: <36ca99e90908050211j7e0f3030x6cacd866d948ac63@mail.gmail.com>
References: <alpine.LNX.2.00.0908050052390.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 11:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYcWa-00060A-S4
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933809AbZHEJLB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 05:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933794AbZHEJLB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:11:01 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:51630 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805AbZHEJLA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 05:11:00 -0400
Received: by fxm28 with SMTP id 28so3645033fxm.17
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e0tz6kFh/e5sSFebg9FIJaJ/hSh3EjrBLMaNsgm2Ibs=;
        b=Rb4dH3dALagYQhf9WKH2nvGTeEQtTWywQ7Ysu1XfhmRdogLor03EgL+Ttn3lRoMri0
         sfzCGYey9wo+0R0ZB8m2ujhhJuMezkIauPxDvvVwI2acSU2SA9l9aYIGQG9HX7caPA/b
         IbPQu3PU5/WpTE0+jcpzEgt6QCOSN/nxiOTWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XZuGFkrNtKa5cA5KLv3IkLdn9OCqtqXei3uc5F7jwdMYY/AmhAgkmUklJs8LEvhZnk
         i/u9UMUEDn2mQJ3mBGWouwP4ztIjcdepmPTPjHH2YUxG1cuKVYW7SVKPY1bZMtNXUNbW
         LbM53/fJ1UgDLf17i+moEA1VsX+GyxJbAgIMo=
Received: by 10.223.126.66 with SMTP id b2mr3351769fas.67.1249463460335; Wed, 
	05 Aug 2009 02:11:00 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0908050052390.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124877>

On Wed, Aug 5, 2009 at 07:01, Daniel Barkalow<barkalow@iabervon.org> wr=
ote:
> Johan Herland (3):
> =C2=A0First draft of CVS importer using the foreign-scm machinery
This patch got never to the mailing list, probably because of size rest=
rictions.

Bert
