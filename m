From: Gerrit Pape <pape@smarden.org>
Subject: Re: git-svn: libsvn-perl_1.4.4 and do_switch()
Date: Wed, 4 Jul 2007 08:04:34 +0000
Message-ID: <20070704080434.1706.qmail@594e8b6be24871.315fe32.mid.smarden.org>
References: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 10:04:37 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5zql-0001Wa-3Z
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 10:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbXGDIEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 04:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755267AbXGDIEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 04:04:16 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:57770 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754545AbXGDIEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 04:04:14 -0400
Received: (qmail 1707 invoked by uid 1000); 4 Jul 2007 08:04:34 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51578>

On Tue, Jun 26, 2007 at 01:37:04PM +0000, Gerrit Pape wrote:
> Hi, on Debian unstable the current version of libsvn-perl is 1.4.4dfsg1.
> With this version git-svn uses do_switch instead of do_update, which
> seems to not work properly, please see
> 
>  http://bugs.debian.org/430091
> 
> on how to reproduce the problem.

Hi, more people ran into this problem, and reported through
 http://bugs.debian.org/430091
  
Can anyone confirm that this is a bug in subversion 1.4.4, or is it a
bug in git-svn?

Thanks, Gerrit.
