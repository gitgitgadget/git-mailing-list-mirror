From: "Arya, Manish Kumar" <m.arya@yahoo.com>
Subject: git clone ssh:// auth failiure
Date: Wed, 28 Jan 2009 00:28:30 -0800 (PST)
Message-ID: <197294.49807.qm@web35708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 09:29:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5o6-0004F7-1q
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbZA1I2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbZA1I2c
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:28:32 -0500
Received: from web35708.mail.mud.yahoo.com ([66.163.179.162]:47438 "HELO
	web35708.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752794AbZA1I2b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 03:28:31 -0500
Received: (qmail 51161 invoked by uid 60001); 28 Jan 2009 08:28:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=wUslgV2PAVjMH9pCWHX95zfAO+6DgLFIQ43ODwcN6bUpplt0Xdk115cwEkpFWKCI+dY3cuQCH2PhNVRWDjRwDm+bgMXMsQhuoeIeyDKZJth92VtDkjlhwxEE6lN7bFXe0/eq98p5Uab0KgJCLkdR8j4mfiHoqek9r1s/EtaeoUo=;
X-YMail-OSG: yhzedmQVM1n2QbBXFkAZ0_BfcaL2M451zT7DkaTjIVXqOHy5p2DL64pNwVqiPEFKmj9FRSxZr5su6WFvhXuCNJDt89Kj3O5hyoT7vcFMv6ilBxfQtINHV9O94AoYipuDqDHp3UUHd7AlaiWKv6X09MXWEg--
Received: from [221.134.157.65] by web35708.mail.mud.yahoo.com via HTTP; Wed, 28 Jan 2009 00:28:30 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107509>

Hi,

root@dcb0:~# git clone ssh://localhost/~/testproject manish
Initialized empty Git repository in /home/marya/manish/.git/
Password:
Password:
Password:
Permission denied (gssapi-keyex,gssapi-with-mic,publickey,keyboard-interactive).
fatal: The remote end hung up unexpectedly

though I am providing correct ssh password but its not working.

ne help guys ?

-Manish


      
