From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Wed, 11 Oct 2006 16:00:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610111559060.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
 <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
 <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE> <7viriwsa75.fsf@assigned-by-dhcp.cox.net>
 <eg82tq$2uq$1@sea.gmane.org> <Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061007223023.GI20017@pasky.or.cz> <Pine.LNX.4.63.0610080034490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqonpfyl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP053FFB92C509E9427F85B0AE110@CEZ.ICE>
 <7vfydyinto.fsf@assigned-by-dhcp.cox.net> <loom.20061011T140959-200@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 16:03:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXedO-0002jl-PT
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 16:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWJKOAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 10:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWJKOAb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 10:00:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:25527 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161052AbWJKOAb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 10:00:31 -0400
Received: (qmail invoked by alias); 11 Oct 2006 14:00:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 11 Oct 2006 16:00:29 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
In-Reply-To: <loom.20061011T140959-200@post.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28715>

Hi,

On Wed, 11 Oct 2006, Panagiotis Issaris wrote:

> Hi,
> 
> Junio C Hamano <junkio <at> cox.net> writes:
> >[...]
> > And even for an isolated group where everybody knows that
> > everybody else runs DAV-enabled clients, they need info/refs
> > prepared for ls-remote and git-fetch script, which means you
> > will run update-server-info to keep objects/info/packs up to
> > date.
> This patch worked excellent for me. Thanks! :) Any chance this might 
> make it into your tree?

It already is: adc446fe5d5f6dc1fb5edeaa9aa016ef94e70da1 from Sun Oct 8 
12:56:19 2006 -0700 in branch 'next'.

Hth,
Dscho
