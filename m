From: Yann Dirson <ydirson@altern.org>
Subject: Re: 'git svn fetch' keeps giving a error after freezing
Date: Thu, 9 Jul 2009 11:34:12 +0200
Message-ID: <20090709093412.GA30076@nan92-1-81-57-214-146.fbx.proxad.net>
References: <h31vg6$b38$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 11:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOq0w-0008Ps-4X
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 11:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbZGIJd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 05:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbZGIJd4
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 05:33:56 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58223 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532AbZGIJdz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 05:33:55 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 79BBC94019E;
	Thu,  9 Jul 2009 11:33:46 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 949419401C6;
	Thu,  9 Jul 2009 11:33:44 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 29400A003; Thu,  9 Jul 2009 11:34:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <h31vg6$b38$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122961>

I ran an "svn clone -s http://svn2.freepascal.org/svn/fpc" yesterday,
and it went through all 13373 revs without a problem.  The freeze you
talk about must have done something weird to the git-svn metadata.
