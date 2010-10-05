From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: 1e633418479926bc85ed21a4f91c845a3dd3ad66 breaks on OSX
Date: Tue, 05 Oct 2010 13:48:23 -0700
Message-ID: <86r5g42wo8.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:48:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ER3-0008Hb-GF
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090Ab0JEUsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:48:24 -0400
Received: from red.stonehenge.com ([208.79.95.2]:41180 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab0JEUsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:48:24 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id D6A1425B7; Tue,  5 Oct 2010 13:48:23 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.13.12; tzolkin = 2 Eb; haab = 5 Yax
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158244>


    SUBDIR perl
make[1]: `perl.mak' is up to date.
    GEN git-add--interactive
Writing perl.mak for Git
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
make: *** [git-add--interactive] Error 2

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
