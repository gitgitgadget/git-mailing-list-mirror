From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Subject: git 1.4.4.2 is giving the following errors...
Date: Thu, 21 Dec 2006 10:45:44 +0530
Message-ID: <ace3f33d0612202115p3fedb169pf235c4556f2eef57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 06:15:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxGHU-00087X-Gc
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 06:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWLUFPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 00:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWLUFPq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 00:15:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:39084 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422728AbWLUFPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 00:15:45 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2914700nfa
        for <git@vger.kernel.org>; Wed, 20 Dec 2006 21:15:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gUDo0bqGrzoXUc3V7aTqvv2CqpF+AP7rwDdYGS3XyLbh91udR/TF0fyRV2tSZOGgzSvsgOCF7V2K0fykkurc6KPVEqS6ogS8oNmW+YpvbHILVOlsRL44ZO53PygdRafFap88EDGNi8UpJRdUMAU3d9SbUzJwBI3Fu1LWcqsz0yU=
Received: by 10.49.90.18 with SMTP id s18mr10331310nfl.1166678144328;
        Wed, 20 Dec 2006 21:15:44 -0800 (PST)
Received: by 10.49.85.4 with HTTP; Wed, 20 Dec 2006 21:15:44 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35014>

Hi,

      I am new to git.
From the web site downloaded the 1.4.4.2 source and compiled on the
cygwin environment.
when am trying as an example to use the git,

------------------------------------snip----------------------------------------------------------
sh-3.2$ git clone git://git.kernel.org/pub/scm/git/git.git
: command not foundclone: line 7:
': not a valid identifier line 9: unset: `CDPATH
: command not foundclone: line 10:
'usr/local/bin/git-clone: line 11: syntax error near unexpected token `{
'usr/local/bin/git-clone: line 11: `die() {

sh-3.2$ git clone http://git.kernel.org/pub/scm/git/git.git
: command not foundclone: line 7:
': not a valid identifier line 9: unset: `CDPATH
: command not foundclone: line 10:
'usr/local/bin/git-clone: line 11: syntax error near unexpected token `{
'usr/local/bin/git-clone: line 11: `die() {
------------------------------------snip---------------------------------------------------------

i am facing the above prints. Could you please help me out, am i doing
any thing wrong?


best regards,
srinivas.
