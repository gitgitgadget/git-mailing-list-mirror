From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 6 Dec 2011 18:20:00 +0700
Message-ID: <CACsJy8CZjrKpv53Ep8ietAHAeVW4bnYeXTa6x5FGncT1HXGWQg@mail.gmail.com>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 12:20:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXt4e-0004gv-MB
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 12:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab1LFLUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 06:20:33 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34246 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab1LFLUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 06:20:32 -0500
Received: by eaak14 with SMTP id k14so4974468eaa.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 03:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HplDEnGXdxcep/oqCxpTHxEonnyUvScQg11olEnI1BY=;
        b=PuIfRssEAQSbAK3YSrnNrwBnUArfgPTDDERl3iZU2UAByJ0PGwDv5Q/l9w6IqIRKuP
         i8nWv4HA2o/L3QE18eRQvhaQviPV9Dw8G3Fq8mUNJottHF9ekczWE/rFhOkJWT9O0/Ho
         vehdhqnSBTSlz9uGjGOobiKiPRdKWdCyuphsI=
Received: by 10.213.28.195 with SMTP id n3mr1502115ebc.122.1323170431273; Tue,
 06 Dec 2011 03:20:31 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 03:20:00 -0800 (PST)
In-Reply-To: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186342>

On Tue, Dec 6, 2011 at 12:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Here are the topics that have been cooking. =C2=A0Commits prefixed wi=
th '-' are
> only in 'pu' (proposed updates) while commits prefixed with '+' are i=
n
> 'next'.

What can I do to get "build in repack" [1] series in or moved forward?

[1] http://thread.gmane.org/gmane.comp.version-control.git/185190
--=20
Duy
