From: Bruno De Bondt <bruno@dewereldmorgen.be>
Subject: git clone / svn checkout
Date: Fri, 12 Nov 2010 18:01:12 +0100
Organization: DeWereldMorgen.be
Message-ID: <4CDD72D8.9010205@dewereldmorgen.be>
Reply-To: bruno@dewereldmorgen.be
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 18:00:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGwz8-0005BQ-Ld
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 18:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab0KLRAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 12:00:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36691 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0KLRAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 12:00:14 -0500
Received: by wyb28 with SMTP id 28so2115731wyb.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 09:00:12 -0800 (PST)
Received: by 10.216.143.9 with SMTP id k9mr3821703wej.64.1289581212262;
        Fri, 12 Nov 2010 09:00:12 -0800 (PST)
Received: from [10.0.0.140] ([91.183.60.172])
        by mx.google.com with ESMTPS id w8sm2284538wei.45.2010.11.12.09.00.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 09:00:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161353>

Hello,

Just started using Git, coming from SVN.

Something I regularly do in SVN, is checking out part of a repository,
instead of the complete repository. Consider the following: I have a
local repository for development. On my testing server, I only (SVN)
check out part of this repository, eg. the document root of a website
(and not all the project management documents, which are in the same SVN
repository, but not needed on the testing server).

How would I do this in Git, ie. only get a specific part of a
repository? I feel that this is very much against the whole idea of Git
(where, as far as I understand Git now, you work with complete clones of
repositories), but is there a way to do this? Or should I just clone
complete repositories on my testing server as well?

Thanks,
Bruno
