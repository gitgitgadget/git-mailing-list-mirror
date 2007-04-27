From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch
 content
Date: Fri, 27 Apr 2007 15:43:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704271541010.12006@racer.site>
References: <ps5qyry4.fsf@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 15:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhQjx-0004yp-H4
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 15:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbXD0Nne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 09:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755841AbXD0Nne
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 09:43:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:58255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755838AbXD0Nnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 09:43:33 -0400
Received: (qmail invoked by alias); 27 Apr 2007 13:43:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 27 Apr 2007 15:43:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dRgQA/vNdhqUnysckGwIIS5d9EYNAGoZ4TFVYXf
	YGcrvY6buGFM5h
X-X-Sender: gene099@racer.site
In-Reply-To: <ps5qyry4.fsf@cante.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45717>

Hi,

On Fri, 27 Apr 2007, Jari Aalto wrote:

> FEAURE REQUEST
> --------------
> 
> Add sme option to git-format-path to encode thae patch content 
> (MIME/base64)

Although you ask politely, and have a good explanation why you need it, 
there is a strong sentiment in some Git developers (most notably, Git's 
inventor) against this kind of support.

You might have more luck when you decide to implement it yourself, and 
submit it, though (if it is not too intrusive, I see people adding it, if 
only to add even more rope to those willing to hang themselves).

Having said that, I think that you can actually teach every mail app 
(except maybe web-based ones) to respect formatting, including white 
space.

Ciao,
Dscho
