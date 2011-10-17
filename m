From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] revert: Make commit descriptions in insn sheet optional
Date: Mon, 17 Oct 2011 15:36:24 +0530
Message-ID: <CALkWK0=+-4ZTg1hp6-e6k7SyA7jG39-RM31tqcq2K4u2Cf5pcg@mail.gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
 <1318095407-26429-5-git-send-email-artagnon@gmail.com> <7vwrccn34l.fsf@alter.siamese.dyndns.org>
 <7vwrc97wfe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 12:06:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFk5p-0008Nq-R1
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 12:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab1JQKGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 06:06:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61308 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab1JQKGp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 06:06:45 -0400
Received: by wwe6 with SMTP id 6so1940193wwe.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9/MJ4aNX0gXlfyGv3PA0UVZL23/VFqu7Gu2fbVF3nt4=;
        b=eAdvNmRFTOPf0S2nN6tQ61h3lN5sLTarmP+KPEAqHTLuCidwCjAHvZ4M3koTgg385A
         739YzKhee/PU29+CzrwaGsdHhMw7BhZjymkjk3hL2Xa1IOVg+6y/m6v2jdctRLjHxXWV
         +FnMPnc+TnuOZpmJKQ1yxc0NgRfxs7OGYdoHI=
Received: by 10.216.134.82 with SMTP id r60mr6213010wei.105.1318846004066;
 Mon, 17 Oct 2011 03:06:44 -0700 (PDT)
Received: by 10.216.51.75 with HTTP; Mon, 17 Oct 2011 03:06:24 -0700 (PDT)
In-Reply-To: <7vwrc97wfe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183788>

Hi Junio,

Junio C Hamano writes:
> Like this, perhaps. =C2=A0I did this on top of the whole series only =
as a
> demonstration but the change should be squashed into this step when t=
he
> series is rerolled.
>
> =C2=A0builtin/revert.c | =C2=A0 47 +++++++++++++++++++---------------=
-------------
> [...]

Thanks!  This is fantastic.  I'll re-roll soon with better commit messa=
ges :)

-- Ram
