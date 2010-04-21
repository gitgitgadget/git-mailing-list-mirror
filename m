From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 16:27:12 -0700
Message-ID: <86tyr4v12n.fsf@red.stonehenge.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
	<vpqsk6omppf.fsf@bauges.imag.fr>
	<h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 01:27:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4jKD-0005mo-2j
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 01:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab0DUX1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 19:27:13 -0400
Received: from red.stonehenge.com ([208.79.95.2]:25877 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0DUX1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 19:27:13 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 514221B54; Wed, 21 Apr 2010 16:27:12 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.5.5; tzolkin = 4 Chicchan; haab = 18 Pop
In-Reply-To: <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
	(Aghiles's message of "Wed, 21 Apr 2010 18:04:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145475>

>>>>> "Aghiles" == Aghiles  <aghilesk@gmail.com> writes:


Aghiles> Using :
Aghiles>   git branch test
Aghiles>   git checkout test
Aghiles>   git pull origin HEAD

I do this:

    git checkout -b test origin/test
    ...
    git pull

And it seems to work.  It even announces that my test is tracking origin/test.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
