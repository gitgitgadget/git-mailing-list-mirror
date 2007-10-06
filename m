From: "Lars Hjemli" <hjemli@gmail.com>
Subject: A message from the human patch-queue
Date: Sat, 6 Oct 2007 19:18:34 +0200
Message-ID: <8c5c35580710061018m43f8ceaag9341ee95d39500f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 19:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeDIb-0005xc-2J
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 19:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbXJFRSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 13:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757190AbXJFRSg
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 13:18:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:33677 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbXJFRSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 13:18:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1028142wah
        for <git@vger.kernel.org>; Sat, 06 Oct 2007 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=EhvxOgRfYF8LMpEprjBy+8/F4yAlLsvE8tNSG4iKaSo=;
        b=Xvyw308xHCmFDyeq76z11Dae9BgsH+nmptZttwfGtjr84K7x2zW0b/9zTYgoW4jfrk9j8p4xSzHy/b0QJQUPcvfHABZrGcnhPQTzl5HBkzJlgPSHqvSYrN5R1kd76t75CI29/C6pE/IcvlCML1gn3Apc7HFIorOFcGm8s47fsDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ejnbodpea5LfQBGlPdZ3pSZQ1fxCYywXXOPLa+Dxezgao3jlCJUM4I4XaGkezWXjMBpzVqsy2+JGvWTZoBqQqsq7GoPmFynVBHqau1svKB5860fUPN7nDiijG8lnDBiDhcz8yJj2hz2cysLer4EMzbda8yIpGQr/OR92xqgz6B8=
Received: by 10.114.125.2 with SMTP id x2mr8769631wac.1191691114551;
        Sat, 06 Oct 2007 10:18:34 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 6 Oct 2007 10:18:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60150>

Hi

I've been collecting patches from the list for the last couple of days
and published them as topic-branches on http://hjemli.net/git/git (see
http://article.gmane.org/gmane.comp.version-control.git/60023 if you
wonder _why_ I've done this ;-)

All topic-branches are prefixed with 'q/' and the authors initials,
they're all based on current master
(58ba4f6ac828606fc206cfd5cec412a6974c91a1), and I've run 'make test'
successfully on all topics with code changes. There is also a list of
topics with links to the relevant postings at
http://hjemli.net/git/git/tree/branches?h=q/meta

Please let me know if I've your patches are missing, and I'll swiftly add them.

-- 
larsh
