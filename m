From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Sat, 22 Dec 2007 15:33:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712221531110.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> 
 <20071218204623.GC2875@steel.home>  <200712182224.28152.jnareb@gmail.com> 
 <20071218222032.GH2875@steel.home>  <Pine.LNX.4.64.0712182239500.23902@racer.site>
  <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com> 
 <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org> 
 <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com> 
 <Pine.LNX.4.64.0712191334460.23902@racer.site>
 <fcaeb9bf0712210617x2bafa33cp15815a59fc631f45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 15:33:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J65Q4-0006oh-Mj
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 15:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbXLVOdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 09:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbXLVOdR
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 09:33:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:32808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750780AbXLVOdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 09:33:16 -0500
Received: (qmail invoked by alias); 22 Dec 2007 14:33:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 22 Dec 2007 15:33:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ML/47kb1M/y+QIiEK40o6qBEA251DnMBXG5q1DL
	FmumdHLu3yhL73
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0712210617x2bafa33cp15815a59fc631f45@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69135>

Hi,

On Fri, 21 Dec 2007, Nguyen Thai Ngoc Duy wrote:

> [...] from my user perspective, the right approach is to make 
> <treeish>:path always be relative to current directory.

As said by Junio, this would be a bad decision.

BTW please do not quote parts of the email that you do not comment on; it 
takes half a minute of _everybody_ who tries to read your mail, only to 
realise that it was time wasted.

Ciao,
Dscho
