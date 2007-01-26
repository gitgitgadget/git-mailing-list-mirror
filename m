From: Gerrit Pape <pape@smarden.org>
Subject: Re: cvsimport/cvsps: wrong revisions in branch
Date: Fri, 26 Jan 2007 09:00:06 +0000
Message-ID: <20070126090006.10943.qmail@2a614a0300a3c0.315fe32.mid.smarden.org>
References: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org> <45B8C032.7020004@fs.ei.tum.de> <46a038f90701251806k719dd35p7b13fe049b9cf25c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 09:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMw3-0004MR-Ob
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 09:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030822AbXAZI7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 03:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030838AbXAZI7t
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 03:59:49 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:54877 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1030822AbXAZI7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 03:59:48 -0500
Received: (qmail 10944 invoked by uid 1000); 26 Jan 2007 09:00:06 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90701251806k719dd35p7b13fe049b9cf25c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37815>

On Fri, Jan 26, 2007 at 03:06:19PM +1300, Martin Langhoff wrote:
> The other option is to use cvs2svn, which is the most conservative and
> careful importer around, and most likely to be able to deal with your
> insane tags. And then git-svnimport right after ;-)

We tried that already, cvs2svn did manage the tags and branches
correctly, but then git-svnimport had the same problems.

Thanks, Gerrit.
