From: "Patrick Doyle" <wpdster@gmail.com>
Subject: FC6 now has git v1.5.2.2
Date: Mon, 2 Jul 2007 13:09:15 -0400
Message-ID: <e2a1d0aa0707021009y20eb0e14n32a2c5e2abe812fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 19:09:18 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5POo-0001Vk-Jq
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 19:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbXGBRJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 13:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbXGBRJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 13:09:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:56943 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbXGBRJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 13:09:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2402567wah
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 10:09:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b5bqqDw0KCmYGfPJ0V7WnF5n8sE8ZlzdZ5NMIxFGs4DAzPNNwPMWmGYyQuLlz7i5E4gs9x+gQBp2mDzazzqRJKVkcVGQ8HRtLFngTVeP9d7KqwaRSMA3z48DbaDh870+XUTNngiHK15CwNAolyjVOnhgax2oxbdV9lIC5M5YWPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=haTxVcKgeZjlWatRPQNgo1MzyGAK2BgG+FizVGTBUmzCiBpA2EmmAUjxRRjroprsF+lJgX9dXlG/6J8+heKmpVp6gjA7SSwgOlZvTr+YRrDK6zGR2OOTStcMgl18+HVG59URaok5yfotS/kZAb8GT7BIdpX4FFEcejRotxRNk9k=
Received: by 10.114.26.1 with SMTP id 1mr5285828waz.1183396155054;
        Mon, 02 Jul 2007 10:09:15 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Mon, 2 Jul 2007 10:09:15 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51385>

If anybody is interested...

...at least that's what the bugzilla response to my RFE bug report
implies.  I'll know for certain once I get back outside of my
company's manically restrictive firewall and and do an update (which
will happen long before I figure out how to fix yum to work through
the firewall).

--wpd


---------- Forwarded message ----------
From: bugzilla@redhat.com <bugzilla@redhat.com>
Date: Jul 2, 2007 12:24 PM
Subject: [Bug 245598] RFE: Upgrade to v1.5.2.2
To: wpdster@gmail.com


Please do not reply directly to this email. All additional
comments should be made in the comments box of this bug report.

Summary: RFE: Upgrade to v1.5.2.2


https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=245598


jbowes@redhat.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |CLOSED
         Resolution|                            |NEXTRELEASE
         AssignedTo|chrisw@redhat.com           |jbowes@redhat.com




------- Additional Comments From jbowes@redhat.com  2007-07-02 12:23 EST -------
Ok, built for FC6

--
Configure bugmail: https://bugzilla.redhat.com/bugzilla/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.
