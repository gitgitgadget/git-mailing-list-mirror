From: Caleb Cushing <xenoterracide@gmail.com>
Subject: fatal: git write-tree failed to write a tree
Date: Sat, 28 Feb 2009 11:25:35 -0500
Message-ID: <81bfc67a0902280825t507e385bvd25c846add2a299c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 17:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdS1u-0000Um-TN
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 17:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbZB1QZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 11:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZB1QZj
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 11:25:39 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:10473 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZB1QZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 11:25:38 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2704645qwi.37
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 08:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=TBbFIQgKvG0rfMgiXdnenaNP8mSYpD4Yv7HqwnKZFzY=;
        b=qN2uIOSf2/QA1/brkSmGVRy1Eu9ypysQnP4U250VJXBCN/sb5YCjJy13PuxQ2nCokR
         AuOaK9MU/2ZGd4l4Xl/z6t/q70WOz/cIpKOeQzE+73GVr6aVW9Xah1gY3xotisgbUqYD
         NBTI0wqEptHAk38oDVrBo5i8hogOuzq8PILI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mMxkdiM+kNc2Q8WV8WTI38StN1Mud1GCuDn0XrCpKkgPlBSfKu/DnX1snaAtQXcLQw
         FVn2ozehJaoXJwE6rO9S1lxr+UBsI3yXV2Fh8oanHRseD811Uc2QZd5OKZB+t2QCX3kM
         6Pct3YqD0sg5rLsssxZRYLajSmVf6AcdFlVJU=
Received: by 10.229.74.12 with SMTP id s12mr2512858qcj.27.1235838336007; Sat, 
	28 Feb 2009 08:25:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111772>

git merge java-overlay/master
Adding profiles/package.mask/gentoo.org
Adding profiles/package.mask/perl-experimental
Adding profiles/package.mask/regen2.org
Adding profiles/package.mask/sunrise
profiles/package.mask/java-overlay: unmerged
(f67eeb638e2593b2bee5c9b476e3044a8404916a)
fatal: git write-tree failed to write a tree

normally merges work fine... hmm...

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
