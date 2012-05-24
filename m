From: roucherj <roucherj@telesun.imag.fr>
Subject: credential-helpers + remote-helper, starting  =?UTF-8?Q?point=3F?=
Date: Thu, 24 May 2012 17:14:35 +0200
Message-ID: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <matthieu.moy@imag.fr>, <kim-thuat.nguyen@ensimag.fr>,
	<pavel.volek@ensimag.fr>, <javier.roucher-iglesias@ensimag.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 17:32:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXa19-0004Dr-72
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 17:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401Ab2EXPbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 11:31:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59097 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2EXPb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 11:31:29 -0400
X-Greylist: delayed 1009 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 11:31:28 EDT
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4OF6W8S031458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2012 17:06:32 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4OFEZeH029742;
	Thu, 24 May 2012 17:14:35 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q4OFEZE1014868;
	Thu, 24 May 2012 17:14:35 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q4OFEZxq014866;
	Thu, 24 May 2012 17:14:35 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to roucherj@telesun.imag.fr using -f
X-Sender: roucherj@telesun.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 May 2012 17:06:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4OF6W8S031458
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: roucherj@telesun.imag.fr
MailScanner-NULL-Check: 1338476793.25844@11VxRk/QFXnS4MIO8l3dhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198389>

Hello,

I want to know if anyone can help me with git-credential-helpers we are 
trying to use git-credential-helpers in the git-mediawiki (implemented 
as a remote-helper).
We need to ask for the login/pass of the wiki and it would be nice if 
we can use credential-helpers to manage this credentials.

Anyone can send me a starting point, like a url with the documentation 
of git-credential-helpers?
To see how we can import credential-helpers for used with mediawiki.
