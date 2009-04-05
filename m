From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 01:45:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904060141190.10279@pacific.mpi-cbg.de>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>  <200904052358.53028.markus.heidelberg@web.de> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>  <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqc1O-0007vv-6j
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbZDEXnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 19:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbZDEXnQ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:43:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:48507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753979AbZDEXnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:43:16 -0400
Received: (qmail invoked by alias); 05 Apr 2009 23:43:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 06 Apr 2009 01:43:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zVydAL53zq1xQD77mIY+LQWOVa9trJ+woL/AMRN
	5/pjjIevwz4590
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115741>

Hi,

On Mon, 6 Apr 2009, Sverre Rabbelier wrote:

> On Mon, Apr 6, 2009 at 01:17, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > Felipe Contreras, 06.04.2009:
> >> But actually, "git diff --cached" is a different action; you can't do 
> >> "git diff --cached HEAD^.." for example.
> >
> > And I neither could I do "git stage diff HEAD^.."
> 
> I rest my case ;). That's the whole point Felipe is trying to make here.
> $ git diff --cached
> $ git diff HEAD^..
> 
> [...]

Could you post at some stage what the current state of this discussion is, 
so that people who do not have time to read all those mails, let alone 
fire off 10+ mails per hour, can comment about their view of things?

So far, it seems that the view of only a handful is represented in that 
thread.

Thanks,
Dscho
