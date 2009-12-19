From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Query remote repository files, blobs
Date: Sat, 19 Dec 2009 13:15:55 +0530
Message-ID: <d16b1c80912182345h4163430bv810adb860575d67a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 08:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLu1I-0001R8-Rw
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 08:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbZLSHp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 02:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbZLSHp5
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 02:45:57 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:63496 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbZLSHp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 02:45:56 -0500
Received: by ywh12 with SMTP id 12so4177611ywh.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 23:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=9mrG1aUQmdSwbQ5wDPhvNTiT9f+qc06fQ3i/o91If4o=;
        b=CKIU3Mu89qC48EeYR7jSvlZaRNyjQOMvzF5m4wS93yvFUVuz+mTAYfagFA7dN9NEVJ
         vXBkrKzGwUolSvv3QLFksEg9w13AO1CcUaUBifKboDl6PLUSkiw14WPUHpU9djrgG87O
         fySNKCAvbRGS1h5bg28zipAeDcEXoh2RKRTQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Q1weAdog/ADmYg4U8ihrMQLyQhpocqtsqDYFg6vJr7Ztha/3PzlxSzJkUYYZYbgAOo
         7mjYrHCJEjFLi0+gbt2rACNF0jcCtRXollX89uk5FJB9netJsIU2fzEU8QG0dkiMaR/V
         ldJLRkaNOarv1JiiRANiWTTNCsx5MKRBwYehg=
Received: by 10.90.150.17 with SMTP id x17mr5200087agd.57.1261208755295; Fri, 
	18 Dec 2009 23:45:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135469>

Hi,

>From git-ls-remote:
http://www.kernel.org/pub/software/scm/git/docs/git-ls-remote.html

I am able to query for list of remote heads, and tags. I would like to
know if it is possible to query for information on remote files, or
blobs? Sometimes, I am on a slow Internet connection, and I just want
to be able to see the remote file diffs, or new file, branch
additions, or changes without having to clone the repository.

Appreciate any inputs on this regard,

Thanks!

SK

-- 
Shakthi Kannan
http://www.shakthimaan.com
