From: Israel Garcia <igalvarez@gmail.com>
Subject: backup git repo on every commit
Date: Mon, 12 Oct 2009 08:41:15 -0500
Message-ID: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 15:48:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxLDf-0005VL-0B
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 15:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbZJLNly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 09:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755830AbZJLNly
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 09:41:54 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:47694 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724AbZJLNlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 09:41:53 -0400
Received: by bwz6 with SMTP id 6so3105964bwz.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=3PzEMhbxfBj7E28YSEkcyG/seNDx4KjxYW79vZljUnE=;
        b=xcXFQC5vLIsPj3E5MuGOtyMOdiTs0Qpqs3zlMb5aU3KpHNuQN+HiM+zHfQ897ywxD2
         DflIZKf7zacGxvu3LmyVx384ZunMhz+otLwKpoOrxpvZYkj17asNiaQnkPF5H6BN3s08
         yMsIIZHI655klrrVvyjIobYrmxTVV3fTW+YLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=j0bUHLSlc+6TYBkkTwAtCYVVwrL1sdflpaUFJ/3KcOTMZJ/sYYuQ/wIo1Pg92X1TH2
         DngBwtL53CQ01QRVXIkZgoSPyyuowzgYVgtn0WgL/JVfI2Ioup+qGRohwhw2k/jpdoZt
         npWCVDbTdNOKOsjLToeEhCEOy2rBf/palVK8U=
Received: by 10.204.152.27 with SMTP id e27mr5109066bkw.192.1255354875697; 
	Mon, 12 Oct 2009 06:41:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130011>

Hi list, a simple question.

Which is the simplest  way to backup a git repository after every commit?

-- 
Regards;
Israel Garcia
