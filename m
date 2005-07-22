From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.8
Date: Fri, 22 Jul 2005 11:37:28 -0700 (PDT)
Message-ID: <20050722183728.93526.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: berkus@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 22 20:39:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw2QX-0003WT-Gl
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 20:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVGVSi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 14:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVGVSh6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 14:37:58 -0400
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:45174 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262131AbVGVShg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 14:37:36 -0400
Received: (qmail 93528 invoked by uid 60001); 22 Jul 2005 18:37:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hRqWx2gl+FMPfA/hpzeS8XcC/woSgTw7Xw+qAtjuyUgG0hBd9RwT1LfQ8hXv3cFvrn4lIuun1xwthTauUzuqLIL5XbXUycJQ7CFJWIFkkaRVDZ6fhqe8agKe7GUUePeuzt4tFIdqI+9z0ryOjjYNJNi0YasxR1OpgDJax05/Xa8=  ;
Received: from [151.42.110.245] by web26309.mail.ukl.yahoo.com via HTTP; Fri, 22 Jul 2005 11:37:28 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

  here is qgit-0.8:

    http://prdownloads.sourceforge.net/qgit/qgit-0.8.tar.bz2?download


This release shows a big GUI rewrite with added menus, 
buttons, help, settings page, etc.

Some new features:

- Possibility to view diffs against current checked-out tree, i.e
  GUI interface to git-diff-cache. 
  Defaut is off, change it from menu->settings.

- GUI interface to git-format-patch-script with options in settings page

- Right click on an empty lane shows childs and parent in a pop-up 
  with 'jump to' on select

- Make install/uninstall support (thanks to Stanislav Karchebny)

- Separation of groups of files by two empty lines in case of merges


See changelog for a complete list of changes

I have updated some screens too:

    https://sourceforge.net/project/screenshots.php?group_id=139897



Marco




		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
