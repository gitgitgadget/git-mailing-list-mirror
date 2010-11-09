From: Will Hall <will@gnatter.net>
Subject: What's the -s switch in git show?
Date: Tue, 09 Nov 2010 16:15:21 +0000
Message-ID: <4CD97399.4010704@gnatter.net>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr> <1288711888-21528-8-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Nov 09 17:50:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFrOi-0003qc-3k
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 17:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0KIQuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 11:50:10 -0500
Received: from mail.qualtersystems.com ([74.200.89.103]:56520 "EHLO
	mail.qualtersystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0KIQuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 11:50:09 -0500
X-Greylist: delayed 2080 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2010 11:50:09 EST
Received: from localhost (mail [127.0.0.1])
	by mail.qualtersystems.com (Postfix) with ESMTP id B0C59533830B
	for <git@vger.kernel.org>; Tue,  9 Nov 2010 16:15:28 +0000 (GMT)
X-Virus-Scanned: amavisd-new at qualtersystems.com
Received: from mail.qualtersystems.com ([127.0.0.1])
	by localhost (mail.qualtersystems.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 38M+FMJUi7cq for <git@vger.kernel.org>;
	Tue,  9 Nov 2010 16:15:23 +0000 (GMT)
Received: from merton.mpc.local (mpc-1.sohonet.co.uk [193.203.82.226])
	(Authenticated sender: will@mail.qualtersystems.com)
	by mail.qualtersystems.com (Postfix) with ESMTP id 2C3795338349
	for <git@vger.kernel.org>; Tue,  9 Nov 2010 16:15:23 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-GB; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <1288711888-21528-8-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161058>

I know this should be obvious but I can't find *any* reference to this 
in git show --help
