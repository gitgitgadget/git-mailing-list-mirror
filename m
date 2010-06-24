From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: git-notes
Date: Thu, 24 Jun 2010 22:23:48 +0530
Message-ID: <AANLkTildVSt4cau9VhFePnmW057dQBEusCYKIk9NXgtb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 18:54:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORpga-0005Hu-Co
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 18:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab0FXQxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 12:53:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50031 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab0FXQxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 12:53:50 -0400
Received: by gxk28 with SMTP id 28so882384gxk.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=0xqemmqhD9tIdHT20vkwVrPeRMNSZNsqn3rmuVQhigQ=;
        b=ctR9WcG3ocUnph5O+nHJnyCbO3FFuHebv2H5523QNs335k7h6uHX/mdoJDppGF16SE
         Ufpfzct8wFTxcosYsCL9xBO3AbQnCtOnB4M23+2TfH8gxGuOXLVt9yZrLnK4HyA4VE/g
         7br5RcPv/5FDIfTfBq/YfLnnPZeFIFwkOv8fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fL/DOCfygJGmXOHqi/Kg3NttbF5gfVuZLgCAYyZfNtp0Vec1u4w6UxEW0vgg//6imj
         zfFdoSzdspAWCoNxYjLn79M1JEI8eZOFdebdqnLKROHZJQEgZQBOtgVbcozW+uRDwUva
         02DogVEUonCRawTGFwEfuf0Mw1zx0LfpaFSNc=
Received: by 10.90.247.29 with SMTP id u29mr6261981agh.109.1277398428375; Thu, 
	24 Jun 2010 09:53:48 -0700 (PDT)
Received: by 10.90.25.8 with HTTP; Thu, 24 Jun 2010 09:53:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149604>

How to Prevent git-notes removal / replacement by another user in master repo.?

If I add "git notes" to my commit and Push it. How do my repo admin
will ensure that notes are never overwritten or removed; but can be
appended

Thank You
