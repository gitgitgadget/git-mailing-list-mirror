From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to share config and hooks ?
Date: Wed, 27 May 2009 22:11:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905272209480.26154@pacific.mpi-cbg.de>
References: <4A1D9B4C.7030504@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian Senkowski <csenkowski@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 27 22:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9PSf-0002WQ-9T
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 22:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758243AbZE0UKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 16:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbZE0UKh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 16:10:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:37513 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182AbZE0UKh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 16:10:37 -0400
Received: (qmail invoked by alias); 27 May 2009 20:10:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 27 May 2009 22:10:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yMR9QANXykYUWO9LuM6JaE6QHMT6rvbd9G+O3Ne
	2WqdeyNrs+vCPM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A1D9B4C.7030504@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120099>

Hi,

On Wed, 27 May 2009, Christian Senkowski wrote:

> I am searching for a way to share 'config' and hooks/* automatically.
> I'd like to change and commit them as normal files and every user
> cloning this repo should get those.

For security reasons, both are not possible.

Why?  I am sure you can come up with a lot of evil scenarios if you let 
your evil side fantasize a little bit.

Ciao,
Dscho
