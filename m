From: "Stefano Spinucci" <virgo977virgo@gmail.com>
Subject: using the same repo with different OS
Date: Sun, 25 Feb 2007 18:13:57 +0100
Message-ID: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 18:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLMwq-00053h-FE
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbXBYRN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbXBYRN7
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:13:59 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:20891 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbXBYRN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:13:58 -0500
Received: by wr-out-0506.google.com with SMTP id 37so332607wra
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 09:13:57 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LKydobdhgzhUQH18naScHMT0GFwV98hRQ2AUzDTQDgQEvB1DEMvVLwI/H9XXS0zS3XpzPsElwJTJN1C7Dad3ISrheiLTWrD2F+D6iNE1pusS73tDVnemoKE+5OjRDjVNPwqOk7RCV9Xpi8qZ8973rjhLKwgcTtYv4oh+ZfwO/TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=h1L8uyvLii/RNj90w7ojwHPBJbrz0w9sZZKoh+zwiQ+zNdkkt0VfsetEqR+5SxPKJeNdUnrEOnChevPckOFesk7kzEkC304lE43vemrfX897Qgs+q8NLpK6B32M8IQLKNC2DuLYNkwHCz1LH3NTxeWPdF7AqTFSwba4ymuNFxN4=
Received: by 10.114.199.1 with SMTP id w1mr363272waf.1172423637258;
        Sun, 25 Feb 2007 09:13:57 -0800 (PST)
Received: by 10.114.92.8 with HTTP; Sun, 25 Feb 2007 09:13:57 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40554>

I have my repos on a USB key (fat32 fs) and I work with git under
linux and windows (maybe also Solaris in the future).

Considering also the new MinGW port, should I use a different repo for
every OS I work with???

Are planned/expected OS-specific files in the repo preventing me to
use the same whenever I'm working???

thanks in advance

---
Stefano Spinucci
