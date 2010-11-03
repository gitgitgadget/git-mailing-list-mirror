From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: .gitattributes escape character?
Date: Wed, 03 Nov 2010 13:24:01 +0100
Message-ID: <4CD15461.9070201@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 13:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDcXC-0003qa-76
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 13:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab0KCMde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 08:33:34 -0400
Received: from syntevo.com ([85.214.39.145]:56834 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753795Ab0KCMdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 08:33:33 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Nov 2010 08:33:33 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 0D29460812F
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160597>

Is there an escape character which may be used in .gitattributes to
escape e.g. the space-character? Could octal-escaping help here (I
didn't succeed)? Thanks for any hints.

Marc.
