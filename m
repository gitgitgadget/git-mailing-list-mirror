From: Enrico Weigelt <weigelt@metux.de>
Subject: import determinism
Date: Sun, 7 Nov 2010 21:25:36 +0100
Message-ID: <20101107202535.GA18766@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 21:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFC0k-0001lw-1v
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 21:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab0KGUii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 15:38:38 -0500
Received: from caprica.metux.de ([82.165.128.25]:41123 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751521Ab0KGUih (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 15:38:37 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oA7KeTJG016313
	for <git@vger.kernel.org>; Sun, 7 Nov 2010 21:40:31 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oA7KeA2o016227
	for git@vger.kernel.org; Sun, 7 Nov 2010 21:40:10 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oA7KPaiR019380
	for git@vger.kernel.org; Sun, 7 Nov 2010 21:25:36 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160899>


Hi folks,


I'm curious on how deterministic the imports (git-cvsimport and
git-svn) are. Suppose I close the same cvs repo twice (assuming
no write access in between), are the resulting object SHA-1's
the same ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
