From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: First dumb question to the list :)
Date: Thu, 16 Mar 2006 18:49:16 +0100
Message-ID: <4d8e3fd30603160949l655c4f9blb1e202eaf22fbfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Mar 16 18:50:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJwbC-0003Mh-GV
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 18:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbWCPRtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 12:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbWCPRtS
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 12:49:18 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:17113 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752451AbWCPRtS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 12:49:18 -0500
Received: by xproxy.gmail.com with SMTP id i30so310927wxd
        for <git@vger.kernel.org>; Thu, 16 Mar 2006 09:49:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f9FS2cPVFTOv6a30vUL9Qp6/WeVmf9+KNAoBnlV3/MdW1rK44Q1hGkezguZEiNIFgmrDZJ27dj6NDp5cn6hzht3Z2h8LcjUvDXEuXA/fh/bgdrj+WOhBToK1o+44SK0W8bXYStinMWJ5uAnrCi45AsW5iBzJDoZbDZfWY0Wvync=
Received: by 10.70.90.16 with SMTP id n16mr2348942wxb;
        Thu, 16 Mar 2006 09:49:16 -0800 (PST)
Received: by 10.70.69.16 with HTTP; Thu, 16 Mar 2006 09:49:16 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17643>

Hi all,
I just installed git and cogito from Ubuntu Drapper,
performed a simple cg-clone git://URItoLinus2.6 linux2.6
and aftwer more or less one hour I had a clone of Linus 2.6 tree.
So far so good.

What I want to do is to simply keep my repository aligned with Linus
so I simply have to do:
cd linus2.6
cg-fetch

How can I confg git in order to, by default,  use git instead of rsync ?

Now my dumb question is... since I want to build that kernel do I have
to locally clone/copy it in order to don't modify any file on my local
tree?
If I don't do so, I guess git/cogito will not be happy when I run
cg-fetch, right?

Thanks!

--
Paolo
