From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Submodules
Date: Tue, 7 Aug 2007 15:37:35 -0700
Message-ID: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 00:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIXgK-0001sY-CH
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 00:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759185AbXHGWhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 18:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758707AbXHGWhi
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 18:37:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:54255 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295AbXHGWhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 18:37:36 -0400
Received: by rv-out-0910.google.com with SMTP id f1so1370832rvb
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 15:37:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aaY21WQxN/rw7Px63vyzpDe/tkItFp2BgSFDiV12gRolvwayhGcqCmp+uKVyRoqwLdybWETJ8JEsJRFh/mLCeGr/5u7bd3J/zuD4lwI+mtqKe2NAH0x1rSli/cuLCtm8a7os7XDQdOLRoqZlISd2PLgTRzpk0iHLp8D4DAkI7+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZEXbPPlfz5reho60cH28I8loj4C4A8IoNBRfaMOnMjXd2pKtm5qXlHKAPHFnSjtvmNJZo5aAFUaxeqEZ0or+Upsvs51Bi3ZpBDjIv3BbtZWuby6T4S6toZU5qTCDV/xBAoiCWd7UsCzZluiZ/cVzyRFxJlKtNn3k8cZvus0Pnj8=
Received: by 10.141.99.4 with SMTP id b4mr2706786rvm.1186526255934;
        Tue, 07 Aug 2007 15:37:35 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Tue, 7 Aug 2007 15:37:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55279>

Where can I find more information about submodules?
I'm interested in both internal implementation details and how to use them.

- Dmitry
