From: Jonathan Duncan <jonathan@memoryties.com>
Subject: Re: Wrong code on master
Date: Fri, 23 Dec 2011 23:37:47 -0700
Message-ID: <354A93E2-42C7-423D-BE99-1FDCF511741A@memoryties.com>
References: <36BFCDA4-8249-4965-877F-FFC9EA65C7EE@memoryties.com> <op.v6zbsrvi0aolir@keputer>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 24 07:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReLFI-0004vM-VR
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 07:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab1LXGhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 01:37:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62388 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab1LXGhw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2011 01:37:52 -0500
Received: by iaeh11 with SMTP id h11so16168329iae.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 22:37:52 -0800 (PST)
Received: by 10.50.180.130 with SMTP id do2mr17198989igc.23.1324708672137;
        Fri, 23 Dec 2011 22:37:52 -0800 (PST)
Received: from [10.0.7.3] (c-76-27-42-247.hsd1.ut.comcast.net. [76.27.42.247])
        by mx.google.com with ESMTPS id t5sm34738253igb.4.2011.12.23.22.37.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Dec 2011 22:37:51 -0800 (PST)
In-Reply-To: <op.v6zbsrvi0aolir@keputer>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187655>


On 23 Dec 2011, at 22:49, Frans Klaver wrote:

> Well, the proper way is to revert the commits. That won't result in all other developers having to deal with a force-updated branch. If you can deal with it you can always
> 
> $ git push origin +branch
> 
> but I wouldn't consider that a nice thing to do.

Good information, thank you.  I think I will mark this as a good learning experience for me.  I will make it a point to inform all my team members to work from branches until we are ready for merging to the master branch.