From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig
 for git-format-patch.
Date: Sun, 8 Feb 2009 18:28:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org, mozeditor@floppymoose.com,
	ben.bucksch@beonex.com
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 18:29:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWDTZ-0005VV-7L
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 18:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZBHR2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 12:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbZBHR2V
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 12:28:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:55551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752336AbZBHR2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 12:28:20 -0500
Received: (qmail invoked by alias); 08 Feb 2009 17:28:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 08 Feb 2009 18:28:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u/S8EZZ7ukWyigzvAbZBpwJsHhEYkPrjKVtG3qg
	YfPxNx1n/iaEyW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <498F01C2.5080105@codeweavers.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108993>

Hi,

On Sun, 8 Feb 2009, Jeremy White wrote:

> As an aside, there is a long (and discouraging) read about the issue
> with Thunderbird here:
>   https://bugzilla.mozilla.org/show_bug.cgi?id=141983
> 
> Essentially, the problem is well understood - Thunderbird uses
> format=flowed by default, which is what mangles the patches.  The author
> of the relevant code is unmoved by arguments that the default should
> switch, and no one has yet been willing to create a simpler UI for
> switching the setting.

I guess I'll start discouraging use of Thunderbird from now on.  Seems 
that not even the opposition of a guy named Andrew Morton was clue bat 
enough.

Ciao,
Dscho
