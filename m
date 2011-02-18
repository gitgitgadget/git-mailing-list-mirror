From: Yongqiang Yang <xiaoqiangnk@gmail.com>
Subject: an error when using 'git send-email'
Date: Fri, 18 Feb 2011 19:45:32 +0800
Message-ID: <AANLkTiktO_f9+g4+wSS989a=pFZBgWGcORd_kg4pji-x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 12:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqOmW-0003VC-66
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 12:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab1BRLpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 06:45:35 -0500
Received: from mail-ey0-f179.google.com ([209.85.215.179]:60583 "EHLO
	mail-ey0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab1BRLpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 06:45:33 -0500
Received: by eyg24 with SMTP id 24so1818115eyg.10
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=J6kFNnfa+aBTCTgfjkwz1NstNNFFL8lP/BjvoUPuSS8=;
        b=HrFM4/y+K0QNv3eJK76r8rf5D/flLhZX43j3vHUkPy7h+GeDpYMAzCNjxyOqLEiy+4
         l3sXfUKRy9I7W0ay4wr0LXEP+EcURRsYJgtpes6gZUyaXhflcXPolnxgwB15a2b+35U9
         eU6vnA8/GrtcIxYHvA58xEeE+ANjfKZTw5M4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=hn0fZ5yt14gpS64Esk7LDDWhZEG6sdbsvnYHBf2cp/eZK8ga9yyG0stogMBK3GfjWR
         GFPMfeVhtbI1NYrNq0XRz0exYWfAy5mE/NdGz6RJcTs5XdlmJDGuFaf+mHopZVKVflbn
         Pu1uVIxY00O30TFLvIlHt6PD54miaiJhO6Alc=
Received: by 10.14.45.15 with SMTP id o15mr713222eeb.46.1298029532030; Fri, 18
 Feb 2011 03:45:32 -0800 (PST)
Received: by 10.14.53.80 with HTTP; Fri, 18 Feb 2011 03:45:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167199>

Hello All,

When I use git 'send-email', I get an error "Command unknown:  'AUTH'
at /usr/bin/git-send-email line 775, <STDIN> line 1".
Is there anyone meet the same error?

-- 
Best Wishes
Yongqiang Yang
