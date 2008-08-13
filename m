From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Subject: Local uncommitted changes, not checked in to index with gitk
Date: Wed, 13 Aug 2008 14:37:02 +0530
Message-ID: <ace3f33d0808130207w109e834bxa12b3e96ce3ec096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 11:08:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTCKu-00087t-Jx
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 11:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbYHMJHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 05:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbYHMJHE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 05:07:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:60635 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbYHMJHD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 05:07:03 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5385816wfd.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Y3WXiC1bB8OWXzk6qn8WYWhNeWlZLhnweiUakiYUJ2I=;
        b=c4Baqij69sv0UshyAE2VriT5lGeLOBjsDA1htTWP8YV80n33rcpkKJWKvOx5rQwkhy
         j0RUcIBsbj0wgPeXRlWVSZGCE4KYv6EG4tzmL+IWr2wcyA0/InJpsFTACaDkSs88YuE3
         BsbHL5QWjJvncbsY55PPrtjpv9ih6/dNeP5wM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=AX4PkGXyk9rPEkr6USOib1bJFq26NY/7U9r8RwueytgyiTvWXwqYgVbExwgLbEH6x2
         Y77gXgc+zoSyx8JXaYf324NRQWlmjDtHJ4VYijKogd3KH+j/fCc9ERHa0CTkyp8Yh0+h
         6ME6OHrV4syQwi1kvJDELz3YwiK+FR/Dr92Pg=
Received: by 10.142.230.11 with SMTP id c11mr3170852wfh.302.1218618422709;
        Wed, 13 Aug 2008 02:07:02 -0700 (PDT)
Received: by 10.142.134.7 with HTTP; Wed, 13 Aug 2008 02:07:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92200>

just cloning any git repository, next time onwards after pulling
changes, the gitk is showing
at the top "Local uncommitted changes, not checked in to index". Why
it is happening.


-srinivas.
