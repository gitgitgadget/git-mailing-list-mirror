From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: contrib/ status
Date: Tue, 4 Jul 2006 13:43:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607041342150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200607030156.50455.jnareb@gmail.com> <200607030202.55919.jnareb@gmail.com>
 <7vodw7zgt2.fsf@assigned-by-dhcp.cox.net> <e89ock$gks$1@sea.gmane.org>
 <7vslljwiat.fsf@assigned-by-dhcp.cox.net> <7vmzbrwi3c.fsf_-_@assigned-by-dhcp.cox.net>
 <e8dj9u$asn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 13:43:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxjJh-0007Hh-PR
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWGDLnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWGDLnh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:43:37 -0400
Received: from mail.gmx.net ([213.165.64.21]:13209 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932218AbWGDLng (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 07:43:36 -0400
Received: (qmail invoked by alias); 04 Jul 2006 11:43:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 04 Jul 2006 13:43:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e8dj9u$asn$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23291>

Hi,

On Tue, 4 Jul 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > OTOH I haven't seen much interest in contrib/colordiff, now
> > Johannes's built-in "diff --color" is in.  So if people do not
> > mind, I'd like to drop it.
> 
> Since when, and is it documented? 

To your first question:

	commit cd112cef999c59a7ca2a96c37b197d303a355924
	Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
	Date:   Tue Jun 13 18:45:44 2006 +0200

	    diff options: add --color

To the second:

	No.

;-) It should be in diff-options.txt, but then you would have to document 
the config variables to change the color, too, so I'll leave that task to 
somebody else and go back to work...

Ciao,
Dscho
