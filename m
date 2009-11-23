From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 1/2] Do curl option disabling before enabling new options
Date: Mon, 23 Nov 2009 11:05:02 +0800
Message-ID: <be6fef0d0911221905o2e4eae93l1915c16dacfce7a9@mail.gmail.com>
References: <Pine.LNX.4.64.0904142200130.7479@localhost.localdomain>
	 <20091123110328.748fcf09.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 07:15:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCSDO-0007re-AF
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 07:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbZKWGMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 01:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbZKWGMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 01:12:09 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:41914 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbZKWGMI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 01:12:08 -0500
X-Greylist: delayed 692 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2009 01:12:08 EST
Received: by iwn1 with SMTP id 1so416271iwn.33
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 22:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IfgIflCraG5hw77bCyCSfMFc5srn3ApEn11N0JAL4bI=;
        b=NVpAQR/9FodADdrkx4SdFhNoR28G1TkDnQRR3sA5FNwOQ+6aA/FGLML5BH2PZzFnLR
         6/7+xTbPkH3WTfRdmQUFxJKP436/yWdIB0xRFx2YEgnUmvNRukQJ+YsozLtUv15Dz8do
         yOpnQZQSNCbzLiSE2HMvkpfDrwshyJZg4Rhbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xzzravvzUGkCed1jzhScsVx5LF4mmQSA79yzg5Id/fNIz9oX7bkCzNWmxFUSWyQbBU
         /zwIcnVGx1xmyyOeOtbGTlXLXVp7TSO+aJVm1ggn38M8JbtxHLH0SOZNA3H1B5I4uQwh
         uIXGfdqzPM/vt6PE4+KijPy3JIg7dAOU7stn8=
Received: by 10.231.125.100 with SMTP id x36mr2339833ibr.52.1258945502541; 
	Sun, 22 Nov 2009 19:05:02 -0800 (PST)
In-Reply-To: <20091123110328.748fcf09.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133483>

Hi,

On Mon, Nov 23, 2009 at 11:03 AM, Tay Ray Chuan <rctay89@gmail.com> wro=
te:
> =A0Squashed in another potential trigger for this bug in remote-curl.=
c,
> =A0introduced in 'next'.

sorry, this should now read 'master'.

--=20
Cheers,
Ray Chuan
