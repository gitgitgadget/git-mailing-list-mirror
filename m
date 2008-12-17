From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 13:08:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812171307460.28560@intel-tinevez-2-302>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com> <7vej07p84i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Ryden <markryde@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvDf-0003Ud-7a
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbYLQMIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbYLQMIU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:08:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:48483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbYLQMIT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:08:19 -0500
Received: (qmail invoked by alias); 17 Dec 2008 12:08:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp035) with SMTP; 17 Dec 2008 13:08:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TxowYuYSTGqLcP54ktrmwH9ummgZsAhrducbEk4
	YxbYk7QjLz4r6N
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vej07p84i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103336>

Hi,

On Tue, 16 Dec 2008, Junio C Hamano wrote:

> "Mark Ryden" <markryde@gmail.com> writes:
> 
> > 2) Is there a way to get some messages about that there are white 
> >    spaces when creating a git patch?
> 
> Doesn't "git diff" highlight whitespace errors?  That way, you can catch 
> errors before you make a commit that has them.

Not to mention "git diff --check", which should catch them, too.

Ciao,
Dscho
