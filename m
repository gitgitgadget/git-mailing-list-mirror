From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Parameter --color-words not documented for "git show"
Date: Thu, 20 Jan 2011 20:58:34 +0100
Message-ID: <4D3893EA.5090907@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 20 21:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg0pR-0007Ej-RF
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 21:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab1ATUJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 15:09:52 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:58207 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab1ATUJv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 15:09:51 -0500
X-Greylist: delayed 675 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2011 15:09:51 EST
Received: from [78.52.102.233] (helo=[192.168.0.2])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Pg0eQ-00082j-Gx
	for git@vger.kernel.org; Thu, 20 Jan 2011 20:58:34 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20110103 Lightning/1.0b3pre Thunderbird/3.1.7
X-Df-Sender: hartwork@binera.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165329>

Hello,


I noticed that

  git show --color-words

works just fine, but it's not listed in

  man git-show

I am referring to this version:

  $ git --version
  git version 1.7.4.rc2

Thanks,



Sebastian
