From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Deleting remote branches
Date: Fri, 26 Mar 2010 11:30:49 +0530
Message-ID: <f3271551003252300u387f6081seaa03d4eb7194486@mail.gmail.com>
References: <1269582415273-4802262.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 07:01:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv2bp-0006Wc-V5
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 07:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab0CZGBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 02:01:12 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:62128 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab0CZGBL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 02:01:11 -0400
Received: by yxe29 with SMTP id 29so672509yxe.4
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=yUYZOMwyw4e8p67CCJ5X9u3bi18aTooEjRiaxYwtMug=;
        b=a1czwbHAFn03cutvacUDvjiRDltKf8xB+fG+vp6WzuhDPLcg+yvxkhfm12TRelg+pP
         k/dufYjJX4rBlkdHn7csb9zr/g0mNoLL/d9gns2DrdZ+WHfOjaMXK6IKsh8mnhD+wqow
         0Be5OA00G0nOs0GyM1USOUzdETuKDoQbdmCG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dGTjEt/ZlbEaAiR8vKoQajS/aIMY0Ivv64PAMipu3R2M6DqcKNdMM84a2uqKNyiXwP
         SvDe2LuIqEbTDSQGJNnvENbG/v57c1xeKkESgcC8ZRIsOK5Xiskb2VwV1DTyY4xYArjM
         bqO5yUzOvY1I7XIXDZ/NF/YmyDXW6Vp1nwQs0=
Received: by 10.90.52.9 with HTTP; Thu, 25 Mar 2010 23:00:49 -0700 (PDT)
In-Reply-To: <1269582415273-4802262.post@n2.nabble.com>
Received: by 10.91.54.1 with SMTP id g1mr166863agk.59.1269583269207; Thu, 25 
	Mar 2010 23:01:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143210>

See `git push origin :branchname`. It's a listed example in git-push (1).

-- Ram
