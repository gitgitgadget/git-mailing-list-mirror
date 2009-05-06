From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/2] user-manual: general improvements
Date: Thu,  7 May 2009 01:53:34 +0300
Message-ID: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 00:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1q0M-0005VM-Vi
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbZEFWxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 18:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbZEFWxm
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 18:53:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:7397 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbZEFWxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 18:53:41 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1167071fga.17
        for <git@vger.kernel.org>; Wed, 06 May 2009 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oYpwQDe5WEIjkSxcSq4GZJOJP8C+4RqClRmb/TV93zQ=;
        b=b6t63WE4YguS8dXWP/9SduWJRZPD+K5Nv6DT8+MCRT5bXS0N0s3tGhfLKoPeUc8yZ7
         36ItmEzVaNd/c0pY71fLFWZGlJ3shJeitj+u6A3J+PsQyzHQQPGG3KIsRwqrXjW5zb00
         6ONUSLN8wwLG/73+Wb9DPDbOaZbjqSFt/wotQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iqTSdm3n1wTG4fr6rPLKSZFXk69bRcvl1ggVsekZir3WfMdcjqmbPDHVpw4KjeZmGY
         9bN6vLO/NC2E0EejJwgodXIt+kz/znKIUn6WF1KktKYdZHBMOBcCv3+AW4RI/z0dYXJl
         Szs8UYvo/Nn7HGHyGY6PGBd0PQQ6FilZS1EKg=
Received: by 10.86.59.18 with SMTP id h18mr1869833fga.14.1241650420758;
        Wed, 06 May 2009 15:53:40 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id l12sm12338867fgb.11.2009.05.06.15.53.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 15:53:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc4.14.g96da.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118399>

I split the previous patch series, now only trivial changes are included.

Felipe Contreras (2):
  user-manual: general quoting improvements
  user-manual: use 'fast-forward' instead of 'fast forward'

 Documentation/user-manual.txt |  890 ++++++++++++++++++++--------------------
 1 files changed, 445 insertions(+), 445 deletions(-)
