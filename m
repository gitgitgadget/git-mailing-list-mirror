From: "David Forman" <dforman@dairyfoodusa.com>
Subject: (unknown)
Date: Wed, 27 May 2009 08:28:29 -0500
Message-ID: <APEJLFBGDNOMCHGLHIHFEEKPDEAA.dforman@dairyfoodusa.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 27 15:51:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9JXx-0002q5-Ay
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 15:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbZE0Nvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 09:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbZE0Nvs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 09:51:48 -0400
Received: from spamtest.bright.net ([216.255.50.24]:38850 "EHLO
	spamtest.bright.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbZE0Nvr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 09:51:47 -0400
X-Greylist: delayed 1964 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 May 2009 09:51:47 EDT
Received: from rg7.cniteam.com (rg7.cniteam.com [209.143.0.247])
	by spamtest.bright.net (8.14.2/8.13.8) with ESMTP id n4RDIfqW020724
	for <git@vger.kernel.org>; Wed, 27 May 2009 09:19:03 -0400
Received: from LACTO (wan-1.broadband.sta.dairyfoodusa.com [216.180.195.131])
	by rg7.cniteam.com (MOS 4.1.5-GA)
	with SMTP id CNT27607
	for <git@vger.kernel.org>;
	Wed, 27 May 2009 09:19:02 -0400
Subject: 
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3350
X-Junkmail-Status: score=10/50, host=rg7.cniteam.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090204.4A1D3DC7.01B5:SCFSTAT4771472,ss=1,fgs=0,
	ip=216.180.195.131,
	so=2009-03-06 21:06:27,
	dmn=2009-05-12 18:33:47,
	mode=single engine
X-Junkmail-IWF: false
X-Spam-Score: 1.30 (*) [Hold at 9.50] MISSING_SUBJECT,SPF(none,0)
X-CanItPRO-Stream: Razorgate (inherits from default)
X-Scanned-By: CanIt (www . roaringpenguin . com) on 216.255.50.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120065>

I've encountered the following whenever I access Git and try to compress the
database due to loose objects.

error: cannot lock ref 'HEAD~'
error: cannot lock ref 'refs/heads/collections~'
error: cannot lock ref 'refs/heads/master~'

I'm on a Windows box (no comments please!), I've tried gc from the command
line, as well as the GUI option, with the same results. Any help would be
greatly appreciated, last count was over 2000 loose objects.

Thanks,

David Forman
Systems Manager
dairyfood USA, Inc.
