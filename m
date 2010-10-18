From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Colored whitespace in git gui
Date: Tue, 19 Oct 2010 01:00:34 +0200
Message-ID: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 19 01:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7yh9-0002YE-BS
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 01:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933093Ab0JRXAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 19:00:37 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45674 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071Ab0JRXAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 19:00:37 -0400
Received: by vws2 with SMTP id 2so910987vws.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=YNmVOTdm2HVZHnBee1OQQSswMHBuqravi7m4/5I6g5w=;
        b=LRE4i1iLXPVnhtokUIoPNI59RXe+BKkqxfyw1JKBsqx5/ibJ5rm8GSn6hMFeBpWqf/
         bsz4NDEVKUnaQ4tOslUp44s3D3zBHjNWQij8MOER2I9bhSnviv5b/Exo72rf+IjVbk2P
         05PSJbFjoIW54/kGbkZtFDwinBu2xWRU+QvDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rre0fkBnPMp9Kwt5gNpjKGKZLSnCKDYWl9igshqF8vaSXRKbz9S97L7LkLJggtdypi
         75wS0uMhjEj9Bbps4BXC7XgLjUD5oXs8gadjeh803hkYwOi2MLfDgXYCVP9ZUkj+Izv0
         kJdEhJ5tZP62Eo8cwc6A6jcusH6wVxq9BfQCM=
Received: by 10.220.194.204 with SMTP id dz12mr1392102vcb.79.1287442835179;
 Mon, 18 Oct 2010 16:00:35 -0700 (PDT)
Received: by 10.220.192.198 with HTTP; Mon, 18 Oct 2010 16:00:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159295>

Hi, all! When doing "git diff", whitespaces before EOL, for instance,
are marked with red background in my terminal.

Is it possible to see this coloring in git gui too?

-Tor Arvid-
