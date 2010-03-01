From: Tim Visher <tim.visher@gmail.com>
Subject: Thoughts on git-completion
Date: Mon, 1 Mar 2010 14:51:11 -0500
Message-ID: <c115fd3c1003011151n398780fev24d0bd44bb634d83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 20:51:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmBeT-0000wf-UU
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 20:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab0CATvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 14:51:33 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37869 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab0CATvc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 14:51:32 -0500
Received: by gyh20 with SMTP id 20so1321357gyh.19
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 11:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=+5i/sOJYS27ls/1alcX95LDuI6o/8kimCwUwLZK3EgA=;
        b=Lo9KOe8uGEuJcoK/VFB3r6KmWkqDfjXuxn6xjTKWwLoCfM/iDpJEkMJ0e2lkSNSP7W
         HjRci/CxwVl3yiHkFRoOgBtrUXoo9l536pBFAnKwFSf0qHwAn/jIxxUYVkXyHbZazkab
         DUYeesqw6NxmQ7q/WDm+JNqLoRj/Dpmoyg/tM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=sH+1wZV1RkoQ6Zfk1Lr9WqjumKsLttiayLhV2ZWuv5CgXn1DwbH87w7nOmgT4jb+wH
         BfOimZxtJx49vbFuXkYKQXr+04cdwys2imZecEXVmbOEgNuie7gVL67Okg6dxYBJDh2T
         b73nXa/yFIN3VZ7gmHgSuNDRl3C+qSmmGIKOM=
Received: by 10.100.236.5 with SMTP id j5mr7071644anh.60.1267473091266; Mon, 
	01 Mar 2010 11:51:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141344>

Hello Everyone,

I `alias g=git` and `alias gk=gitk` on every machine that I use git on
and I have to edit the git-completion.bash script in order to get the
marvelous completion provided by that script with my aliases.  Is this
something that could be rolled in to the official release or does this
rest firmly in the personal customization realm?  I'm prepared to
submit a patch if you'd like.

Thoughts?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
