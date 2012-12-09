From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 8/8] t9402: Use TABs for indentation
Date: Sun, 9 Dec 2012 06:19:48 -0500
Message-ID: <CAEBDL5XqU2gUbhVbu+HeuyPMEh-Tu91ZLJsqLC7am1u-JmYUZQ@mail.gmail.com>
References: <201212082235.54386.tboegi@web.de>
	<7v4njvef20.fsf@alter.siamese.dyndns.org>
	<50C4616D.9010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mmogilvi_git@miniinfo.net
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 09 12:20:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThevW-000103-SE
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 12:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645Ab2LILTu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2012 06:19:50 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41859 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094Ab2LILTt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Dec 2012 06:19:49 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so5859307iea.35
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SYnYtlvlxAH3vrNpxnIAKPu3952PVEaoNXAasHTBJnI=;
        b=KSzajaV4wX2aoKmU+/t972HrUbZKY0CIsnUFCUcmqlwDn0CaK73rJREajJLTgl6/2f
         PDjge5JBKH//1hxgjSkcAVw0lZY02oh2d1jxL3eEdTasbdR3Cak4Cgzuji3Dl3H+0L1k
         ajlJ1IfitRiRXGju3vGtlM5J0bmTcigZ1TQ5A/H9IOCSNDusZ8i668qP2cuNRvHCEbe7
         4V2Ex+k2lmhGhoCQbSuaKlz60s85CoO1JdNSU/YS2lJyNK9yAMQBBpPnTHfLRvD92pkv
         q6Lh9ALEY4+/i7lw7DSx5oP5Uy2zl/FNNpdKgjrUctUfh2u0HCkEhhs//xnHLEX5nU2G
         iX6g==
Received: by 10.50.37.168 with SMTP id z8mr3829888igj.1.1355051988782; Sun, 09
 Dec 2012 03:19:48 -0800 (PST)
Received: by 10.50.2.106 with HTTP; Sun, 9 Dec 2012 03:19:48 -0800 (PST)
In-Reply-To: <50C4616D.9010801@web.de>
X-Google-Sender-Auth: n_KW7NvMyH-HEgOLEfjvc4j19mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211236>

On Sun, Dec 9, 2012 at 5:01 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
[snip]
> PS: for some reason I don't get any mails to my
> (google) account any more, which I use to read the list.
> Am I the only one having this problem?

I noticed that the kernel.org lists are pretty unaccommodating.  If
something hiccups in the delivery, it'll drop (or disable?) sending
emails to you.  I've got some spam protection on my server that was
causing some issues occasionally when a lookup took to long.  I
wouldn't be surprised if a hiccup occurs now and then with gmail, and
the same thing happens.

-John
