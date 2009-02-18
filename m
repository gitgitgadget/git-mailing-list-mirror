From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test suite: correct export var=val usage
Date: Wed, 18 Feb 2009 14:34:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181433550.6274@intel-tinevez-2-302>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>  <1234911457-37188-1-git-send-email-jaysoffian@gmail.com>  <0E74A2BF-1E59-4D82-A750-380697667F10@wincent.com>  <76718490902180519s3b5f4469m391aa34456059d37@mail.gmail.com>
 <76718490902180529w7520ba64kb7d0d6b284b406bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:36:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmb8-0005ef-CA
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbZBRNez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbZBRNey
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:34:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:39885 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751753AbZBRNey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:34:54 -0500
Received: (qmail invoked by alias); 18 Feb 2009 13:34:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 18 Feb 2009 14:34:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JM0A8i3WJX0d8rr8SbX9fEmn1LfwKydTbNeJNJJ
	GK/W6ESNqO1G4x
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490902180529w7520ba64kb7d0d6b284b406bd@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110539>

Hi,

On Wed, 18 Feb 2009, Jay Soffian wrote:

> On Wed, Feb 18, 2009 at 8:19 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> > On Wed, Feb 18, 2009 at 5:06 AM, Wincent Colaiuta <win@wincent.com> wrote:
> >> Perhaps my eyes are playing tricks on me but I see the original version
> >> setting MSG to an empty string and exporting it, and your version setting
> >> MSG to "1" and exporting it. So which one is wrong? The original or yours?
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/109897/focus=110462
> 
> Rather, http://thread.gmane.org/gmane.comp.version-control.git/109897/focus=110457
> 
> (Cursed frame interface.)
> 
> (The original is wrong.)

Maybe the time would be better spent paraphrasing the gist of the thread, 
instead of cursing?

Besides, where du you find a curses interface to gmane?

:-)

Ciao,
Dscho
