From: Albretch Mueller <lbrtchx@gmail.com>
Subject: diff'ing files ...
Date: Mon, 6 Jun 2011 18:49:04 +0000
Message-ID: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 20:49:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTerQ-0006Ng-4m
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 20:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833Ab1FFStJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 14:49:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63897 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab1FFStG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 14:49:06 -0400
Received: by eyx24 with SMTP id 24so1462839eyx.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 11:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ofnR7ea29TB8nwKhWuTzIQxyyh1PJAGwALSYfYzLIA4=;
        b=xEiwPZLEH/cf8J8ZsX9eqAfukLQCH+4PsfbPp2LgaXvokFQDA9WE/F98Vnv7FXiIwP
         y7a4SBJCOBhrPhgSV9pUaBCF7q/7pIVYzXXaH5mcGSLuww1dybgU0ymc64nHUnEKULHW
         Y5ncukDAlRb0Wv918pQEIJsrRh6kFWlyaC8pM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=kzT/kbZnAILIyHgmPyszO8uV8BEW+6GIJRx7FZTmmAk1HI7hPssrzJisJirScwnSN4
         h2HpP2xUxD//ME/UUb/3hH+nuE7ii2g6gjh7PXFnnD3GuGG1sIJR25kzTEdrJ/J8f8mg
         wLrthHRrOuaswayI8vqA8YHG9pLLgpgBv5iEM=
Received: by 10.14.52.65 with SMTP id d41mr2175512eec.85.1307386144782; Mon,
 06 Jun 2011 11:49:04 -0700 (PDT)
Received: by 10.14.119.131 with HTTP; Mon, 6 Jun 2011 11:49:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175148>

 I research on collaborative editing/revision control utilities
(related mostly to NLP) and at the corpora list
~
 http://listserv.linguistlist.org/cgi-bin/wa?A1=ind1106&L=CORPORA#18
~
 ([Corpora-List] Managing texts and their edition history ...) they
told me they use git. However at:
~
 http://git-scm.com/documentation
~
 I could not find specific information on what diff'ing algorithm does
git use. Any white papers about git internals, mostly about its
diff'ing and synching algorithm? (and I am not scared at all of
"Directed Acyclic Graph" or any kind of Math terminology; in fact, I
love it ;-))
~
 Also, of the wave of git related or general books coming out, which
one actually explains the general concepts behind distributed version
Control? Again, my ultimate interest is not computer
programming/compiler-fed languages, but there is much that can be
learned from them
~
 Thank you
 lbrtchx
