From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Documentation call for help
Date: Fri, 09 Sep 2005 11:11:34 -0400
Message-ID: <4321A626.9040400@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 09 17:15:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDkXc-0000O0-Kg
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 17:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVIIPLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 11:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVIIPLi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 11:11:38 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:39772 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932557AbVIIPLi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 11:11:38 -0400
Received: by wproxy.gmail.com with SMTP id 57so1522460wri
        for <git@vger.kernel.org>; Fri, 09 Sep 2005 08:11:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=rolJP8NxRD2c3faU3sgUmbfVDL1aC7ZnTMI+6jNn2RW2CH4IBkuMt3L9SXZHcg2D6XZWu/HHLC/s6WYPd10UFqgLaTkrdjCVI+6s19LTDh9X0K4db14OsE2ZUP1vf6g7xTGVNbsn9fPxMD5u+5rji1EdmrXMXRxd/AVzNDEtiko=
Received: by 10.54.71.12 with SMTP id t12mr370216wra;
        Fri, 09 Sep 2005 08:11:37 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 28sm1412618wrl.2005.09.09.08.11.36;
        Fri, 09 Sep 2005 08:11:37 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8240>

The good news:

There is now some usable documentation for all the git commands except 
for the following:

	git-archimport	(Martin?)
	gitk		(Paul?)


The bad news:

Some, if not most, of the command documentation is incomplete or 
possibly incorrect. Mostly it's a case of the documentation not keeping 
pace with changes in the code.

You can help by comparing the implementation of a command with it's 
documentation and producing a patch to fix or, at least, improve the 
documentation.
