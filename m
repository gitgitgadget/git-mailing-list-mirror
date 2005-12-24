From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE] qgit-1.0rc2
Date: Sat, 24 Dec 2005 15:41:26 +0100
Message-ID: <43AD5E16.7040308@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: proski@gnu.org
X-From: git-owner@vger.kernel.org Sat Dec 24 15:41:56 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqAap-0002iY-MX
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 15:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVLXOlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 09:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVLXOlu
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 09:41:50 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:38492 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750737AbVLXOlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 09:41:49 -0500
Received: (qmail 35767 invoked from network); 24 Dec 2005 14:41:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=fHyCLAr2in2trOuZgY7r/puuPJFuCX2Vk9PrB0ykIMp+wiHE+PC5bdekguwRNKKwUsDX5H4CF0+uwc56JoC27TfC+xsXbJfVDanSGjGJjUPrKCx/Pev7lk7Fv+TJ4sKySZypOfE9smIBWaBeLhfAjDfyGUzlVM58tK0bVr1l+w0=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.56.71.126 with plain)
  by smtp105.mail.sc5.yahoo.com with SMTP; 24 Dec 2005 14:41:46 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14026>

There have been some important fixes this week that deserve a new and not 
foreseen release candidate.

Me and Pavel are still fighting against an obscure 
file_history_truncated_while_loading bug and I would like to fix before 1.0

Thanks to Pavel for providing patches and suggestions.


Merry Christmas Everybody
Marco



DOWNLOAD

TARBALL: http://prdownloads.sourceforge.net/qgit/qgit-1.0rc2.tar.bz2?download
GIT: http://digilander.libero.it/mcostalba/qgit.git
BINARY: http://digilander.libero.it/mcostalba/qgit

Links page: http://digilander.libero.it/mcostalba/



CHANGELOG

- fix tree browsing corner case

- allow overriding CCFLAGS [by Pavel Roskin]

- use git-am instead of git-applymbox to import patches

- enforce const return types when possible

- disable filter tree action while filtering

- fix missing resume after refresh in file history loading

- remove static variables from read functions

- added 'Check working dir' menu entry

- adjust widgets size with font

- patchesStillToFind not initialized [by Pavel Roskin]

- set 'View diff' and 'View file' as toggle actions

- enable compiler warnings [by Pavel Roskin]

- add range select dialog options

- fix drag and drop between StGIT patches


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
