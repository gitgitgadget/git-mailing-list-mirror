From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: How change e-mail to use google's gmail instead of machine's prompt?
Date: Sat, 23 Feb 2008 23:44:24 +0100
Message-ID: <998d0e4a0802231444t1632ed97r102cefdfe4d3990d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 23:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT37B-0000ua-Dw
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYBWWo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbYBWWo0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:44:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:3473 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbYBWWoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:44:25 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1421055wra.23
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=olbW3G61Ctb4kT1SaviQYP4OnENBhgBVvIxIte1Qux0=;
        b=VcfuGUgOfW+ZPNNRoPZWGRUJeZMXBtLtWCqVNXWdP2HXlxbEEUzK1EoT9GT1aftFD28JFP5w1MTcMMmyHsiTo6MANqyTwcgeBwwZC+BWsEl8yFLseurz0OE25R8nec+WIGgHTh+jcNxddCggy9odo8+oDm/juTa4dcvn/8aoQ0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jBT1VC9rmnevnDTJDA97XjwDfCkUuVVt5JaTorIej9HTb4KSbGOt/xhg1QZb922pVkBdQ+1HSfhMVqmBCaAo3Bsjx1+OTdR5IFhoBHDtiqmwRF+IQTwAfUPFribx+/4rXEnECTi9UlWbCS4k8IfMcUheT0VDAGCVzfeBt2W4uqA=
Received: by 10.142.178.13 with SMTP id a13mr735771wff.129.1203806664172;
        Sat, 23 Feb 2008 14:44:24 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Sat, 23 Feb 2008 14:44:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74871>

Hello, my short prompt in the console of my machine is
+---------------------------+
| net1@pc0:~$               |
+---------------------------+
I did

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

but net1@pc0 of my machine is logged in the files .git/logs/HEAD,
.git/logs/refs/heads/master and .git/logs/refs/heads/remotes/origin/**some**

How can change it to use my own email jcpiza@gmail.com instead of my machine?

My machine has not static public IP (IPv4), it uses DHCP's dynamic IP and
unfortunately i can't receive directly e-mails through the mbox of my machine.

So, i have to use google's gmail instead of the mail of mbox of my machine.

 I loved the old Internet but i hate the new Internet services-based when
 Internet is controlled by companies and governments for that you can't do
 anything because it's controlled by them instead of by your.

   #;)
