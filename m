From: Arnaud Lacurie <arnaud.lacurie@gmail.com>
Subject: End of year project : Gate Between Git and Mediawiki
Date: Thu, 19 May 2011 20:54:23 +0200
Message-ID: <BANLkTi=k=9-6_ZADug28J2u6tGC0+T-zzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, sylvain.boulme@imag.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN8N3-0004Aa-36
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933970Ab1ESSyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 14:54:45 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37796 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933819Ab1ESSyo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 14:54:44 -0400
Received: by vws1 with SMTP id 1so2160519vws.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=gNLiqJE44Uw+4sfWGpSjsd6e/iLWWy7cXWEFIFCjjk0=;
        b=FpWJfGpyC/8QL2Iza/NRhJLbR/BPnI8bYaN82IY2a1KKtIIGn9MLcD+DAzGIY92l5C
         I9RFLg1lUP6zEDEZ6wAjfy9Dw8OREkTyNdhYDyYV7iG0Vbf6lo8MQHCvin1gUjFitaiq
         JIvs4x/KKaBseEkU5SPkLppRKTbWvtyuMDAT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=m3JDO4sMaehHF4d4Bk5v9acAKvpksGpuhNnucqHd40mqfEn6kdpiCcItwodz8Rd+Qq
         fIS6RLoIJuqOx3rsGKpnUONDFny12/HsXJyNjMLXIsEIiPu+KsIgiX9NAmsC70FYpDWr
         IirzIr66I2JWlkyLWiLZVqw2WnLVtR4R2OQCI=
Received: by 10.220.102.20 with SMTP id e20mr1060448vco.80.1305831283277; Thu,
 19 May 2011 11:54:43 -0700 (PDT)
Received: by 10.220.193.194 with HTTP; Thu, 19 May 2011 11:54:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173991>

Hi,

We are 4 students from Ensimag, a French engineering school of
computer science=A0 and are planning to develop during four weeks a gat=
e
between Git and Mediawiki as our end of year project.
Our goal is to create something in the line of git svn, applied to
mediawiki powered wikis.
Matthieu Moy, active member of the community and our teacher, is
supervising the project along with Sylvain Boulm=E9 (in CC of this
mail), and sent you the idea a few months ago. In the process, Jeff
King sent a quick and dirty perl code which does the mediawiki
fetching part. We intend to improve it in order to facilitate
mediawiki -> git. We also plan to use remote-helpers and fast-import
to have the best compatibility overtime.
We will most likely contact you during the next weeks to report status
on this project and get suggestions on more specific points. In the
meantime, feel free to give any suggestion on such a project.

Thank you for your help,
Best regards,

David Amouyal, Claire Fousse, J=E9r=E9mie Nikaes & Arnaud Lacurie
