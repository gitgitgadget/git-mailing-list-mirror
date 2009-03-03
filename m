From: Csaba Henk <csaba-ml@creo.hu>
Subject: import files w/ history
Date: Tue, 3 Mar 2009 12:54:54 +0000 (UTC)
Message-ID: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 13:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeUAl-0002bl-1D
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 13:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbZCCMzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 07:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbZCCMzH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 07:55:07 -0500
Received: from main.gmane.org ([80.91.229.2]:59601 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbZCCMzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 07:55:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LeU9G-0001NX-Ha
	for git@vger.kernel.org; Tue, 03 Mar 2009 12:55:02 +0000
Received: from www.creo.hu ([217.113.62.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 12:55:02 +0000
Received: from csaba-ml by www.creo.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 12:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: www.creo.hu
User-Agent: slrn/0.9.8.1 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112068>

Hi,

How could I import some files from an unrelated git repo with history?
And if I'd like to use different paths? Eg:

Say the other repo has these files:

lib/trees/rb_tree.{c,h}

and I want to import them into my repo as

include/rb_tree.h
src/rb_tree.c

(In fact I just have a single file to import and I don't want to
vary paths, yet I'm curious about this extended case, too.)

Thanks,
Csaba
