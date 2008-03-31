From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: [PATCH] filter-branch: Fix renaming a directory in the tree-filter
Date: Mon, 31 Mar 2008 07:25:06 -0400
Message-ID: <6E006B1A-80DC-46DB-AA52-8A70C734C06E@yahoo.ca>
References: <C46D6D0D-44E1-4976-8956-1D84B6351535@yahoo.ca> <1206947655-20272-1-git-send-email-johannes.sixt@telecom.at> <1206947655-20272-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Mar 31 13:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgIGy-0002Qo-BQ
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 13:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbYCaLcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 07:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754918AbYCaLch
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 07:32:37 -0400
Received: from n1.bullet.mail.ac4.yahoo.com ([76.13.13.24]:23408 "HELO
	n1.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752901AbYCaLcb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2008 07:32:31 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Mar 2008 07:32:30 EDT
Received: from [76.13.13.26] by n1.bullet.mail.ac4.yahoo.com with NNFMP; 31 Mar 2008 11:25:36 -0000
Received: from [68.142.237.87] by t3.bullet.mail.ac4.yahoo.com with NNFMP; 31 Mar 2008 11:25:36 -0000
Received: from [66.196.97.134] by t3.bullet.re3.yahoo.com with NNFMP; 31 Mar 2008 11:25:36 -0000
Received: from [127.0.0.1] by omp107.mail.re3.yahoo.com with NNFMP; 31 Mar 2008 11:25:36 -0000
X-Yahoo-Newman-Id: 611843.12328.bm@omp107.mail.re3.yahoo.com
Received: (qmail 18866 invoked from network); 31 Mar 2008 11:25:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=XdRzVC9+WOE6KWPyPr+/9azQXHBFnC1faD9x2gEkkY/4yrr07hbX4oUjtd1AUZtjMlJX4BgQzg5btTji9+K97W2VFLbuP5cSJBZ9lmDkreZHIay3bU6e82u1Q+ZY8L5mshVWqhwJ9XoWNr3GGrsBc5Prc0SOtqH4erTDgXX54zE=  ;
Received: from unknown (HELO ?10.0.1.3?) (jean_francois_veillette@66.130.96.245 with plain)
  by smtp105.mail.mud.yahoo.com with SMTP; 31 Mar 2008 11:25:34 -0000
X-YMail-OSG: SyR2vTEVM1nkuSh4rEQQk5YnLjcYbrdfepLROhjZ781KfChE09HKsQrWKQtKYE9G.9CuxXyaxA--
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <1206947655-20272-2-git-send-email-johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78581>

> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  Jean-Francois, there's no sign-off from you. Ok to add it?

Yes, just take the credit for yourself, I didn't really know what I  
was doing.

- jfv
