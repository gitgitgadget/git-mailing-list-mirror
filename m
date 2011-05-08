From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 36/48] i18n: git-stash "unknown option" message
Date: Sun, 8 May 2011 23:38:55 +0200
Message-ID: <BANLkTimfcECUpjEntfbmHc9MOenNy1RPWA@mail.gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
	<1304857280-14773-37-git-send-email-avarab@gmail.com>
	<20110508152948.GB11604@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Motiejus_Jak=C5=A1tys?= <desired.mta@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 23:39:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJBgv-000764-Pm
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 23:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab1EHVi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 17:38:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59369 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab1EHVi4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 17:38:56 -0400
Received: by bwz15 with SMTP id 15so3559328bwz.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SLwizQmIbp5N2w0nwbL8dOJsECm4NEiBG0jha4m7YwE=;
        b=IHwqBZTfPgJW4sJr4FcyQWGysd5IKRZR8jDDnZJVreRBfWfcyhk5cf6ooGHIbGKBwi
         jsPv05rTOgF0iJ1XolIOtchRpk94ypmgw+Al+ZebzhhPbf65/piU3D97Os9UBLfhVGtv
         5Elp70b/6MX8+1Is8HsqHcs0xEERf48m39qfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EcLsYM+4c4pLZHYvW6Gjv19tu4E8VcxiwxhREddktr54ltV6KOZ9Fr4rg3TfgEK7Qf
         /s20QkgdYLIFGg2GUNbiTrr2TjiXTEVkSOpNxC8v5/w5Ppgq1Hq5S7P7jRV/Xxgm54tE
         2Uoe6kutjVSbwDX7WcP70H6NudDAIXhQK0Gx4=
Received: by 10.204.0.71 with SMTP id 7mr4440338bka.11.1304890735338; Sun, 08
 May 2011 14:38:55 -0700 (PDT)
Received: by 10.204.101.132 with HTTP; Sun, 8 May 2011 14:38:55 -0700 (PDT)
In-Reply-To: <20110508152948.GB11604@jakstys.lt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173185>

On Sun, May 8, 2011 at 17:29, Motiejus Jak=C5=A1tys <desired.mta@gmail.=
com> wrote:
> I think the commit message should be included to the message for the
> translators. Like this:

Good suggestion. Will do so in the next iteration.
