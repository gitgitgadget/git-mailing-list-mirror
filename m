From: "Ping Yin" <pkufranky@gmail.com>
Subject: What is the whole process of cooking git as a maintainer?
Date: Wed, 21 Nov 2007 21:11:32 +0800
Message-ID: <46dff0320711210511g7d9febf5k47b082cc13bb905a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 14:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IupNN-0006yv-HI
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148AbXKUNLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 08:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758958AbXKUNLe
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:11:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:32501 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758846AbXKUNLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 08:11:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2779816wah
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=z6I+YQGJBbC1tOJoGbYuUqy0nZ4tUzVbc3ZnkvUxn7o=;
        b=mwVtQtLUO83t4/gDH1rUIEiFVvVY6ND6YbfiXsjHgYva8vAgw8RgflbiaJIqMrpZD+ppZDc395a4MY/wPlB6eRWsYrlLxlck8DLvMkggXF8nM1UBIGaFzEVUTANwRtoJs4hL5GkSBboxp+RX+1jCU+GUGiEO8qARGP4Z/Sevf7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AGoY6vY93blYVWIcQB1P7T9ngk6iAFTWwNH60pqZoAE/oK4srYn57juyy+774a7iUsCitmMY0baNhIiUDv0iQsLI1NhDAkxKritiLbgtHNH08lj0aiIQiExvQ+Yd3q3iO727/EY+uPvcDRQwZP83CcAIaKaB0XiatfxW+tyCeqI=
Received: by 10.114.103.1 with SMTP id a1mr103031wac.1195650692479;
        Wed, 21 Nov 2007 05:11:32 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Wed, 21 Nov 2007 05:11:32 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65645>

I have scanned the manual and found a 'Linux subsystem maintainer'
example. However, that's a little brief and i wonder a more real
example. I think an example of how to cook git as a maintainer is
better.

Junio , could you please share the whole process of cooking among pu,
next and master? Or, can i find this in the mail list archive?

For example:
In which branch the test is performed?
How to rewind pu?
How to merge a subset of changes from pu to next, and from next to master?


-- 
Ping Yin
