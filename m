From: Alex Bennee <kernel-hacker@bennee.com>
Subject: What is the current best bi-directional git<->bzr method?
Date: Tue, 19 May 2009 15:08:22 +0100
Message-ID: <b2cdc9f30905190708t1e170106oce3c577933c99247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 16:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Pzc-0006bL-OL
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 16:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbZESOIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 10:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZESOIW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 10:08:22 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:58551 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZESOIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 10:08:22 -0400
Received: by gxk10 with SMTP id 10so7515893gxk.13
        for <git@vger.kernel.org>; Tue, 19 May 2009 07:08:22 -0700 (PDT)
Received: by 10.90.53.4 with SMTP id b4mr54711aga.111.1242742102720; Tue, 19 
	May 2009 07:08:22 -0700 (PDT)
X-Google-Sender-Auth: 99e5e11b27c26621
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119531>

Hi,

I'm starting to mess around with project on Launchpad which are all
hosted with bzr. Short of convincing these projects to switch DVCS
just for me I need a decent bi-directional way of dealing with bzr
archives.

I found a script[1] which I have hacked a bit[2] to import repo's
fine. However going the other way doesn't seem to work. Before I mess
around too much further I though I'd check if there are any known
working gateways at the moment?

[1] http://github.com/pieter/git-bzr/tree/master
[2] http://github.com/stsquad/git-bzr/tree/master

-- 
Alex, homepage: http://www.bennee.com/~alex/
CV: http://www.bennee.com/~alex/cv.php
