From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: Recover a stash
Date: Wed, 24 Oct 2007 10:26:06 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27016E5841@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 19:27:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikk0R-0004F5-U8
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 19:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbXJXR0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 13:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbXJXR0N
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 13:26:13 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:54420 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbXJXR0M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2007 13:26:12 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9OHQ86a023419
	for <git@vger.kernel.org>; Wed, 24 Oct 2007 10:26:08 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9OHQ7J4027271
	for <git@vger.kernel.org>; Wed, 24 Oct 2007 12:26:07 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Recover a stash
Thread-Index: AcgWYvW6YWuEjPBnTVG2j33yfjd+HQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62222>

Hello,


Is there any way to recover a stash as a... stash? I accidently removed
a stash I still need and I'd like to recover it as a stash. I can see
the dangling commit objects in the database with git lost-found and I
can have a branch/head point at them, but it's not understood as stash
anymore.


Thank you,
Emil.
