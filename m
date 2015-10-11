From: krist333 <krist.jin.apply@gmail.com>
Subject: Re: can't install on OS X
Date: Sun, 11 Oct 2015 09:43:09 -0700 (MST)
Message-ID: <1444581789465-7641041.post@n2.nabble.com>
References: <560E2936.6020101@prodsyse.com> <136388305.2086780.1443793308932.JavaMail.zimbra@genarts.com> <560ED59F.7040604@prodsyse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 18:43:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlJiN-00047P-C4
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 18:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbbJKQnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 12:43:10 -0400
Received: from mwork.nabble.com ([162.253.133.43]:49551 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbbJKQnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 12:43:09 -0400
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 258532AE4A57
	for <git@vger.kernel.org>; Sun, 11 Oct 2015 09:43:57 -0700 (PDT)
In-Reply-To: <560ED59F.7040604@prodsyse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279344>

Thanks for the summary. I have been googling this for a while until I found
this and it worked for me.

Just one note (possibly a minor typo): it should be *csrutil* disable/enable
not scrutil

reference: 
https://developer.apple.com/library/prerelease/mac/documentation/Security/Conceptual/System_Integrity_Protection_Guide/ConfiguringSystemIntegrityProtection/ConfiguringSystemIntegrityProtection.html
<https://developer.apple.com/library/prerelease/mac/documentation/Security/Conceptual/System_Integrity_Protection_Guide/ConfiguringSystemIntegrityProtection/ConfiguringSystemIntegrityProtection.html>  



--
View this message in context: http://git.661346.n2.nabble.com/can-t-install-on-OS-X-tp7640609p7641041.html
Sent from the git mailing list archive at Nabble.com.
