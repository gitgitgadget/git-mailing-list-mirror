From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Explicitly adding ignored files in subdirectories not working
Date: Sat, 27 Feb 2010 13:59:46 +0100
Message-ID: <fabb9a1e1002270459h55fbd1c0o509106e035402810@mail.gmail.com>
References: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com> 
	<20100224045958.GA2385@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 14:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlMHG-0007Dk-Ts
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 14:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968238Ab0B0NAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 08:00:08 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34054 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968214Ab0B0NAH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2010 08:00:07 -0500
Received: by pva4 with SMTP id 4so16640pva.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 05:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=C5faWKDThzMARLe1FXPjb5AxI+4g2AMJNDEK1kzfFmU=;
        b=RNSYzVObirxAe0NUMGGZp64pvGMJDMLmygJBXfl9klOg0ctPziC4rtrkdQRWz4L1xr
         vNwu965o4Il4iDKgA1Tkk+gGyy0UHdJ0XmEiDKHZ42Cr8t03Posc+r3zjHMMsyX8kzfb
         DVRJRaEgCKXtIx++ItliBP1Ch4tD9uJ2e/dIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SYyjK30E9r5pC3d/S6+eN8SGEfTG3Lc/2183FDKAFhisjdOFdrLlurwKr0x8jpkFoV
         1nIFVdHPGlrgFCIFffksr7OQfI6O9Ske58PQFzTwa4+UIOkVOHs9wXWxEUpOv4UPTNjh
         +UBHQuWQiLt+xrB841ZVE6ELlTtYZjD0iOd58=
Received: by 10.142.247.18 with SMTP id u18mr917610wfh.36.1267275606473; Sat, 
	27 Feb 2010 05:00:06 -0800 (PST)
In-Reply-To: <20100224045958.GA2385@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141203>

Heya,

On Wed, Feb 24, 2010 at 05:59, Jeff King <peff@peff.net> wrote:
> =A0http://thread.gmane.org/gmane.comp.version-control.git/140405

Peff, IIRC from that thread was left to die with you handing over to
Junio? Junio, do you intend to investigate what's going on there?

--=20
Cheers,

Sverre Rabbelier
