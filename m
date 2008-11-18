From: Gary Yang <garyyang6@yahoo.com>
Subject: How to make public repository GIT_DIR=my-git.git git-init  Command not found.
Date: Tue, 18 Nov 2008 15:16:02 -0800 (PST)
Message-ID: <138223.4849.qm@web37905.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 00:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Zp2-0006D2-Dz
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 00:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbYKRXQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 18:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYKRXQG
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 18:16:06 -0500
Received: from web37905.mail.mud.yahoo.com ([209.191.91.167]:33116 "HELO
	web37905.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751737AbYKRXQF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 18:16:05 -0500
Received: (qmail 5320 invoked by uid 60001); 18 Nov 2008 23:16:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=bUx1tfElbp3FwC4nvapzKVY8u4c6jB/xiXOj88WrnQDfY1YS3gEgqGcu15TckdJ1eLvrv/J4gCcuci58jSlFkU2bJodkPPkiCRceSQm5QkN4n0KxaVO6PEd0Dx5APpMELiJJknmRsk1FEPWSJRR0yu4IhMhcb+JxFzWnJgH7w2U=;
X-YMail-OSG: APX1vg4VM1kFYjEvENBK3PxAQQppyo.uOZeheBfTilcqVFvdMf1N4L54QFLMFrtOgQPQCrKXu7B_DNGOBU8wTTHZp4NrvA91iM.q1Rybs6Y7si5OnYDo4uMInlLc.qlAYU6iyRa6T7lU9YE8PQFHgeh2jVTEnspsNNXi9_eJL1kDR9Wd1eo7Inrktrw6
Received: from [76.195.33.70] by web37905.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 15:16:02 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101292>

Hi,

I want to make a public repository. I followed the instructions in gitcore-tutorial. I typed "GIT_DIR=my-git.git git init" per instruction. But, I got command not found. I do not think this is the correct command. How should I do? I use C-Shell.

http://manpages.ubuntu.com/manpages/intrepid/man7/gitcore-tutorial.html

%mkdir my-git.git
%GIT_DIR=my-git.git git init

GIT_DIR=my-git.git: Command not found.


Thank you,


Gary





      
