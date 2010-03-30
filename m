From: Jon Seymour <jon.seymour@gmail.com>
Subject: Are the patches used to build git on cygwin available in a git repo 
	somewhere?
Date: Wed, 31 Mar 2010 04:16:56 +1200
Message-ID: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 18:17:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwe7n-0005lQ-Kr
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 18:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab0C3QQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 12:16:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45305 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0C3QQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 12:16:57 -0400
Received: by pwi5 with SMTP id 5so7871026pwi.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=mvNiSMvp2oG8CXI2ep8BTDaMnF5dhMYDYurzC7Vs4KI=;
        b=s505IoPhs0VADi0iTMqIVUSeT5wnja2NCNDyJKv5UGPEOw/11lQNFyZita6LREjqvG
         z3AzUqyX+xWkRhgg1yi97uzja33k5JnFm94b0xxJGwDP5bLW4Wl7sHm8KyoKEqMCUuOW
         n8vor40Y70KJ+oQNInoz8tdBAxcPipcID5WPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=RRSZQn51PNlcUg7c1v72WiPk8ftlaPjO6qLsx7hAOhDNPUiEowRgkFMCh6To3o86Nx
         j784A83QoOJsmjZIgyGT+GIJnivSPgYYbNhDwUVRQYdnrXU6eifteEtJoul7yhoP4tEa
         M5fn0AnVzHWzDZl0U4E7PqkZqfdI7XXIHbScI=
Received: by 10.114.13.5 with HTTP; Tue, 30 Mar 2010 09:16:56 -0700 (PDT)
Received: by 10.114.164.24 with SMTP id m24mr6804722wae.138.1269965816373; 
	Tue, 30 Mar 2010 09:16:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143576>

I notice that certain tools, such as gitk, won't run correctly if git
is built from the master branch.

Does anyone maintain a git repo with the patches used to successfully
build the cygwin git packages?

jon.
