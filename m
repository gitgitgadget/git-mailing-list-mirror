From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Distribution size
Date: Sat, 26 Sep 2009 13:22:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909261320370.4985@pacific.mpi-cbg.de>
References: <1253962653-sup-1882@nixos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 26 13:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrVKK-0005cF-QY
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 13:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbZIZLUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 07:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbZIZLUX
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 07:20:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:53908 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbZIZLUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 07:20:22 -0400
Received: (qmail invoked by alias); 26 Sep 2009 11:20:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 26 Sep 2009 13:20:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Be1xl7AvBEyVUegN8Pr0TyzRIvDV3gIVu8WVB12
	rmZhEIfHbkB8fT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1253962653-sup-1882@nixos>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129149>

Hi,

On Sat, 26 Sep 2009, Marc Weber wrote:

> Has anyone thought about reducing distribution size ?
> 
> comparison:
> 
> git-1.6.4.4 i%du -hs .
> 115M    .

Funny.  Git for Windows is less than 12MB [*1*].  And it includes a bash 
and Perl.  (Did you count Python on Windows?)

So maybe your analysis is severely borked.

Ciao,
Dscho

[*1*]: See http://msysgit.googlecode.com/
