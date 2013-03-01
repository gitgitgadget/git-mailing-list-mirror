From: =?iso-8859-2?Q?Jan_Pe=B9ta?= <jan.pesta@certicon.cz>
Subject: [PATCH]
Date: Fri, 1 Mar 2013 11:28:32 +0100
Message-ID: <004101ce1667$85bea730$913bf590$@certicon.cz>
References: <002b01ce1661$245ebb70$6d1c3250$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 01 11:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBND0-0004Ta-PH
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 11:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab3CAK2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Mar 2013 05:28:33 -0500
Received: from service.certicon.cz ([90.183.112.10]:2883 "EHLO
	service.certicon.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab3CAK2c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Mar 2013 05:28:32 -0500
Received: from miami (c-006.certicon.cz [90.183.112.6])
	(Authenticated sender: pesta)
	by service.certicon.cz (Postfix) with ESMTPSA id 73E26170809
	for <git@vger.kernel.org>; Fri,  1 Mar 2013 11:28:26 +0100 (CET)
In-Reply-To: <002b01ce1661$245ebb70$6d1c3250$@certicon.cz>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQF7K/VzIhzK1h9JLFDf8HqqdRpEgpk2dvig
Content-Language: cs
X-certicon-MailScanner-Information: Please contact our ICT for more information
X-MailScanner-ID: 73E26170809.A621A
X-certicon-MailScanner: Found to be clean
X-certicon-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 5.1, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-certicon-MailScanner-From: jan.pesta@certicon.cz
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217269>

Hi,

I found a problem when using GIT-SVN.

In inproperly merges in SVN causes that the ranges contains additional
character "*".=20

Attached patch fix this issue, I have it already tested for several mon=
ths.

Regards,
Jan


Kind regards / S pozdravem
=A0

Jan Pe=B9ta
SW Engineer Sr.

CertiCon a.s., www.certicon.cz
Vaclavska 12
12000 Prague 2
Czech Republic
=A0
Office Prague: +420 224 904 406
Mobile: +420 604 794 306
=A0
E-mail: jan.pesta@certicon.cz
