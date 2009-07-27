From: Scott Chacon <schacon@gmail.com>
Subject: Pro Git Book
Date: Mon, 27 Jul 2009 10:56:57 -0700
Message-ID: <d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 19:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVURw-0000Qz-N0
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 19:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZG0R47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 13:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbZG0R47
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 13:56:59 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:36056 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbZG0R46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 13:56:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so4704900and.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/iYKr5LsNugzK8FgzmIrulEm2osGat8odptNcqqgeKI=;
        b=ah1iamktP2XoVJlFbvtbZ0PHaZyRl9+uaQWsdghv8/qDnU9bYVulCqHmC70A8eMM7G
         00KyKbJ/OzO3MgkNV01vLgLRhuPEDN9l4thNHwcVGVSTkhr1hyI2oAZF3v2QWZdiCNK8
         s6DDx8WbJLPVWMuV/DB5RzvDIFgcqdbSMcD/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=XruWmh0XsjdHYbRBLbor2zwXlFsJ27eQ+aOfkmEnIRR0YeXsBlpcqnCg5+JEGNfdxC
         1dxCHqyEIDJ1n0dKMKAnYwhpUEcJvu6Y/fjt4xvteMIzXjM1x8qZtQcbjqA3CiJ+CyKS
         5eis/EoLQQkdlAkqpQPq2vMzT2JAqE39+0zsA=
Received: by 10.100.251.8 with SMTP id y8mr8785835anh.74.1248717417777; Mon, 
	27 Jul 2009 10:56:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124176>

Hey all,

Just a heads up - I've been working on a book on Git being published
by Apress called "Pro Git", which is being licensed under a CC 3.0
license and as I've just finished some of the final reviews, I've put
the entire content of the book online at:

http://progit.org

It should be shipping at the end of August, I think, but I just wanted
to let people know that there is another resource out there to help
learn Git.  This one was actually technically edited by Shawn, too, so
hopefully not too many serious errors of mine got through.

I've added a link to it on http://git-scm.com under the Books section,
in case you want to point any newbies there.  Hope this helps take
some teaching load off some of your plates.

Thanks,
Scott
