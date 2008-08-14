From: Mark Struberg <struberg@yahoo.de>
Subject: does anything like cvs export exist in git?
Date: Thu, 14 Aug 2008 21:20:10 +0000 (GMT)
Message-ID: <977100.98240.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 23:21:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkFx-0006ja-7R
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 23:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbYHNVUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 17:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbYHNVUO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 17:20:14 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:24842 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752845AbYHNVUN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 17:20:13 -0400
Received: (qmail 99107 invoked by uid 60001); 14 Aug 2008 21:20:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ixxRIIrloZXz/b8VagnV6uUuvZJsBj6V0YQ7/SLuTp9FctgGvJjTsV0axC7qoYyV4rRlVPF/1XSl/VDNk4mwWrTAMmuTIPCZ79wsA0kQ53t7DPY8FepFuIhz6PXDTCM/z7OwaWlz2FHFcwUcZ2DlfB/LL1KD36+CJRHaxHPCr0E=;
Received: from [213.162.66.179] by web27803.mail.ukl.yahoo.com via HTTP; Thu, 14 Aug 2008 21:20:10 GMT
X-Mailer: YahooMailWebService/0.7.218
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92402>

Hi!

I'm the initial author of the Apache maven-scm-providers-git and I need=
 to update our SCM-Matrix.=20

This is just for making sure I did not oversee anything.

I didn't came across anything like 'cvs export' and I do not think git =
really needs this, since it doesn't pollute the working directories wit=
h lots of waste like CVS and SVN does.=20
But I just want to make sure to not build workarounds in our scm-provid=
er (checkout + afterwards blasting the GIT_DIR) for things that do exis=
t natively in git.

txs in advance and
LieGr=FC,
strub

__________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden S=
chutz gegen Massenmails.=20
http://mail.yahoo.com=20
