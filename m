From: Robin Messer <robin.messer@altran.com>
Subject: Minor correction to Git book
Date: Wed, 8 May 2013 11:24:56 +0100
Message-ID: <71E08C07CB3C444098033ABD69925159145BB1DDE1@BATH-EXCMS.praxis.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 12:35:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua1iW-0001ee-P6
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 12:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771Ab3EHKfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 06:35:19 -0400
Received: from mail2.altran-praxis.com ([80.194.246.106]:54733 "EHLO
	mail2.altran-praxis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab3EHKfR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 May 2013 06:35:17 -0400
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2013 06:35:17 EDT
X-IronPort-AV: E=Sophos;i="4.87,632,1363132800"; 
   d="scan'208";a="61568"
X-DISCLAIMER: Added
Received: from unknown (HELO excas01.praxis.local) ([10.1.1.14])
  by mail2.altran-praxis.com with ESMTP; 08 May 2013 11:25:02 +0100
Received: from Bath-EXCMS.praxis.local
 ([fe80:0000:0000:0000:18cc:cc9f:44.171.158.91]) by excas01.praxis.local
 ([10.1.1.14]) with mapi; Wed, 8 May 2013 11:25:01 +0100
Thread-Topic: Minor correction to Git book
Thread-Index: Ac5L1kmD3gWlQ/9TTmyyNiVMggLZfg==
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: BKiE BmCR DBMc DjDb Dw8n EhSx FC8O FQ8/ FqMd GVxE GsK9
 HKf7 Hh6s H0A+ IEPh
 Kxjr;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{503B7540-1B06-410B-BE17-3F9C1C6DC808};cgBvAGIAaQBuAC4AbQBlAHMAcwBlAHIAQABhAGwAdAByAGEAbgAuAGMAbwBtAA==;Wed,
 08 May 2013 10:24:57
 GMT;TQBpAG4AbwByACAAYwBvAHIAcgBlAGMAdABpAG8AbgAgAHQAbwAgAEcAaQB0ACAAYgBvAG8AawA=
x-cr-puzzleid: {503B7540-1B06-410B-BE17-3F9C1C6DC808}
acceptlanguage: en-US, en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223652>

I'm just learning Git so I don't yet know how to submit this
as a patch, but I'm reading the Git Book to get myself started
and I think there is a mistake on the page at:

http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository

It says: "For another example, if you stage the benchmarks.rb file and
then edit it, you can use git diff to see the changes in the file that
are staged and the changes that are unstaged:"

I believe this should say "git status" rather than "git diff".

--
Robin

This email is confidential and intended solely for the use of the individual to whom it is addressed. If you are not the intended recipient, be advised that you have received this email in error and that any use, disclosure, copying or distribution or any action taken or omitted to be taken in reliance on it is strictly prohibited. If you have received this email in error please contact the sender. Any views or opinions presented in this email are solely those of the author and do not necessarily represent those of Altran.

Although this email and any attachments are believed to be free of any virus or other defect, no responsibility is accepted by Altran or any of its associated companies for any loss or damage arising in any way from the receipt or use thereof.

Altran UK Ltd:

Company Number: 3302507, registered in England and Wales

Registered Address: 22 St. Lawrence Street, Bath, BA1 1AN

VAT Registered in Great Britain: 682635707
