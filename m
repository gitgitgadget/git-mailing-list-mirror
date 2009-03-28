From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sat, 28 Mar 2009 23:21:25 +0100
Message-ID: <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> 
	<1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> 
	<1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> 
	<1238276809892-2550565.post@n2.nabble.com> <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> 
	<1238278694146-2550633.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 23:23:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lngvr-0007cW-LM
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 23:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbZC1WVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 18:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbZC1WVp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 18:21:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:56150 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbZC1WVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 18:21:45 -0400
Received: by fk-out-0910.google.com with SMTP id 18so652914fkq.5
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Gu+YlYDR73Kin7ps3vsilg+5I4Sk5RhXTLL4CB7EAhQ=;
        b=j8WYNDe1enhIZ3k9jXyL4KiYLH3/sDOwHC966YDaWFVM1XqoYRt1ZJJ29JhEiCur0N
         OwmeoBpawdc1Jd9C6FNVnmYRiq/Aummgg9828BbFsl4D4TkFYq3zk0XALjMaNSy+xDVS
         VJXnGx4C8kjdRSvu8pUi7NhmKWjZrxDHN7N5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w68hMQRcE0k1fBkwH61aATgPKM9GaTQ+IKGJe2yMbYH9O1JARHNI9cCxmw+gpEO1cR
         ANUxU305s1SH56F/JnysvKx7MbhG69Wu8p2lEUH3xvSyse5kfmU/BA2J/7NUWDJxjJY1
         WF3bo7C805PFcRJ7nw/hEvPTa7KluqTdlBpTc=
In-Reply-To: <1238278694146-2550633.post@n2.nabble.com>
Received: by 10.103.219.17 with SMTP id w17mr993561muq.36.1238278901284; Sat, 
	28 Mar 2009 15:21:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114984>

Heya,

On Sat, Mar 28, 2009 at 23:18, jamespetts <jamespetts@yahoo.com> wrote:
> git: 'svn' is not a git-command. See 'git --help'.

Try updating to the latest snapshot, git shipped without svn on
windows for a few releases.

-- 
Cheers,

Sverre Rabbelier
