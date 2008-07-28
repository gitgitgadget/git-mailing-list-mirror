From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Importing patches from email, which address?
Date: Mon, 28 Jul 2008 12:59:24 -0400
Message-ID: <9e4733910807280959h19039402kc14bfa1a3b653846@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 19:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNW5D-0000gl-F2
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 19:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbYG1Q7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 12:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756449AbYG1Q7Z
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 12:59:25 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:37259 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267AbYG1Q7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 12:59:24 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4543500rvb.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=dGb7iAPdVN/OJltd+67AvmDaLDS7O3OK8pex5pvvWSw=;
        b=roNpNkadhlJXRYAIdfHvwLEk0qVHPPW2SJgAurHaghBAQ8z9q/FEDGev92WdquU+2a
         Dj7MeJ6TVwMYj2wXo42QE7t64u+mRuiEY+rm7/jeJBD4pShqnAyS4B7sdNGSBbaJtuWW
         SsMOIW3WgT5zOrL2aMglu6Cec5Sns42q/WYAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=sEpKgNffkYigfnxZSJPARif5nFDT64cPLNzu3B007qpKv7/QufZQ8rN9AfN0hSYCcD
         DROfRZdCK4hHJmAUICQX6PFhVq2u7hKyRVOjqX97J8Q56BGhPbtddXJNRE0Buz2dEmF9
         R8p5jpSdkXZbv5S7vFiTxbr/HQ043AeG+IBBI=
Received: by 10.141.43.5 with SMTP id v5mr2481939rvj.49.1217264364415;
        Mon, 28 Jul 2008 09:59:24 -0700 (PDT)
Received: by 10.141.146.7 with HTTP; Mon, 28 Jul 2008 09:59:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90474>

When working with the list of author emails for the kernel, I noticed
that a lot of the author's email address are from internal mail
servers. How is the handled in git (stgit, etc..)? Is the import using
the email From:, would it be better to use Reply-to:?

-- 
Jon Smirl
jonsmirl@gmail.com
