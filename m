From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.82 (was Re: qgit-0.81)
Date: Sun, 7 Aug 2005 08:05:41 -0700 (PDT)
Message-ID: <20050807150542.2009.qmail@web26310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 17:06:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1mis-0000TN-Hr
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 17:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbVHGPFr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbVHGPFr
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 11:05:47 -0400
Received: from web26310.mail.ukl.yahoo.com ([217.146.176.21]:11900 "HELO
	web26310.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1752129AbVHGPFr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 11:05:47 -0400
Received: (qmail 2011 invoked by uid 60001); 7 Aug 2005 15:05:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qWVGTlzJvWm+F1zxKHBrZ+h5wrbfjwutQefvTUX3kc7JwcpZyOSX4zeGRMhknKg9Eu+8mj1g0FKy2pp/3R0umRiTl5lFI85ctJr5Jwf80wBm5xNrJ8ul7ouFHXpv9Mn25Xb3R1hTuu5UxFUtUVDHIGWOdNUdaG2ZOXGzUz8forY=  ;
Received: from [151.38.109.179] by web26310.mail.ukl.yahoo.com via HTTP; Sun, 07 Aug 2005 08:05:41 PDT
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba wrote:

>Linus Torvalds wrote:
>
>
>>- Any chance of having a git archive of qgit? I realize that sourceforge 
>>  doesn't have git archives, but (a) maybe you can ask and (b) maybe 
>>  there are alternate places you could put it. It's just sad having to 
>>  download tar-balls.
>>
>
>I will try to proceed from (a) to, eventually, (b).
>
>

Apart from using a public git archive, (I already use my private one ;-)) 
the other points should be fixed now by a fresh qgit-0.82

Download link (still tarball for now) is:
http://prdownloads.sourceforge.net/qgit/qgit-0.82.tar.bz2?download


Changelog:

- replaced jump-over-bumps with horizontal lines

- set graph bullets a bit smaller  

- no more word wrapping in diff and file viewers

- fixed display of e-mail addresses in commit messages



Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
