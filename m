From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: clearcase migration to git
Date: Wed, 1 Dec 2010 20:23:24 -0500
Message-ID: <AANLkTimX3jovT=a2hvJvWR741t+C4x1B0WthSXcqb66t@mail.gmail.com>
References: <AANLkTintgZKHW+9aeqN=JPG34X6wqeCNOC0jpdFaWmrN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 02:23:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNxtT-0008AY-7V
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 02:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637Ab0LBBXZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 20:23:25 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41502 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab0LBBXY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 20:23:24 -0500
Received: by qwb7 with SMTP id 7so7765076qwb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 17:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RHLJ4xgPUUIDzdnHvq6pbkIOMmdjViu98MS0qQKJbJo=;
        b=l9ZyeTLDiCcoRvkaaWBr/FQp//zbtV5OfqkSO3t1JBeZNBVcE19mH0AQV5CtxU83Km
         CWyXW4WyBtT9SEANzgtYSTv97PSbU8MxtE2c3rf7+MUyIA5V/Yn3mM6Q89n8h1ZKYivm
         PokN/0ly7oj/V+AeyxkgUTkPE81u3FbQyF1J8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pVKGNcw5R+GmN+rce3qHE85Ut1g75CeElN0TuLScia9mUrsyMVi2IzF0C3DLvIaRHI
         czAQ6SQrG3V6M4tiA/kteqxM/qR2NhmioOUvUObS3pseTcGGNERW2EIBO3wa0bwEYM2k
         tvZ0GZEsceKSeIKeHxxZHfgAvhqEVNSODmz3A=
Received: by 10.224.137.38 with SMTP id u38mr8473127qat.151.1291253004112;
 Wed, 01 Dec 2010 17:23:24 -0800 (PST)
Received: by 10.224.182.10 with HTTP; Wed, 1 Dec 2010 17:23:24 -0800 (PST)
In-Reply-To: <AANLkTintgZKHW+9aeqN=JPG34X6wqeCNOC0jpdFaWmrN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162660>

On Wed, Dec 1, 2010 at 8:14 PM, Lynn Lin <lynn.xin.lin@gmail.com> wrote=
:
> All,
> =C2=A0 =C2=A0is there any tools recommended that migrate clearcase to=
 git?

Base or UCM?

/Martin
