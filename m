From: Daniel Blendea <bdaniel7@gmail.com>
Subject: git pull (Your local changes to ... would be overwritten by merge)
Date: Thu, 17 Jun 2010 12:35:55 +0300
Message-ID: <AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 11:36:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPBWT-0001Mf-2j
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 11:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759743Ab0FQJg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 05:36:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34638 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759694Ab0FQJg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 05:36:26 -0400
Received: by iwn9 with SMTP id 9so6586893iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=af9PewXFPWBfRL4HBCEl1haUVLqYqQgexcWHK361Zn0=;
        b=j9PyTczjam2eOqhCdx39+99uvxSmvoPoxB7tmgNP4sL0eSzf3qk21zx/um92DbfYX5
         U5V6qDJAkjxkWV8Atu0+/Bwo63a/InvdBS4LBaFXjShIpbpeSa+Lor/aF76b2HKPmpKZ
         bOLRwI7E/StWXXFHA5RP0OzeOx7Uj5tNcOzfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=NqzyYUXKp2BGNSFKtAJ0TXWLEK/uj5kpXM/0F7v5JqozdSxS9+rfHUENTH52jytAsQ
         7YUxpTQPSTRmUdpweSY1HwzHOZgizguSsDuIrKXrpIGHDHsDKWNTscchOSBXad7bUl0Q
         LEbYsweDNcDzfA/zGo8lgZbzl9IdfHafCgG5Y=
Received: by 10.231.209.79 with SMTP id gf15mr9938678ibb.138.1276767385968; 
	Thu, 17 Jun 2010 02:36:25 -0700 (PDT)
Received: by 10.231.190.11 with HTTP; Thu, 17 Jun 2010 02:35:55 -0700 (PDT)
In-Reply-To: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149293>

Hello,

A while ago I have cloned on my computer a git repo.
Since then, the developers have modified several files in the repo.
Now I want to update my copy with the latest changes.

I do 'git pull' but I get 'Your local changes to .... would be
overwritten by merge.=A0 Aborting.'
I didn't modified any local file. I tried using 'git stash save' but no=
 luck.

How can I make git update and override my local copy?
With all the fuss about it, I thought I will handle this operation
pretty easily.

Thank you,
Daniel
