From: Pander <pander@users.sourceforge.net>
Subject: Plain view on image in tree in gitweb results in binary output in
 browser
Date: Thu, 20 Apr 2006 15:57:05 +0200
Organization: Atopia
Message-ID: <44479331.2090305@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 20 15:57:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWZek-0002WV-0F
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 15:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWDTN5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 09:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWDTN5K
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 09:57:10 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:260 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750743AbWDTN5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 09:57:09 -0400
Received: from tsuki.nfg.nl (nfg3.nfgs.net [80.126.246.87])
	by smtp-vbr5.xs4all.nl (8.13.6/8.13.6) with ESMTP id k3KDv8kj051214
	for <git@vger.kernel.org>; Thu, 20 Apr 2006 15:57:08 +0200 (CEST)
	(envelope-from pander@users.sourceforge.net)
Received: from nfg3.nfgs.net (localhost [127.0.0.1])
	by tsuki.nfg.nl (Postfix) with ESMTP id C6F035C084
	for <git@vger.kernel.org>; Thu, 20 Apr 2006 15:57:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by tsuki.nfg.nl (Postfix) with ESMTP id F21D45C08A
	for <git@vger.kernel.org>; Thu, 20 Apr 2006 15:57:06 +0200 (CEST)
Received: from tsuki.nfg.nl ([127.0.0.1])
	by localhost (nfg3.nfgs.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06178-10 for <git@vger.kernel.org>;
	Thu, 20 Apr 2006 15:57:06 +0200 (CEST)
Received: from [172.16.3.9] (ws3.dojo [172.16.3.9])
	by tsuki.nfg.nl (Postfix) with ESMTP id F1E0D5C084
	for <git@vger.kernel.org>; Thu, 20 Apr 2006 15:57:05 +0200 (CEST)
User-Agent: Mail/News 1.5 (X11/20060318)
To: git@vger.kernel.org
X-Virus-Scanned: by XS4ALL Virus Scanner
X-Bogosity: Ham, tests=bogofilter, spamicity=0.007587, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18971>

Hi all,

Plain and head view on an image in a tree in gitweb results in binary 
output in browser. One gets numbered lines with exotic characters.

Is it suppose to be like this in gitweb would it be better to, according 
to the mime type of the file, show the actual image in the plain or head 
view?

Is this configurable or a feature request?

Regards,

Pander
