From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Hosting from Windows XP.
Date: Mon, 26 Jan 2009 17:45:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261744240.25749@intel-tinevez-2-302>
References: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUcA-0007Sb-Gi
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbZAZQpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbZAZQpp
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:45:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:40852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751582AbZAZQpo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:45:44 -0500
Received: (qmail invoked by alias); 26 Jan 2009 16:45:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 26 Jan 2009 17:45:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UC0dPbiJUM/Fdob9lDvZlziePAbjO0XrS1ZDmeM
	c7NrEUx2qnacVK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107232>

Hi,

On Mon, 26 Jan 2009, Tim Visher wrote:

> I may totally be missing something here, but I don't know what.  Short 
> of the question is, how do I host a repo out of Windows?

Use a net share.  Use the native permission system to restrict/open up the 
repository for certain people to read from/write to.

Ciao,
Dscho
