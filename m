From: A Large Angry SCM <gitzilla@gmail.com>
Subject: This seems somewhat less that ideal
Date: Sun, 29 Apr 2007 15:42:00 -0400
Message-ID: <4634F508.5020702@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 29 21:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiFHv-0002HK-Nf
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 21:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031330AbXD2TmH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 15:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031331AbXD2TmH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 15:42:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:33880 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031330AbXD2TmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 15:42:04 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1355113wxd
        for <git@vger.kernel.org>; Sun, 29 Apr 2007 12:42:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=dcsSZdEtJRWAhmBqjVKYWbcezNEcrhXgpai/784zHLPmnmb4oz19eP5WzsQhG/wV8p0jk+Zt8+g0SNoxn6d6YrcohIWtBc+D1jtMoj6xfvqolh3YgwOI7UfDg9UzsRRjQoyaR39sQOgtO5QbXIauEtk4tpmj7X+aqi998sxS/WI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ImVgAlaGI9rxIn2QVt8lP/SyfODM6A4UmoMEV894qX5oT8pNs3wQBDDzijtzsSUlIQjdi/NqS9nlqViDn7dKRM0hj70GQvNP8RMCLz6kXFG/MqVyQz2qC58h1m//rMO+TFUHWUqCWpaWlFTHhrlkB086M8Iv2Z1bW9BPp00+TX0=
Received: by 10.70.87.11 with SMTP id k11mr6213511wxb.1177875722709;
        Sun, 29 Apr 2007 12:42:02 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id h10sm4558291wxd.2007.04.29.12.42.01;
        Sun, 29 Apr 2007 12:42:01 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45833>

The latest pull (fetch) transfered almost the entire history. Yet, I was 
up-to-date as of last night.


remote: Generating pack...
remote: Done counting 46473 objects.
remote: Deltifying 46473 objects.
remote:  100% (46473/46473) done
Indexing 46473 objects...
remote: Total 46473 (delta 32624), reused 46043 (delta 32299)
  100% (46473/46473) done
Resolving 32624 deltas...
  100% (32624/32624) done
* refs/heads/git/git/html: fast forward to branch 'html' of 
git://git.kernel.org/pub/scm/git/git
   old..new: 9882a52..469d60e
* refs/heads/git/git/maint: fast forward to branch 'maint' of 
git://git.kernel.org/pub/scm/git/git
   old..new: 71e2e59..e9d54bd
* refs/heads/git/git/man: fast forward to branch 'man' of 
git://git.kernel.org/pub/scm/git/git
   old..new: 0d96f48..ab919c8
* refs/heads/git/git/master: fast forward to branch 'master' of 
git://git.kernel.org/pub/scm/git/git
   old..new: 4342572..a07157a
* refs/heads/git/git/next: fast forward to branch 'next' of 
git://git.kernel.org/pub/scm/git/git
   old..new: 0818190..58684ff
* refs/heads/git/git/pu: forcing update to non-fast forward branch 'pu' 
of git://git.kernel.org/pub/scm/git/git
   old...new: bb0b180...591bb09
