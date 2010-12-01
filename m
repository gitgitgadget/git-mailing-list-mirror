From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Merging (only) subdirectories
Date: Wed, 1 Dec 2010 11:59:54 +0000
Message-ID: <AANLkTikviz82b_CL=cwfQgxWFXQbxEPOPpOHOGadbV3A@mail.gmail.com>
References: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
	<20101201114759.136280@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Martin_Kr=FCger?= <martin.krueger@gmx.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 13:00:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNlLs-00040g-Md
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 13:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0LAL74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 06:59:56 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50386 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0LAL7z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 06:59:55 -0500
Received: by gyb11 with SMTP id 11so3329955gyb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=W/zkXePphvvYfvvggRp4H7Pcngd2KvwTE8eWbgqu9dY=;
        b=i71OrkYehzw0YMFgsNS8N5llj6waXY+Y8rlpJ8fHX8HPMKkNeeGuttS4ZrAVpm8idj
         fz0XziwZS/YrURoiDpoefRsbZhZjI0AHxw3igGRPeHSA2Pa39ISXnqBYUTX/ujCRfQj7
         g0k44z2iRciwF1bP6/dPCvm7fgXdas/52AH/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=uuFn2sZQBPGo6TprnGPiMeS0NoSPKqvZ2FyDhMrUe44VIwWDa/bCOWUG20dBT0Hyyc
         LrmdXHdJQw2PmZRFy5SQLbjP2jOVvY7YyiWOx56bgoIxonQJCuz6ie01BfFSda1GeQoL
         aVlkRxzguqxHdjzK9apoAQ4QQy8urBLzxOJsI=
Received: by 10.100.134.1 with SMTP id h1mr6263464and.6.1291204794590; Wed, 01
 Dec 2010 03:59:54 -0800 (PST)
Received: by 10.100.38.15 with HTTP; Wed, 1 Dec 2010 03:59:54 -0800 (PST)
In-Reply-To: <20101201114759.136280@gmx.net>
X-Google-Sender-Auth: VP4nRj2IcjiwKQamnna4IaKLV0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162502>

2010/12/1 "Martin Kr=FCger" <martin.krueger@gmx.com>:
>

>>
> I would say you are not working best practice with git. The idea of c=
ommit is a atomic =A0change of the whole project. =A0It seems like you =
mixed completely unrelated changes in a commit.
>

> Best regards
> =A0 =A0 martin
>

Actually... thinking some more... that was actually my question (sorry
if I wasn't clear). We know that we are probably not doing this the
best way but we can't work out the right/better way. I'm looking for
help to organise our workflow with git better,

Thanks :)
