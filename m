From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Sending patches via gmail
Date: Tue, 1 Apr 2008 10:49:34 +0100
Message-ID: <57518fd10804010249h4fe43bbfu64cf9576ca2edcf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 11:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgd8E-00086J-9D
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 11:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756184AbYDAJtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 05:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756013AbYDAJtf
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 05:49:35 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:32510 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbYDAJte (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 05:49:34 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1171247rvb.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=TsgZL4cRukveMi42g2hJzYk1bx06hmidyJ1NAJkfHNE=;
        b=E9HD0R+mgRr9fPKNmJwaGAhcVdWpIj6CVVQvayfhsQL9GJfH0GbRd3Kmgcl4rx+M9FkvnNTpgpFvzyH2qFXSMQEiH++N1XxqItXTDHnWZ57M6KskF0KO0OQFXrfnvn8EiK2kZy6ngWojkzKqdwYREZtm9koviLyK7aHmX0kFI88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=NtFlQsI0q9BYz/ma18l04/zehv08OReVPXTor12rZ9pMbl2zTGMMdpYaMC/mZb/wMn4GzdMv3ncP37Y0Aba6O4FeofuN2uGuVIQIP8XB1+hUNvvqt44uGVlVhy08Pl1VCIV6/2EBZf0/mu9j95ualU/xmSqgPhmW2T85ZY3yuS0=
Received: by 10.140.126.14 with SMTP id y14mr4137242rvc.59.1207043374260;
        Tue, 01 Apr 2008 02:49:34 -0700 (PDT)
Received: by 10.141.86.15 with HTTP; Tue, 1 Apr 2008 02:49:34 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: cca0f24747ea43d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78639>

I can't seem to send patches via gmail without it adding spurious line
breaks -  eg http://article.gmane.org/gmane.comp.version-control.git/78407.
 I thought this was supposed to be possible...  All I'm doing is
copying the contents of my patch, then in Gmail, clicking Compose
Mail, make sure it's in Plain Text rather than Rich Formatting mode,
paste my patch, and moving the mail header lines out of the message
body.

What am I missing?
Jonathan del Strother
