From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [ANNOUNCE] gitolite now supports smart http
Date: Sun, 5 Sep 2010 21:07:34 +0530
Message-ID: <AANLkTikKt5srTvn3zh7ZQ54ii=3eDnxAxxy8njtSaz4y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	gitolite <gitolite@googlegroups.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 17:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsHHo-00027W-Aj
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 17:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0IEPhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 11:37:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58159 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0IEPhe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 11:37:34 -0400
Received: by gwj17 with SMTP id 17so1313912gwj.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=//PfbwnSgFptLIP1U+vTS0AnYpDatoUCvt6R9A8grgs=;
        b=htiEs61sh6efjtVnFTpoPniey+qDjVtOtwa6yd4VmVpa9JJ6g2m++FxsGTVDrL9GD+
         KgBn5JDk4mB9FeGGEQ+KIY0rZNO/WnT5Fzuriyk/Mr3lQqtyyeePt8QrczeTuKY/jKQh
         VX0iUhTwJYckWgFumQghetKEW5wGrIsccnEEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=PIPVwMBEj4KQIGODToPSGgNsqreI4gs/+4O6eaaITWY3nZ0VHkhfwWoFSvkJMo6sIr
         HOfmL1m1JHqu7IOaY8Gx0ES02EoAaP4e/DTl8jwrUFgfo+pYJmu55SFvGLPdBOpJFGCa
         d75fwB8RFFTzJZ3cg4o4ctj0H7UAgjPZ8wawg=
Received: by 10.90.28.1 with SMTP id b1mr1081991agb.92.1283701054115; Sun, 05
 Sep 2010 08:37:34 -0700 (PDT)
Received: by 10.90.209.12 with HTTP; Sun, 5 Sep 2010 08:37:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155458>

Hi all,

With some caveats and limitations, we now have smart http support in gitolite.

See http://github.com/sitaramc/gitolite/blob/pu/doc/http-backend.mkd
for all the details.

There *are* some things here I would like help with so if anyone looks
at those items in the doc linked above and tries them out, please
contact me.

Enjoy...

-- 
Sitaram
