From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: problems with importing from cvs archive
Date: Sun, 2 Dec 2007 10:14:07 -0500
Message-ID: <C4B8CB94-3B39-4C14-9134-DE43684A3AB7@yahoo.ca>
References: <20071202064613.GB25351@venus>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 16:14:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyqWh-00086K-S1
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 16:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbXLBPOP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 10:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbXLBPOP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 10:14:15 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:27896 "HELO
	smtp102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753412AbXLBPOO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 10:14:14 -0500
Received: (qmail 40249 invoked from network); 2 Dec 2007 15:14:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=xI2WwW8KQLSBUC7TkQHjC7iTo3vpcJ4BiaDh5iLQJySWyVNjEo6tSWSzTgzc36Fi6UTn7GuO7TxKBj1Koc7FVehyc/N87tPtXwNFabotDdWaxMldUiaCgI6Xa1I0uUIthZfo+MRjnQS1wAOQv62QTA5vzNdgLoEI8SMwKGYGGh0=  ;
Received: from unknown (HELO ?10.0.1.3?) (jean_francois_veillette@66.130.96.245 with plain)
  by smtp102.mail.mud.yahoo.com with SMTP; 2 Dec 2007 15:14:12 -0000
X-YMail-OSG: 462lkd4VM1kCQr.N19VZ24hHhvhjTUgbaViSxVonfyaJgJPrClGFPeCzFSf0dpBDjxvlUyOD4Q--
In-Reply-To: <20071202064613.GB25351@venus>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66784>

Le 07-12-02 =E0 01:46, Ed S. Peschko a =E9crit :

> All,
>
> I'm trying to use git-cvsimport to import from a CVS archive, using:
>
> git-cvsimport -d $CVSROOT

I was able to go further just by adding the verbose mode ( -v ) :
git cvsimport -v -d ...

give it a try,

- jfv
