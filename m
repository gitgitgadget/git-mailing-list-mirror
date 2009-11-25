From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Thu, 26 Nov 2009 00:31:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911260030130.4985@pacific.mpi-cbg.de>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <fabb9a1e0911250656k31229c42jd79fb94c1a619e59@mail.gmail.com>  <7vr5rmwgbn.fsf@alter.siamese.dyndns.org> <fabb9a1e0911251219t3ad0dacen67d8615ef6eefa02@mail.gmail.com>  <7vd436uzet.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911251246l4684f357pb5f379b191aaa64a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:27:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRGN-00072P-KM
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935183AbZKYX04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935125AbZKYX04
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:26:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:39910 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935100AbZKYX0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:26:55 -0500
Received: (qmail invoked by alias); 25 Nov 2009 23:27:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 26 Nov 2009 00:27:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/shMUx8+jsOPOqEcNW3UX3tPiQBJ1n8L7vXCZPkt
	RXLQrZodqPXhj8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0911251246l4684f357pb5f379b191aaa64a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133700>

Hi,

On Wed, 25 Nov 2009, Sverre Rabbelier wrote:

> On Wed, Nov 25, 2009 at 21:23, Junio C Hamano <gitster@pobox.com> wrote:
> > But then you can alias "gr 'grep --full-tree'" with the same ease and 
> > there is no reason to change the default.
> 
> I agree, but then again I'm somewhat biased, as I want the current 
> behavior :P.

You mean like the many people who wanted to keep the dashed commands, but 
unlike who you do speak up _before_ your expectations are broken?

Ciao,
Dscho
