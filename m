From: Davide Fiorentino <davide.fiorentino@gmail.com>
Subject: Re: [BUG] rewriting history with filter-branch --commit-filter
Date: Wed, 20 Aug 2014 10:59:51 +0200
Message-ID: <014F6E4D-96E8-451A-B7D4-379C260240FD@gmail.com>
References: <17DBA232-E993-4B3C-9952-90424976A28D@gmail.com> <20140820085247.GB12999@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 11:00:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK1ky-0005Kh-6k
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 11:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbaHTI74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2014 04:59:56 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51133 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaHTI7z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2014 04:59:55 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so6554317wib.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=idGXItfL2wiVFD6Q5bWDPtYs21ongdiRHk0/BKpV0vI=;
        b=FMVTYQTya5ayK8calaZASeTX6hqXzA0wjv+PcuNVK0DsLDuJWtdHrZNMUF6fCR6lry
         KeQdO3JGZuX5x7yLsclHhiLuAuSqYJuWe61pexKZWKB7UlYuyeaWo1h9GOFIbupBQk0I
         V+SJPh4/qV/ZqJ5hlrKFtYpnxvHaqhAKxpKK16iZgxy5mYGIRkHdvDvpZ+lf69wVIAdT
         FIc/iqdVMRDWJe6qQ1Gk8+/So04uQbifG47yVs9jIWDB15djF343Ds0AZvYmg05YDmP2
         eTZVn9+Yw53mw1b9yAJF7lhZGX7TsmFdqVXd+guAavheIhOPgTMGht36oIaMw5Vr3WAn
         Bbtw==
X-Received: by 10.194.205.70 with SMTP id le6mr56136669wjc.25.1408525194226;
        Wed, 20 Aug 2014 01:59:54 -0700 (PDT)
Received: from [10.12.6.10] (ppp-136-37.98-62.inwind.it. [62.98.37.136])
        by mx.google.com with ESMTPSA id mx10sm7214743wib.1.2014.08.20.01.59.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 01:59:53 -0700 (PDT)
X-Priority: 5
In-Reply-To: <20140820085247.GB12999@peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255561>

Damn! I haven=92t seen that missing space.

Thank you Peff!

Davide