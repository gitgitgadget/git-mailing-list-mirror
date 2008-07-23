From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Wed, 23 Jul 2008 22:38:02 +0700
Message-ID: <fcaeb9bf0807230838u4f82601bu6dcec0ed038e9611@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 17:39:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLgQk-0006ZS-Si
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 17:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbYGWPiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 11:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbYGWPiG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 11:38:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:7690 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYGWPiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 11:38:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1158154fgg.17
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ao7ykE1egmu7zSljzp8ZojU2fHw8/lINNexYG+CsppA=;
        b=iIPsOMYDJCsj8Zl81ZSge8vB00Z9MLWXCUvxWbIJ9+Du/23VI/BakMFjejJ50jpztZ
         HDfQeCrvemZHZCCBIP0p65mSvA95DMKr6UJ0z+LR3Sd693+95r2ILL4rccd9MElq0lpZ
         YvD1jW8qNYL1+xAanBBY/EKvAW7Xh1U+EjPF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uPOliLE0Bno8V0uPvm4dquYHOy3QrCfPnlTtojyjIGNoRXw8b/g8aBQElVeyePBhzz
         QFau6vCgtJqZCiFakxgoG9RXHkVjjpSfo/xzgo5c6dAsaL/veGc+fwYE3+pibJkQ1NQ2
         fs4WS7z3ArhtQt9HaL88Ea1vbbxNBu/NoQpNk=
Received: by 10.86.74.15 with SMTP id w15mr213848fga.13.1216827482903;
        Wed, 23 Jul 2008 08:38:02 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Wed, 23 Jul 2008 08:38:02 -0700 (PDT)
In-Reply-To: <20080723145518.GA29035@laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89686>

Sorry list. Forgot --thread in format-patch :(
-- 
Duy
