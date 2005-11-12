From: Andreas Ericsson <ae@op5.se>
Subject: git.org registered
Date: Sat, 12 Nov 2005 13:25:41 +0100
Message-ID: <4375DF45.3020301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 12 13:26:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EauS4-0000cG-N1
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 13:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVKLMZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 07:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVKLMZm
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 07:25:42 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:6837 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932374AbVKLMZm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 07:25:42 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 3903B6BD02
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 13:25:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11677>

git.org has just been registered (well, "just" being what www.git.org says).

Might be nothing and it might be someone hitching a free ride.
I just thought you all ought to know.

$ dig git.org any
; <<>> DiG 9.3.1 <<>> git.org any
;; global options:  printcmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 57025
;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 2, ADDITIONAL: 2

;; QUESTION SECTION:
;git.org.                       IN      ANY

;; ANSWER SECTION:
git.org.                86380   IN      SOA     ns33.1and1.co.uk. 
hostmaster.1and1.co.uk. 2005102501 28800 7200 604800 86400
git.org.                10780   IN      A       82.165.85.125
git.org.                86380   IN      MX      10 mx01.1and1.co.uk.
git.org.                86380   IN      MX      10 mx00.1and1.co.uk.
git.org.                86380   IN      NS      ns33.1and1.co.uk.
git.org.                86380   IN      NS      ns34.1and1.co.uk.

;; AUTHORITY SECTION:
git.org.                86380   IN      NS      ns33.1and1.co.uk.
git.org.                86380   IN      NS      ns34.1and1.co.uk.

;; ADDITIONAL SECTION:
ns33.1and1.co.uk.       86299   IN      A       195.20.224.152
ns34.1and1.co.uk.       86297   IN      A       212.227.123.27

;; Query time: 47 msec
;; SERVER: 193.201.96.2#53(193.201.96.2)
;; WHEN: Sat Nov 12 13:19:25 2005
;; MSG SIZE  rcvd: 239

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
