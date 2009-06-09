From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE]TortoiseGit 0.7.2.0
Date: Tue, 9 Jun 2009 23:11:18 +0800
Message-ID: <1976ea660906090811y50ceb669r844708134fe76a9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Jun 09 17:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME2z0-0007Si-Ie
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 17:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbZFIPLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 11:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbZFIPLQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 11:11:16 -0400
Received: from mail-px0-f200.google.com ([209.85.216.200]:49618 "EHLO
	mail-px0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZFIPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 11:11:16 -0400
Received: by pxi38 with SMTP id 38so40679pxi.33
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ESOosONB+G4f8IcuZlFIj/TdQfGcQV7xTEE//aN8EcM=;
        b=riKUD5ZERUQJbJYGnpmkid4MDRuPW3/77msLrQI14xRsm3ckWZVfzpq+fIS1urrmx/
         OcqJx7Erz4e6BlqwOxIrqTiRZaDKmkm2ZbcFCEj6ULWP2G8moTnbhOzFAUrgTP+zyIB9
         k3GLIiOzFeK+CtXaJuDh/5wuZsuxkjFx7mqGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=oHSct1orjjzCWwVG7+nyC3fKBzpHIWDF6OI5dzIEDKPrV87lQq/O+iPwXldhzqWcXF
         Ghr8M+HT3rQFHG/WTe27mkO7G2Afpd5tVmbU+GVCUtK3uvtLLo5aUpPpCYUBS8BMUr5n
         kIdmAXSVom9jVlW4R4cysAjymqQ0iVSw+Cfas=
Received: by 10.114.73.14 with SMTP id v14mr263050waa.229.1244560278679; Tue, 
	09 Jun 2009 08:11:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121176>

http://code.google.com/p/tortoisegit/downloads/list

version 0.7.1.0 (internal)
Features:
	*Add bug track plug-in support
	Compatible with TortoiseSVN. The typical plug in is gurtl(google code
issue plug-in).
	http://code.google.com/p/gurtle/.
	
	*Support browse reference.
	Show all branch, tags information. Support add remote, del branch\tag.

	*Show merged file at log dialog.
	
	*Update version graphic tree.
	Update graphic tree to qgit2.3
	
	*Add option -p for TortoisePLink.
	-p is the same as -P. So it is compatible with OpenSSH port option.

Fix:	*Fix Issue 91:  clone dialog generates bad directory name based
on URL, ignores overrid
	*Fix Issue 85:  Installer: warns of downgrade when running 0.6.2.0 on
top of 0.6.1.0
	*Fix i18n.logOutputEncoding doesn't work at log\commit dialog.
