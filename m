From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: gitosis-lite
Date: Mon, 24 Aug 2009 17:58:57 +0530
Message-ID: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tommi Virtanen <tv@eagain.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 14:29:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfYfy-0001bf-Ob
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 14:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbZHXM24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 08:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbZHXM24
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 08:28:56 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:33610 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbZHXM2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 08:28:55 -0400
Received: by iwn42 with SMTP id 42so923948iwn.33
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=msI59KWguM0bMAoaYGU4MCByUHUPJ+LKPoWmuAshd+o=;
        b=K+tZQY6jfJcBFPhgcn6nDLzhwbwy343pORuPA2vJuk8F5LYgJXKV0iSBSA7SQRbsOv
         S2tEi90t8G7e4/hwyxc2nFxovgtr9foc91jKjgvPbQgMqUbvf909njzYqMyZZBUSBOll
         TyoSudSA5Pg4PgKDiQraUWJbmIjH9aflfwTFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=NGr3bz+v7TodMZluhBtDAs1iMncMb28Hun6V+v8mW2O5yuKDjMhz7c5T6+i45JpirQ
         +RA+tt53nnLhKe8ThBZqSKZX+gdMHB+92Cctls5KcNM+zapbUthOcPqOHTO8RiN77Rp+
         hj+lGuYnLY/8kH5M7P8kUxGrwZgyRC2MP+zmA=
Received: by 10.231.34.3 with SMTP id j3mr2090132ibd.43.1251116937235; Mon, 24 
	Aug 2009 05:28:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126920>

[Tommi: I chose this name to reflect that it really owes its existence to
gitosis for the basic ideas etc.  However, if you have any objections I
would be quite happy to find another name.  Just let me know...]



Hello all,

I created a new project called gitosis-lite, which combines
the essential pieces of gitosis with the per-branch
permissions stuff in the example in the howto directory of
git.git.

The config file is different, (there's an annotated example
you can look at).

The "why" and the "what" are all at
http://github.com/sitaramc/gitosis-lite

-- 
Sitaram
