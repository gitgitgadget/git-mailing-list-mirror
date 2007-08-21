From: "Josh England" <jjengla@sandia.gov>
Subject: empty directories
Date: Tue, 21 Aug 2007 11:14:21 -0600
Message-ID: <1187716461.5986.71.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 19:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXbd-0003Vb-QO
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbXHURd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755606AbXHURd0
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:33:26 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:3335 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbXHURdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:33:25 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2007 13:33:24 EDT
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 21 Aug 2007 11:13:35 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l7LHDYoJ012034 for
 <git@vger.kernel.org>; Tue, 21 Aug 2007 11:13:34 -0600
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.21.94722
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_300_399
 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070821172330; SEV=2.2.2; DFV=B2007082115;
 IFV=2.0.4,4.0-9; AIF=B2007082115; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230322E34364342314639322E303030453A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082115_5.02.0125_4.0-9
X-WSS-ID: 6AD5C2B44Q44528403-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56310>

Hi,

Git doesn't seem to allow me to add an empty directory to the index, or
even nested empty directories.  Is there any way to do this?  What is
the reasoning?  I've got a use case where having empty directories in my
git repository would be *very* valuable.  Any information and help is
greatly appreciated.

-JE
