From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [SoC RFC] about "restartable clone"
Date: Sun, 15 Feb 2009 20:37:14 +0900
Message-ID: <20090215203714.6117@nanako3.lavabit.com>
References: <1dacb48d0902131838i3a717ec9r96d8ae8224f7bc66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Henry Huang <henry.s.huang@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 12:41:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYfND-0003My-K2
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 12:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbZBOLhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 06:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbZBOLhm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 06:37:42 -0500
Received: from karen.lavabit.com ([72.249.41.33]:33850 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbZBOLhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 06:37:41 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id EFBAC11B8C0;
	Sun, 15 Feb 2009 05:37:40 -0600 (CST)
Received: from 8371.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id LN7AVBL0NR3O; Sun, 15 Feb 2009 05:37:40 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=2wmLuFHUaW0ckIQv+ulfaBnz74mUErCbo0bzlp7hLF78uduvH3Q5ofurzJpShRowMXNGDiq9YKe6GHtTDnVkOVwGIV4bqTkaojAAr05EFO+mgCphs1nq85mg0Zw6erahNMR/HMhb4oShG1vaBXblzhN7pPEBXnnsktBi+NO55Dk=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1dacb48d0902131838i3a717ec9r96d8ae8224f7bc66@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109995>

Quoting Henry Huang <henry.s.huang@gmail.com>:

> Now i have several problems:
>
> 1) Less familiar with git source code
> 2) Less experience in Open Source Development
> 3) No proposal for this project
>
> My questions:
>
> 1) Are there any documents for git's internals ?-- (.git/ structure,
> data structures: DAG of objects,
> branches, tags, index etc.) and workflow of main operations
>
> 2) Could anyone give me some hints -- where to begin with this project?

A good starting point would be to download the source and look at the files in Documentation directory, including its technical subdirectory. The information in these files would answer large part of your questions in 1).

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
