From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Thin pack
Date: Thu, 5 Dec 2013 09:44:35 +0800
Message-ID: <CAHtLG6SBOi+v7uchwr1iHtMvzwLOW1hkpNT5x4vVhOKL=t2SdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 02:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoNzb-0005qX-R5
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 02:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420Ab3LEBog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 20:44:36 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:40971 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301Ab3LEBof (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 20:44:35 -0500
Received: by mail-vc0-f178.google.com with SMTP id lh4so12625499vcb.9
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 17:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ORmauLCUd46i9BAymIiuuRePGRvvVNeL2jQqNuegnEU=;
        b=p1Z26Tw+PH3RwrrS3cPsklL8rCWNqPOhbPV/KrZYEJLOBVEu1Ms3IaheR/X9HyDlCg
         IEOLeTOVK+23HC9cK9/b2FnRC+T3zp7zIQJ8TVsi6AhBbPMGLB3FWsdJOiv7Wj1f1M8d
         6+SGDU4O3h9qNQsbH1lhfeRU6Vzqay6x0axEPiO05hmDQhSK8Qu4mCoolWlTFWJ5LYJG
         QiZZdAEHr+zbT+hPJ1Yym57k9mg4GTqilMJ30/OnDqX6SR7b1mr6VE9c5SOcczb+tyvI
         YlxSoUnh+aXnkB55KQBgdTe3OHEK55DrL37NXRt/ylDOWThJtaAOe6oBlt1weDOM2rxM
         jmyg==
X-Received: by 10.53.13.199 with SMTP id fa7mr8363438vdd.31.1386207875182;
 Wed, 04 Dec 2013 17:44:35 -0800 (PST)
Received: by 10.220.30.69 with HTTP; Wed, 4 Dec 2013 17:44:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238836>

Hi,

What are the difference between pre 1.8.5 and 1.8.5 about thin pack support?
Could you describe thin pack?
From the doc, it says --thin is default option. Is that true?
