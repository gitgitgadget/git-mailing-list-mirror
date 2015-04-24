From: Scott Meyer <dutchlab@gmail.com>
Subject: URL not displaying change made with git.
Date: Fri, 24 Apr 2015 08:22:18 -0400
Message-ID: <CAKXTx=1g6eBR1hR9vsQohjp2nCjd=gGU=embAzfQhp6JKZNyWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 14:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylcci-0001G2-C0
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 14:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbbDXMWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 08:22:19 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34133 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbbDXMWT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 08:22:19 -0400
Received: by pdbqa5 with SMTP id qa5so47536239pdb.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=AKuGs2qmu+i9U1A4vmDDvG9l1jB9oA5SJbIGt9Rmlfs=;
        b=Gzwhwql9qEGRDpolL5PDxaACWqCzy3TXjmlS+YfoHA5PQf7d9t3agYRY/s3CCZ1Ar7
         mbhi3ra4iX8DPqFq/9iJoXk+ssLvthjssboM1afB8ZsOXSl0uZm1IdxBqTIHlPkPqc+o
         jJGRuXGO0+ItkWCDQF9BmP/JE9FYeVgKWCkrPrDkryI9w3DF9tkXzfuCO04un47LgepJ
         31yWulF2acoG/2ZGn0sZfBfuReB7X1K2r51fffCmQ7SMcP21I4FKwtRMXLs1KvrW4Tke
         xxRXjq81njtG5/bqlX/FbwVGuyNrtGVkINIRzoAa4qy4FHNkA4YWcKOY4hu7CYLb/h/b
         3FZg==
X-Received: by 10.68.191.229 with SMTP id hb5mr14449857pbc.126.1429878138818;
 Fri, 24 Apr 2015 05:22:18 -0700 (PDT)
Received: by 10.70.75.9 with HTTP; Fri, 24 Apr 2015 05:22:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267736>

I used git in the following steps.

This is a local directory on a Mac, with Yosemite, using the latest
git version.  The directory name is "development".

using eclipse I created a branch WO_1
I made a change to the file
eclipse indicates the change
I use the plus to add it to the Index
I commit the change
I go to the development directory using the terminal and checkout branch WO_1
using git status shows I am in branch WO_1
I used nano on the file to verify the change is there.

When I use my browser to bring up the site the change is not visible.
I have cleared the cache in the browser and have tried other browsers.

What I am I missing?
