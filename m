From: Bruce Korb <bkorb@gnu.org>
Subject: failed to push
Date: Mon, 01 Mar 2010 13:15:20 -0800
Organization: FSF
Message-ID: <4B8C2E68.3020507@gnu.org>
Reply-To: bkorb@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmCxf-0005Te-J5
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab0CAVP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:15:26 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:46418 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0CAVP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:15:26 -0500
Received: by bwz4 with SMTP id 4so2197569bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :reply-to:organization:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=1fnmJEWym3HFruVMzlDrT9X+EfdyRnex1HXxRSpVPpQ=;
        b=jnVIdakcwbrcwpmr7SNSYXXtBKnimAS0Pk36qQyLrOO3wKVebqulTSppll6ifcfVdh
         Tkj9UCWqEFwkgh+btjESDGTTH6JCo7GB+63NAoGdY7h2tjuiujmPfQK4BziUc0rfeWED
         zdOHNCdwT3J0hap8OYIvqA2TlOO9A2k0xV/cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:reply-to:organization:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding;
        b=ZKkwlzKyULEVe1rOcPg35LxpfKS42TjKoDUQeYcAOr8Geq/FjgxPebFnYY5mpLGTlJ
         xbJtIwEAhF2NilOXTOysjdaakHe+XvDVqSz0gghUAOrLXjbigxiI1cf5/Vd8DPAjw9/D
         EGCSGQqHdGI+ZZ215JCimn2ytSmPT4TVbwdQI=
Received: by 10.204.151.216 with SMTP id d24mr3551454bkw.1.1267478124101;
        Mon, 01 Mar 2010 13:15:24 -0800 (PST)
Received: from ?10.10.1.101? (adsl-75-0-176-14.dsl.pltn13.sbcglobal.net [75.0.176.14])
        by mx.google.com with ESMTPS id 13sm2361851bwz.7.2010.03.01.13.15.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 13:15:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141348>

Hi,

This message has no meaning at all.  I know it failed to push.
I can tell from the comment "[rejected]".  It would be nice
to know *WHY* it was rejected so I can fix the problem.
How do I determine the cause, please?  Thank you!!  Regards, Bruce

$ git push
To ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen
 ! [rejected]        master -> master (non-fast forward)
error: failed to push some refs to 'ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen'
