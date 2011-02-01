From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] Consistent use of AC_LANG_PROGRAM in configure.ac and
 aclocal.m4.
Date: Tue, 1 Feb 2011 20:39:27 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110201193927.GA1634@gmx.de>
References: <20110102060044.GJ19818@gmx.de>
 <20110102075953.GB8937@burratino>
 <20110102094730.GA10365@gmx.de>
 <20110102100012.GA12284@burratino>
 <20110102102455.GD10365@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 01 20:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkM4h-0006H9-OW
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 20:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892Ab1BATjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 14:39:32 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:57563 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751480Ab1BATjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 14:39:31 -0500
Received: (qmail invoked by alias); 01 Feb 2011 19:39:29 -0000
Received: from xdsl-89-0-157-18.netcologne.de (EHLO localhost.localdomain) [89.0.157.18]
  by mail.gmx.net (mp039) with SMTP; 01 Feb 2011 20:39:29 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX1/tsoI+xAjthpqBzuCVRfD9hArUsUoZveY7RZ3UNj
	zZ3KMxf0uAtPie
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1PkM4V-0000SN-OQ; Tue, 01 Feb 2011 20:39:27 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110102102455.GD10365@gmx.de>
User-Agent: Mutt/1.5.20 (2010-08-04)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165848>

* Ralf Wildenhues wrote on Sun, Jan 02, 2011 at 11:24:55AM CET:
> This avoids warnings from Autoconf 2.68 about missing use of
> AC_LANG_PROGRAM and friends.

I'd like to ping this patch:
http://thread.gmane.org/gmane.comp.version-control.git/164409/focus=164416

which IIUC addresses all previous comments in the thread and was
otherwise noncontroversial.  If there is anything else left to do,
I'd be happy to hear about it.

Thanks,
Ralf
