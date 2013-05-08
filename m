From: Robin Messer <robin.messer@altran.com>
Subject: RE: Minor correction to Git book
Date: Wed, 8 May 2013 12:01:00 +0100
Message-ID: <71E08C07CB3C444098033ABD69925159145BB1DE33@BATH-EXCMS.praxis.local>
References: <71E08C07CB3C444098033ABD69925159145BB1DDE1@BATH-EXCMS.praxis.local>
 <20130508105141.GH25912@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 08 13:01:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua27W-0008Pr-9n
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab3EHLBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:01:09 -0400
Received: from mail.altran-praxis.com ([80.194.246.105]:7752 "EHLO
	mail.altran-praxis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab3EHLBI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 May 2013 07:01:08 -0400
X-IronPort-AV: E=Sophos;i="4.87,632,1363132800"; 
   d="scan'208";a="197396"
X-DISCLAIMER: Added
Received: from unknown (HELO excas01.praxis.local) ([10.1.1.14])
  by mail.altran-praxis.com with ESMTP; 08 May 2013 12:01:02 +0100
Received: from Bath-EXCMS.praxis.local
 ([fe80:0000:0000:0000:18cc:cc9f:44.171.158.91]) by excas01.praxis.local
 ([10.1.1.14]) with mapi; Wed, 8 May 2013 12:01:01 +0100
Thread-Topic: Minor correction to Git book
Thread-Index: Ac5L2jCa7Qta2qZAQHS73uwHvj1tTAAABt0Q
In-Reply-To: <20130508105141.GH25912@serenity.lan>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223655>

> I think the text is correct as it stands.  "git status" shows you that
> there are changes that are staged and unstaged, "git diff" (and "git
> diff --cached") shows you what those changes are.

Thanks, but the command line which follows that text does actually use
"git status" to show which files (staged and unstaged) have changes.
The text I quoted is introducing that command.

Then the next example shows you how to use "git diff" to see what the
actual unstaged changes to those files are.

If this is not the appropriate place to report such things, please point
me at the correct one.

Thanks,

Robin.

This email is confidential and intended solely for the use of the individual to whom it is addressed. If you are not the intended recipient, be advised that you have received this email in error and that any use, disclosure, copying or distribution or any action taken or omitted to be taken in reliance on it is strictly prohibited. If you have received this email in error please contact the sender. Any views or opinions presented in this email are solely those of the author and do not necessarily represent those of Altran.

Although this email and any attachments are believed to be free of any virus or other defect, no responsibility is accepted by Altran or any of its associated companies for any loss or damage arising in any way from the receipt or use thereof.

Altran UK Ltd:

Company Number: 3302507, registered in England and Wales

Registered Address: 22 St. Lawrence Street, Bath, BA1 1AN

VAT Registered in Great Britain: 682635707
