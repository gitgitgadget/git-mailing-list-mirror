From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 16:05:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003221602100.7596@pacific.mpi-cbg.de>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>  <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>  <4BA544FC.7050007@gmail.com>  <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>  <4BA61CF9.7040104@gmail.com>
  <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>  <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>  <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>  <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
 <81b0412b1003220339n80ab38bh9e1a70c197538ac2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>, gitzilla@gmail.com,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 16:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtjBy-0006GC-Ex
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 16:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab0CVPFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 11:05:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:38095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750967Ab0CVPFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 11:05:14 -0400
Received: (qmail invoked by alias); 22 Mar 2010 15:05:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 22 Mar 2010 16:05:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CNc4KclrCqbIw1eFcFrZv2pPwRTLe5/tRIJNbLl
	pA5a5QR3U4GH1s
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b1003220339n80ab38bh9e1a70c197538ac2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142938>

Hi,

On Mon, 22 Mar 2010, Alex Riesen wrote:

> On Mon, Mar 22, 2010 at 06:32, Junio C Hamano <gitster@pobox.com> wrote:
> > While I don't seriously buy "multiple files" either, if that is really
> 
> yeah, _really_

Yes. Besides, it is an easy fall-out of the common "a Java class was split 
into two" case, where you follow line ranges in different files (at least 
at some stage) _anyway_.

Ciao,
Dscho
