From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch,
 not .txt
Date: Thu, 18 Jan 2007 15:49:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181547440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com> 
 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com> 
 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>  <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
  <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> 
 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>  <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
  <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com> 
 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com> 
 <45AF7FE8.5060003@op5.se> <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 15:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Ya6-0000Zk-Sv
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbXAROtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 09:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbXAROtb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:49:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:55862 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752054AbXAROta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:49:30 -0500
Received: (qmail invoked by alias); 18 Jan 2007 14:49:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 18 Jan 2007 15:49:28 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37097>

Hi,

On Thu, 18 Jan 2007, Alex Riesen wrote:

> [discussion about suffix being "patch" or "txt" per default]
>
> BTW, Junio, how about making the _default_ settable at compile time?
> It'd be reasonable to allow local installations choose to default to what
> they find the most paranoid?

Better control that with templates.

Ciao,
Dscho
