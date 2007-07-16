From: "nathan bullock" <nathanbullock@gmail.com>
Subject: I never want to push a given change
Date: Mon, 16 Jul 2007 10:18:09 -0600
Message-ID: <916b88c10707160918n7a4948g5fb55a9d8ace9833@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 18:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IATH4-0001Ek-5P
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 18:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759633AbXGPQSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 12:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759166AbXGPQSL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 12:18:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:41694 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422AbXGPQSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 12:18:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1633428wah
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 09:18:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ddtQfX0JV+E7vlWHQt2INYHV7Vcuaks1jSpQ/w70aFz1WcLO7GRMqA4RP5ZObVaJW8mEDegKh3GLBhc2VhCIKDudo84YWYrv6li9q+Y7EAf1gIKCRpjhH84IpD4jg0czJa6AuN1+KsWuem50JLKzDum/RU8uJJolZzfK0O/d/G4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VozKhxJrNJhPcsMj6tD3WMkrgJ7CUwDWNkjwyxQI9pKjOuGYbaWQmUIlaQ8sCLlvFY2LAN+LuPM2CFRODtAjtblhEyvYjjS4AuRw04Id3GmkdjJWpZ1uwYDeoGeMFuxX5/LfSDIsbnx/f4CR/Qm+w1GeCzEXFAryo35Ai5/xgWQ=
Received: by 10.115.108.1 with SMTP id k1mr4257163wam.1184602689751;
        Mon, 16 Jul 2007 09:18:09 -0700 (PDT)
Received: by 10.115.74.2 with HTTP; Mon, 16 Jul 2007 09:18:09 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52682>

I have been using git for a little while and one thing that I would like to
be able to do is never push a given change, or set of changes.

So lets say I clone a .git repository. Then I make a couple of changes
that I don't want anyone else to see, do a commit. Then I make some
other changes that I want everyone else to see and do another commit.

How do I push just the second commit?
And how do I make it so that every other time I do a push after this that
first commit will never be sent?

Thanks,
Nathan

ps. I am really enjoying using git. Thanks.
