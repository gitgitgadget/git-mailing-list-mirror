From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix checkout of large files to network shares under
 Windows XP
Date: Tue, 20 Apr 2010 11:15:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1004201114150.7651@pacific.mpi-cbg.de>
References: <4BCC5083.30801@gmail.com> <7vaaszqinh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 11:15:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O49YL-0002pG-FC
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 11:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0DTJP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 05:15:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:44110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753833Ab0DTJP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 05:15:27 -0400
Received: (qmail invoked by alias); 20 Apr 2010 09:15:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 20 Apr 2010 11:15:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198hrEZMN58otxSt/klOBW3MkzoF2HFX7jKui8PqC
	2UhCjFZk/4GWeb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vaaszqinh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.69999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145359>

Hi,

On Mon, 19 Apr 2010, Junio C Hamano wrote:

> Dscho, I saw that you are planning to queue this to your tree; would it 
> make your job easier if I queue this myself now, or if I refrain from 
> queueing this myself and instead wait for you to tell me to pull or 
> apply?

It seems to be contested still, but I have no problem with cooking it in 
devel directly.

Ciao,
Dscho
