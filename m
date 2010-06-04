From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Resurrecting : git-gui: use textconv filter
Date: Sat, 05 Jun 2010 00:21:35 +0200
Organization: Ensimag
Message-ID: <32937075d59e3275bb0762764a101607@ensimag.fr>
Reply-To: clement.poulain@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 05 00:22:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKfHK-00021y-FM
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 00:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088Ab0FDWVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 18:21:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54487 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177Ab0FDWVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 18:21:43 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o54ME5VO027055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 Jun 2010 00:14:05 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o54MLa82014919;
	Sat, 5 Jun 2010 00:21:36 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o54MLZLO028290;
	Sat, 5 Jun 2010 00:21:36 +0200
X-Sender: clement.poulain@ensimag.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 05 Jun 2010 00:14:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o54ME5VO027055
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148441>

Hi,

After proposing a patch adding textconv support to "git blame"
(http://thread.gmane.org/gmane.comp.version-control.git/148310), we are=
 now
looking to have git-gui use it. Clemens Buchacher (Cc-ed) sent us a pat=
ch
he made a while ago:
http://thread.gmane.org/gmane.comp.version-control.git/145015.
There's no answer to the thread, and as a part of our work is based on =
it,
we would like it to be submitted to you again.

Thank you,
Cl=C3=A9ment
