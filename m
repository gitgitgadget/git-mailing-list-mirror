From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Mon, 11 Jun 2007 22:40:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706112216520.4059@racer.site>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu>
 <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org>
 <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com>
 <20070509191052.GD3141@spearce.org> <466BAAD0.9060408@vilain.net>
 <alpine.LFD.0.99.0706102144080.12885@xanadu.home> <Pine.LNX.4.64.0706111109430.4059@racer.site>
 <alpine.LFD.0.99.0706110930170.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Steven Grimm <koreth@midwinter.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxrgE-0007ym-Vd
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 23:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbXFKVoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbXFKVoE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 17:44:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:53944 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753423AbXFKVoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 17:44:01 -0400
Received: (qmail invoked by alias); 11 Jun 2007 21:43:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 11 Jun 2007 23:43:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QFr0NyitQVtV+UGNkDseC5zPSC+T+Tm+4m6/EYz
	gOCM9V2PTk/inK
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.99.0706110930170.12885@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49889>

Hi,

On Mon, 11 Jun 2007, Nicolas Pitre wrote:

> But you'd better have a concrete data set and result numbers to convince 
> me.  Designing software for hypothetical situations before they actually 
> exist leads to bloatware.

Right you are. So I'll not mention it until I have it ;-)

Ciao,
Dscho
