From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH] diff and apply: fix singular/plural grammar nit.
Date: Sun, 27 Nov 2011 16:41:17 +0100
Message-ID: <op.v5l263eh0aolir@keputer>
References: <4ED23EB5.1030208@ripton.net>
 <m37h2lmxk9.fsf@localhost.localdomain>
 <20111127145033.GA1738@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David Ripton" <dripton@ripton.net>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>,
	=?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Nov 27 16:41:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUgrG-0003ko-Ms
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 16:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1K0PlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 10:41:25 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63381 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602Ab1K0PlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2011 10:41:24 -0500
Received: by wwp14 with SMTP id 14so7254255wwp.1
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 07:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=zeSHMIA7+jyON2CvtFHDNiQT1bGi66nwtWJUEy33XkA=;
        b=Ek1WmK/Pq7h9Uk6uleueBkoHJoA/h8b91UmcHtRnwfF4Q+wYcJevmSmO+P1T09Oxrn
         Zua5MoUoIBr5weDoGlJEovlLeOgeN7MSGdmMCDtH52oc9N9wPhOQxdaoOu2+kAlZPcUy
         0dNhFueimvmPJMSF1lsuchSNaMCYYW6NlkCkY=
Received: by 10.216.162.21 with SMTP id x21mr554435wek.23.1322408482625;
        Sun, 27 Nov 2011 07:41:22 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id ca18sm13343197wib.13.2011.11.27.07.41.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Nov 2011 07:41:21 -0800 (PST)
In-Reply-To: <20111127145033.GA1738@centaur.lab.cmartin.tk>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185988>

On Sun, 27 Nov 2011 15:50:33 +0100, Carlos Mart=C3=ADn Nieto <cmn@elego=
=2Ede> =20
wrote:

> I think somebody already tried to do this not too long ago (don't kno=
w
> if there as a patch) but the diffstat tool always uses the plural, an=
d
> it might break scripts.

That would be http://thread.gmane.org/gmane.comp.version-control.git/17=
8316

=46rans
