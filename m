From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: editing description of patch
Date: Wed, 3 Oct 2007 19:26:20 -0400
Message-ID: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 01:26:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdDbu-0005Zh-JM
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 01:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbXJCX0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 19:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbXJCX0V
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 19:26:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:7041 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbXJCX0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 19:26:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so5618632wah
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=gvX+J3as5WfqAX2qen0Xk/L6aoZGoGt6YIbWr+r3MIE=;
        b=D4KGuBFe02fYXE9MzTSEQFIL1WecoUNNunV/krVORpOH8LHUM6EZSk4bPv+OcAknHrEWMuJa4A0FI9/BPZjUP0UszrA9MIU8aWdNs80RoDQtKML3ppC9IXtz60QJYz8QunX4OJBY1UleVTtx/21aQaXpYwNkjFXtjazfUMJ0jng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YOKfVsWvO7bB10kaQbv1lBbwVs5jUwJPWK8ja9m2tVIqlSTScr9KpKhAJNq1TSEZIN9JoDM6DdJHYpAIzse59iOcEOaDOFMcYHHXq2IJeJv7Y9AsAnL3DG8Eup7gVIFFg86TXjBB52Y198hxjrj07VoO6FrTM01dVEUOewJBAYI=
Received: by 10.115.88.1 with SMTP id q1mr4827678wal.1191453980154;
        Wed, 03 Oct 2007 16:26:20 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Wed, 3 Oct 2007 16:26:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59910>

What is the right procedure for editing the various attributes of a
stgit patch? patch name, description, etc....  I just emailed a series
to myself and the titles/comments are all messed up.

On my box all of the patches have names -- stg series shows them. But
when I emailed them half of the patch didn't have the right subjects.

-- 
Jon Smirl
jonsmirl@gmail.com
