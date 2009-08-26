From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitosis-lite -- now renamed to "gitolite"
Date: Wed, 26 Aug 2009 07:24:53 +0530
Message-ID: <2e24e5b90908251854x75494012m8471096842927f8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tommi Virtanen <tv@eagain.net>, Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 26 03:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg7j2-0002im-Rq
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 03:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbZHZByw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 21:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbZHZByw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 21:54:52 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:58109 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbZHZByv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 21:54:51 -0400
Received: by iwn42 with SMTP id 42so1492201iwn.33
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=EAoU/b7md4BIa1OT7tcG9MtlILODcaRJ0hIsEeEl1d8=;
        b=rBHdG+ipHNdTYDZQyOy1NlZJT1Ual4idyiecrY5cR2S5tyXSAx4kM/S4I+iMsnsGmU
         E+sIzXAKQLkvT035w0Hk+WhjpYR18mY1yFHIPl3AQIKhhYoOanp0nMzvMpQk+I7W7LMr
         xDIfL2XiH9awZk4pt3gRBLncLBos7JJpTgFQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=BJaOqieR0cM9/xw3PTejrk5mEfCqydDmr8Ab4FrjC9wM0rDukXNEHeEydAVxWdpOD7
         BXyu7ON8Oa5ALOcaW0dr0/CQTl2VFgnxFcST/vo8Wd8vGJIzV2EweaJhNlhGdFSRw+oN
         YL444dh3BzP1t2GIotYZHvSQTvs6RfIyG4I6k=
Received: by 10.231.16.136 with SMTP id o8mr3512240iba.24.1251251693044; Tue, 
	25 Aug 2009 18:54:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127058>

On Mon, Aug 24, 2009 at 5:58 PM, Sitaram Chamarty<sitaramc@gmail.com> wrote:

> I created a new project called gitosis-lite, which combines

I have now renamed it to gitolite.  Seemed a good choice, keeping only
one letter from the main inspiration project; and the hyphen was
bothering me anyway.

For those who already downloaded it, please change the name of the
repo from "gitosis-lite" to "gitolite" in your .git/config.

There is one bug that was fixed; you'll know what it is when you fetch
and see the commit log :-(

> http://github.com/sitaramc/gitosis-lite

...and for completeness, this is now http://github.com/sitaramc/gitolite

-- 
sitaram
