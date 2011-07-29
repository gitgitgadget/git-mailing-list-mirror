From: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
Subject: git-svn and comitter names
Date: Fri, 29 Jul 2011 10:16:43 -0500
Message-ID: <6517-1311952613-96947@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 17:23:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmouZ-0002xV-FK
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 17:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab1G2PXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 11:23:34 -0400
Received: from sneak2.sneakemail.com ([38.113.6.65]:35943 "HELO
	sneak2.sneakemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751153Ab1G2PXe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 11:23:34 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jul 2011 11:23:33 EDT
Received: (qmail 9489 invoked from network); 29 Jul 2011 15:16:53 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.0.1)
  by sneak2.sneakemail.com with SMTP; 29 Jul 2011 15:16:53 -0000
Received: from 207.58.245.194 by mail.sneakemail.com with SMTP;
 29 Jul 2011 15:16:53 -0000
Received: (sneakemail censored 6517-1311952613-96947 #1); 29 Jul 2011
 15:16:53 -0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.24)
 Gecko/20100228 Thunderbird/2.0.0.24 Mnenhy/0.7.5.666
X-Mailer: Perl5 Mail::Internet v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178154>

I just grabbed a repository using git-svn, and the commiter name shows =
a GUID for the=20
domain name.  For example,

     first.last <first.last@5ab5abacd-6ff9-f940-aeea-106a2a325327>

I set my git name and email address to show what I want in the end, the=
 real company email=20
address.  Will this apparent mapping be a problem when I dcommit?

=E2=80=94John
