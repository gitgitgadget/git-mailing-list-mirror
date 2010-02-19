From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 00/10] teach --progress to transport-related builtins
Date: Fri, 19 Feb 2010 14:31:31 +0800
Message-ID: <be6fef0d1002182231r5e300eadgcf2dbea4c2f14c3a@mail.gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
	 <7veikiyq1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sebastian Thiel <byronimo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 07:31:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMOo-0001h4-Bd
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 07:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab0BSGbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 01:31:33 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:59016 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab0BSGbc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 01:31:32 -0500
Received: by mail-iw0-f196.google.com with SMTP id 34so480343iwn.15
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 22:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XXe7q4/14gTifh8pZ2FeNMC64lZhGmP5JBdn0LD1Yg8=;
        b=GDpQY2YFlBBswDEhGsB/B19YWlmao3HmExT1AlV/AzV7bKFo4s8D66mLqPC3PvNwMH
         qSvqZPfngQMy8+OQmk/Qq9ngwtzFUpfyTZUahC2JBhWAf8UWN0OJhTqgRopJ/cr62KSO
         pOIlLWWEgz/3jtkesCT+F8F+azhahTjklpFUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hvw2dL9V2IMY17i+8s5oHBMw9oGP30f9NwsS2onX0OodxiYGsLkUwmlwn01BrwlmpD
         a7FrH8nqKQHR5z5tD7XvZited4Jj/pHcI/wtDdurZx7Teb8C4Gc5p7wpsXUmwS3dnJ40
         4hAAXSybaKxdNkF99g85sS0fDNShFTOvdB+Fo=
Received: by 10.231.152.75 with SMTP id f11mr5485991ibw.50.1266561091707; Thu, 
	18 Feb 2010 22:31:31 -0800 (PST)
In-Reply-To: <7veikiyq1h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140415>

Hi,

On Fri, Feb 19, 2010 at 9:26 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I gave a cursory look and they all looked sensible (except for 1/10
> on which I already commented separately). =A0Thanks.

ok. I'll sit on this series for a while for more comments to come in
before I send out the next iteration.

--=20
Cheers,
Ray Chuan
