From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: strange error while pushing
Date: Mon, 14 Dec 2009 12:35:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912141235090.4985@pacific.mpi-cbg.de>
References: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com>  <20091213230214.GA27365@sigill.intra.peff.net> <40aa078e0912131508y79815bej6290c0848aa9f9cf@mail.gmail.com> <fabb9a1e0912131601q71dcb4c4h2fafa03df14be3c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: kusmabite@gmail.com, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 12:31:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK997-0005Gm-DY
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 12:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915AbZLNLbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 06:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756904AbZLNLbQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 06:31:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:47057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756902AbZLNLbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 06:31:16 -0500
Received: (qmail invoked by alias); 14 Dec 2009 11:31:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 14 Dec 2009 12:31:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/t5FBSSavtZH3OjNL4JuxHz7m3FvVaQVMD+mNauV
	bXHce25Rt1bgLR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0912131601q71dcb4c4h2fafa03df14be3c1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135199>

Hi,

On Mon, 14 Dec 2009, Sverre Rabbelier wrote:

> On Mon, Dec 14, 2009 at 00:08, Erik Faye-Lund <kusmabite@googlemail.com> 
> wrote:
> > Simple, I was pushing git from a directory with a recent git-binary, 
> > when my *installed* git was v1.6.4
> 
> Isn't this the reason most people don't have "." in their PATH? :P

Try removing "." from the PATH on Windows... to spare you some cycles: it 
is in PATH _implicitly_.  You cannot remove it from ".", even if you try 
hard.

Ciao,
Dscho
