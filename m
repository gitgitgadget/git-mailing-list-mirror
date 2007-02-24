From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: qgit4 and top of git tree
Date: Sat, 24 Feb 2007 21:33:27 +0530
Message-ID: <cc723f590702240803o24ca01ffxfea904bf7b11c05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 17:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKzN6-0006S3-1N
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 17:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbXBXQDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 11:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbXBXQDa
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 11:03:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:1145 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800AbXBXQD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 11:03:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1200832nfa
        for <git@vger.kernel.org>; Sat, 24 Feb 2007 08:03:28 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nqsKujx6RQ464yGbuvNDsGW3c6I5kZ0s/g2seN31r+jxjHAdS761117MLHW4ofkk6vM6J0YRb0yt5+aH6yBWr1gTt6LuTTJYRLQxWb9vvC8jf+fD6uiD+sr5P+0Jjus/o5yALIzYb/04WtKDR/PKtpXFU3CyXrrvB6zCzKZcr/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eIDzlB8NW5xeKfd5bwnMIQKoYvJFvTAAFyojZoy+mhTaHtKcs5Z95bsqwL8MM55fivz/w/arrEIMsoElNZjqKECFju2Gx+3IXXqAAf0UHdXYg02Tah31Yvb4gHivxcSy1q8/e91iuHXCs4NaXldB3jENiUm0eMH+wxs7rg+4YZU=
Received: by 10.48.210.16 with SMTP id i16mr8586115nfg.1172333007996;
        Sat, 24 Feb 2007 08:03:27 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Sat, 24 Feb 2007 08:03:27 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40519>

top of qgit4 and top of git. The top level commit is not displayed
properly.  I guess something related to commit parsing went wrong.


aneesh
