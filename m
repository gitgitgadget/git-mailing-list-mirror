From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch,
 not .txt
Date: Thu, 18 Jan 2007 21:03:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701182101230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com> 
 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com> 
 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com> 
 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com> 
 <45AF7FE8.5060003@op5.se>  <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
  <Pine.LNX.4.63.0701181547440.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0701180653i7cc0c87md7a9c94a10fa3b24@mail.gmail.com> 
 <Pine.LNX.4.63.0701181615360.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0701180737m49895d24td104b8dd2579de44@mail.gmail.com>
 <625fc13d0701180742t703f4f0ei8847c32fe4e0dcfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 21:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7dUP-0007qe-7J
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 21:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbXARUD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 15:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXARUD7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 15:03:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:47738 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932539AbXARUD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 15:03:58 -0500
Received: (qmail invoked by alias); 18 Jan 2007 20:03:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 18 Jan 2007 21:03:57 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <625fc13d0701180742t703f4f0ei8847c32fe4e0dcfd@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37135>

Hi,

On Thu, 18 Jan 2007, Josh Boyer wrote:

> On 1/18/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > The template mechanism can handle _all_ files in GIT_DIR. Just drop a
> > > "config" into the templates directory, and you're settled.
> > 
> > I'm settled! From now on I will never have any objections regarding
> > any defaults as long as they have a config option :)
> 
> Whew.  Cool :)
> 
> Junio, will this go into git at some point soon-ish?  I'm looking
> forward to it...

You mean the templates mechanism? Has been in git since

	v0.99.4~43 (Tue Aug 2 16:45:21 2005 -0700)

Ciao,
Dscho
