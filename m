From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 4/9] gitk i18n: Initial German translation.
Date: Wed, 12 Dec 2007 09:23:51 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200712120923.52049.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <200711071844.03106.stimming@tuhh.de> <18271.7084.431598.815386@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 11:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2OrR-0004jh-LV
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 11:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbXLLKaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 05:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbXLLKaT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 05:30:19 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:55991 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbXLLKaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 05:30:18 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lBCATsAH028179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 12 Dec 2007 11:29:54 +0100
Received: from [192.168.2.102] (p549010AF.dip0.t-ipconnect.de [84.144.16.175])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lBCATrJZ008634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Dec 2007 11:29:54 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <18271.7084.431598.815386@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68032>

Am Mittwoch, 12. Dezember 2007 00:22 schrieb Paul Mackerras:
> Christian Stimming writes:
> > ---
> > In order to test the i18n code, I prepared half-completed
> > German translation.
> >
> >  po/de.po |  703
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 files
> > changed, 703 insertions(+), 0 deletions(-)
> >  create mode 100644 po/de.po
> >
> > diff --git a/po/de.po b/po/de.po
> > new file mode 100644
> > index 0000000..8c41069
> > --- /dev/null
> > +++ b/po/de.po
> > @@ -0,0 +1,703 @@
> > +# Translation of git-gui to German.
> > +# Copyright (C) 2007 Shawn Pearce, et al.
>
> Ummm?  I think you forgot to change some things here. :)

I'll change those when I update the German translation.  I'd ask you to commit 
this one anyway so that there is at least one translation to play with. 

Christian
