From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: ANN: The official Git TeamCity plugin is now available
Date: Fri, 17 Apr 2009 21:10:30 +0400
Message-ID: <85647ef50904171010g3299af89s203dd56c77bbd258@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 19:12:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lurbi-000625-CS
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 19:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762151AbZDQRKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 13:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761500AbZDQRKf
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 13:10:35 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:35291 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762151AbZDQRKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 13:10:33 -0400
Received: by bwz7 with SMTP id 7so254100bwz.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=C24qq3/tPyHOmMy9dBi3+2jrT3MxvKZTO/pKh3z7Hig=;
        b=Zyq2JCyVCqyhraONQEelUhsaUyr4hliahI/ZJQpjUpZdZzG24iAIQeC/3ZT77HVIba
         r6I+PBUAaEpMMLxdW63eUsxaM/H+Im90+fH1VatCeoRQhtYMG+PD4HbKxisX9S6cQpwY
         3I5N3m/1bobHpaRoWNSXAQsIR+U+iX1gLlJG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YdXChQGcun8PFpm8quZGTYydZ9qflev8UBnqXUi8rQqHxeuDp508wibav7eok6uMT7
         VB6skP1SUBoSsyH2+LRHGFNEbuozuuBEgusMq8Y4CHp3+rOZsJ7+3PuzcuEV5wNE6AzF
         dZ/SQ8kGsKad6onth76t91wYzfqz0QrIglrQs=
Received: by 10.204.63.8 with SMTP id z8mr2508867bkh.55.1239988230534; Fri, 17 
	Apr 2009 10:10:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116760>

Hello!

I would like to announce that the beta version of the official Git
plugin for TeamCity (a build management and continuous integration
server from JetBrains) is now available. The plugin is released under
ASL 2.0 license and it is based on JGit library. The plugin home page
is http://www.jetbrains.net/confluence/display/TW/Git .

Regards,
Constantine
