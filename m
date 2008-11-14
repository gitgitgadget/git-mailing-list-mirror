From: Gary Yang <garyyang6@yahoo.com>
Subject: "secret key not available". "unable to sign the tag".
Date: Fri, 14 Nov 2008 15:28:44 -0800 (PST)
Message-ID: <823128.71540.qm@web37902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 00:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1871-0005eA-Jv
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 00:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbYKNX2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbYKNX2r
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:28:47 -0500
Received: from web37902.mail.mud.yahoo.com ([209.191.91.164]:46401 "HELO
	web37902.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751522AbYKNX2p (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 18:28:45 -0500
Received: (qmail 71555 invoked by uid 60001); 14 Nov 2008 23:28:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=ugrnPIIC+5PGRqjfazEHeqOXHeBxUXI5WI5mMA+EmouyLplZqUFqt39MyOYqrUlSijs0zahlGNnzvAJT9Rz1hQqEaw9akiZteVnU8tqIz2HPrV3q4hsF8wjNaQ2BX+EsA6yno9DGOrBwST6NQGiWeQ2/8exgXpswTugS8wMEHR8=;
X-YMail-OSG: GNIKHDgVM1mbBGocAeYzLfKRDS0UBDgNcFqGag9PLDIqKK19EjjsZwsxrL8JId6uUlEvqCRRlAaCYn1qZKX64teGSRVwB8J4k2UBJgUqcl959lIoFJ_7kuEepnFA7BxzeDz12.vdTrgulsEj4NUWe_gkSo3gl7zGcIh9rxbAyyZYFu1dI9zY1bsf6PDu
Received: from [76.195.33.70] by web37902.mail.mud.yahoo.com via HTTP; Fri, 14 Nov 2008 15:28:44 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101033>

Hi,

I got errors and warnings when I used "git tag -s my-tag". It says, "secret key not available". "unable to sign the tag". 

gpg: please see http://www.gnupg.org/faq.html for more information
gpg: skipped `Gary Yang <gyang@linux123.(none)>': secret key not available
gpg: signing failed: secret key not available
error: gpg failed to sign the tag
fatal: unable to sign the tag

I ran "gpg --gen-key" and generated keypair. But, still got the same error. Please help.


Thank,

Gary


      
