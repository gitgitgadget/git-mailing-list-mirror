From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 18:10:10 +0100
Message-ID: <2A34D324-48A4-49EF-9D4E-5B9469A0791D@lrde.epita.fr>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwhTj-0007Ir-8E
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 18:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbXKZRKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 12:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbXKZRKU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 12:10:20 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:43391 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbXKZRKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 12:10:19 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IwhTN-0008SU-EC; Mon, 26 Nov 2007 18:10:17 +0100
In-Reply-To: <fiet88$68n$1@ger.gmane.org>
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66085>

On Nov 26, 2007, at 5:46 PM, Andy Parkins wrote:

>  - libgit would have come first

I warmly second that.

>  - "git revert" should be called "git invert"
>  - "git revert" would (maybe) be "git reset"

But here, I have to disagree.  Why would you want to call "git- 
revert" "git-reset"?

I know it's annoying that commands with the same name do different  
things in SVN/CVS but I don't think it's a reason to necessarily  
adapt to them.  There are plenty of misnomers already anyway  
(checkout, commit, add).

While we're discussing bad names, as someone already pointed out, I  
agree it's sad that "git push" is almost always understood as being  
the opposite of "git pull".

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
