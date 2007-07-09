From: free cycle <freecycler23@yahoo.com>
Subject: How to Import a bitkeeper repo into git
Date: Mon, 9 Jul 2007 09:57:09 -0700 (PDT)
Message-ID: <598689.78740.qm@web56015.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 18:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7wXy-0007cS-NH
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 18:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbXGIQ5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754284AbXGIQ5L
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 12:57:11 -0400
Received: from web56015.mail.re3.yahoo.com ([216.252.110.194]:33088 "HELO
	web56015.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754234AbXGIQ5K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 12:57:10 -0400
Received: (qmail 79746 invoked by uid 60001); 9 Jul 2007 16:57:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=I7QHYcR2yxFuRpLbO6GndEJ9RHwMWlNrmSLLZ7C9uFhfNJdxbUQ4s6R7gtwE9L7Nd9ugOXOqELXOkPOdG09PFMqwaAtEhqckseO+QnWNawuKGL4CINPenaa072DpA22hY7WUB7lOQXDq25NwqIuP890RDr38bH97Sf8YAOC9x58=;
X-YMail-OSG: 5xi10_EVM1lpSg5p6LoWFeErFeOLyCO09IAm8Y4MnMTvRPkKZO3vTNZfQeV0utJe93zxZExHO5WlOQ4J2dfaqKD9CKpVMAWjJsB3t.E.Eck5VhXheSo3iY1DEgozOAdUhsiE3dNO2L5gcA--
Received: from [134.134.136.5] by web56015.mail.re3.yahoo.com via HTTP; Mon, 09 Jul 2007 09:57:09 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52006>

Hi,

I'm looking for the best path to import a bk repo into git.


I was not able to find the download site for the tailor repo-conversion application.
Is it still supported and maintained?

I think bk can export to CVS and then git can import from CVS.
Is this the best way?

Thanks in advance,

Scott
