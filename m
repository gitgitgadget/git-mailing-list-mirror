From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Visualising stashed commits in gitk/qgit/giggle
Date: Thu, 30 Aug 2007 12:38:35 +1200
Message-ID: <46a038f90708291738h6a399d7bs4dd6778c8815390a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 02:39:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQY3o-0000Fr-TA
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 02:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbXH3Aih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 20:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbXH3Aih
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 20:38:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:52916 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbXH3Aig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 20:38:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so351683wxd
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 17:38:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GnbCsP3Wy32xSd4VRkJwhawBKVhDKPYi+1AqQsi4ZU62DlJIyxlnRTHaKbjo/JBamLEkpPHZA7oTi7H3LPfq+WRmEK/lbWwW5jh8oS/0htQFCxeJdA8Pt/SywN0NVad9stI0+PH6i2/tWK4T6tE1ruQCecBq6m2mYjKHB3c43wA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GZWx/EZxt/55OYBXbZZjWKa367IzlQtk+N+FcGKh94e3Dw8tAj3wAb3hreGIyFH32tEW6pbLGl5GfXUlKd+iHoVTWVFfHA3tqKNzxlCeUaEkcmNdYklpYPKuvpjIAfOc7QPZGNoMu64/2qeZKvlljc3eC1ppHmYwtMBABorvXLU=
Received: by 10.90.36.3 with SMTP id j3mr3279860agj.1188434315635;
        Wed, 29 Aug 2007 17:38:35 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Wed, 29 Aug 2007 17:38:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56991>

Now that we have had git stash in master for a while, I've gotten
completely addicted to it. :-) Before I used to create mini branches
all the time, and my working repos were littered with 'WIP-nn'
branches everywhere.

Which was mucky... but appeared in gitk/qgit transparently.

Is there any way to get them to appear in gitk or any other gui history browser?

cheers,


martin
