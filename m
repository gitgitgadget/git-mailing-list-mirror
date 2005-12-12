From: Bahadir Balban <bahadir.balban@gmail.com>
Subject: patches between commits
Date: Mon, 12 Dec 2005 15:31:12 +0000
Message-ID: <7ac1e90c0512120731g3eacdcf0s7e9d1226c88dce73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Dec 12 16:33:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elpe4-0004Fo-RE
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 16:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVLLPbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 10:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVLLPbS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 10:31:18 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:56330 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750789AbVLLPbR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 10:31:17 -0500
Received: by nproxy.gmail.com with SMTP id l35so496193nfa
        for <git@vger.kernel.org>; Mon, 12 Dec 2005 07:31:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iR5MeLiBP8yfW9VIdeXjo54aFtfAufteLEy0+rIqVDkyDqljzdy+BTtbqLV8nvxiGjIPZm6d7ViCfs4PjiN7tSug13BHbSDKtbTtcDrpSS2pCXvRfBWNjLuIBr7Zf126hd68E7LKo/ZWf6cy18zFhlY3bQtZ4bXgQXoFRAny8hU=
Received: by 10.49.2.9 with SMTP id e9mr895641nfi;
        Mon, 12 Dec 2005 07:31:13 -0800 (PST)
Received: by 10.49.5.2 with HTTP; Mon, 12 Dec 2005 07:31:12 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13520>

Hi,

A very basic question - how could I generate patches across different commits?

Suppose I have a HEAD branch, which is the latest. And I want to
generate `individual' patches for each commit I did since the
beginning of development for this branch.

Secondly, is the sha1 of a tree what appears next to each commit when
I type git-log? Is this the only command that lets us know the sha1's
of commits?

Thanks,
Bahadir
