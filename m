From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Integrating with hooks
Date: Thu, 15 Nov 2007 01:43:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711150143420.4362@racer.site>
References: <20071113173721.GI25282@penguin.codegnome.org> <fhdane$kfs$1@ger.gmane.org>
 <20071115011837.GD32746@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <nospam@codegnome.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsTmn-0005eM-6m
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 02:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbXKOBoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 20:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbXKOBoS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 20:44:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:50991 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753067AbXKOBoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 20:44:17 -0500
Received: (qmail invoked by alias); 15 Nov 2007 01:44:16 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp052) with SMTP; 15 Nov 2007 02:44:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hd/xxD6uhG4l1zGJDBldp/3ziysUpwllXZebwwM
	Wo++Ef9P+xs+vG
X-X-Sender: gene099@racer.site
In-Reply-To: <20071115011837.GD32746@penguin.codegnome.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65042>

Hi,

On Wed, 14 Nov 2007, Todd A. Jacobs wrote:

> On Wed, Nov 14, 2007 at 12:07:29AM +0100, Jakub Narebski wrote:
> 
> > Take a look at gitattributes(5), namely 'filter' attribute.
> 
> Thanks, I took a look at the man page you suggested. The "ident" feature 
> almost does what I want, but doesn't seem to take any sort of format 
> string.

Note that the ident feature will give you _only_ the blob sha1.  

I guess that you're more interested in the export-subst feature.

Hth,
Dscho
